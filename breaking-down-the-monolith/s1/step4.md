# Connecting The Dots

To better understand the implications of breaking apart your monolith or identify candidates for a microservice, we will instrument our services.

Datadog instrumentation allows us to get an immediate insight into what's going on with our software systems. Our code has already been set up with instrumentation and distributed tracing enabled by default.

Depending on the programming language your applications run in, you may have a different process for instrumenting your code. It's best to look at the [documentation](https://docs.datadoghq.com/tracing/setup/) for your specific language. Many of our integrations already enable distributed tracing out of the box so you may already have this running with your code now if you use Datadog APM.

## Instrumenting Ruby

Let's browse to the `store-frontend-instrumented-fixed/store-frontend/config/initializers/datadog.rb`{{open}} file to see that we have enabled the Rails APM integration:

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

Our two microservices which are in Python need to use a binary called `ddtrace-run` which is installed via the `ddtrace` Python package. Our docker configuration needs to be adjusted to launch our Flask application with the `ddtrace-run` binary. This binary automatically injects the APM tracing libraries and also provides and listens for the special datadog tracing HTTP headers.

Head to the `docker-compose-files/docker-compose-fixed-instrumented.yml`{{open}} file in your editor and look for these lines:

```yaml
    ...
    command: flask run --port=5001 --host=0.0.0.0
    ...
```

We need to put the `ddtrace-run` command in front of flask to make sure we instrument the new applications properly.

The new lines should look like this:

```yaml
    ...
    command: ddtrace-run flask run --port=5001 --host=0.0.0.0
    ...
```

Now that we have cleaned that up, let's restart the services so we can start seeing a few traces. You can type or click on `application_reload`{{execute T1}} to do this now which will take a little time.
