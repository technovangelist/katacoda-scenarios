# Instrumenting Services

To better understand the implications of breaking apart your monolith or identify candidates for a microservice, we will instrument our services.

Datadog instrumentation allows us to get an immediate insight into what's going on with our software systems. Our code has already been set up with instrumentation and distributed tracing enabled by default.

Depending on the programming language your applications run in, you may have a different process for instrumenting your code. It's best to look at the [documentation](https://docs.datadoghq.com/tracing/setup/) for your specific language. Many of our integrations already enable distributed tracing out of the box so you may already have this running with your code now if you use Datadog APM.

## Instrumenting Ruby

Let's browse to the `store-frontend/config/initializers/datadog.rb` file to see that we have enabled the Rails APM integration:

```ruby
Datadog.configure do |c|
  # This will activate auto-instrumentation for Rails
  c.use :rails, {'analytics_enabled': true, 'service_name': 'store-frontend', 'cache_service': 'store-frontend-cache', 'database_service': 'store-frontend-sqlite'}
  # Make sure requests are also instrumented
  c.use :http, {'analytics_enabled': true, 'service_name': 'store-frontend'}
end
```

The `c.use :rails` and `c.use :http` lines automatically instrument our monolith ruby on rails storefront, but it also enables adding a special set of HTTP headers (`x-datadog-trace-id`, `x-datadog-parent-id`, `x-datadog-sampling-priority`) into the native HTTP library by default. This means any HTTP calls sent ore received in our code between our monolith and the advertising or coupon services will include our monolith's tracing identifiers which let us resume traces started in other applications for a given request.

## Instrumenting Python

Our two microservices which are in Python use a binary called `ddtrace-run` which is installed via the `ddtrace` Python package. Our docker configuration launches our Flask application with the `ddtrace-run` application which automatically injects the APM tracing libraries and also provides and listens for the special datadog tracing HTTP headers.

In the `docker-compose-files/docker-compose-fixed-instrumented.yml` file you'll see these environment variables under the advertisements and discounts services:

```yaml
...
  discounts:
    environment:
      - FLASK_APP=discounts.py
      - FLASK_DEBUG=1
...
  advertisements:
    environment:
      - FLASK_APP=ads.py
      - FLASK_DEBUG=1
```

These are special environment variables for the Datadog agent container to launch our Flask application with instrumentation automatically. The `FLASK_DEBUG` variable is optional, but helpful when troubleshooting the initial tracing setup. If we were to do this manually, we would start either of the services in their respective folders with `ddtrace-run flask run --port=5002 --host=0.0.0.0`.

## See it in Action

We can now rerun our applications with our `DD_API_KEY` to enable this by using the following command:

```
$ export DD_API_KEY=<YOUR_API_KEY>
$ POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose -f docker-compose-fixed-instrumented.yml up
```

Once this is up and running, browse to https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/ and begin clicking around the site to generate traffic.

We should start to see tracing and log data come in to Datadog.
