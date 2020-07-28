# Visualizing our Services

Our code has been set up with instrumentation from Datadog with distributed tracing enabled by default.

Depending on the programming language your applications run in, you may have a different process for instrumenting your code. It's best to look at the [documentation](https://docs.datadoghq.com/tracing/setup/) for your specific language.

In our case, our applications run on [Ruby on Rails](https://docs.datadoghq.com/tracing/setup/ruby/#rails) and Python's [Flask](http://pypi.datadoghq.com/trace/docs/web_integrations.html#flask).

Like we did before, let's re-start our application with that `DD_API_KEY` to enable tracing:

```
$ export DD_API_KEY=<YOUR_API_KEY>
$ POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose -f docker-compose-fixed-instrumented.yml up
```

Once this is up and running, browse to https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/ and begin clicking around the site to generate a bit of traffic.

Now in Datadog, browse the "APM" section on the left starting with the "Services" link. This will show us all of the services including our monolith application.

How do these services relate to each other? Click on the "Map" button at the top left or under "APM" you will see a "Service Map" link. You should see something like the following:

![Service Map](https://raw.githubusercontent.com/DataDog/ecommerce-workshop/master/images/service-map.png)

This is a great visual way to see the state of your services. Each circle represents a service with arrows illustrating their relationship to one another. Our monolith store frontend has quite a few connected services already. Some of these are other applications, but they can be caches, serverless functions, or datastores. Each of the circles is sized relative to their requests per second so you can easily see hot spots in your cluster.

The way Datadog detects these relationships is through a combination of local tracing via APM where each trace has a unique identifier, but also the distributed tracing we talked about with the HTTP connections. By passing the local tracing information through HTTP to the downstream microservices, we can see continued traces and infer relationships between these applications. This would also be a great visual aid for new developers and system administrators to quickly get familiar with your deployments.

Next, let's make this even more useful with monitors so we can keep a closer eye on our expanding service map.

## Adding a Monitor

This visual would be even better with an indicator of their indivudual health. Not only will it help communicate services health to your team, but they can provide uniquely tailored troubleshooting steps for when alerts happen on any of the services.

Let's say our sales team suffered an outage from a bad deploy recently. Mistakes happen, but we can help detect and correct those issues faster if we setup monitors and alerts.

1. Go to the APM -> Services link in Datadog
1. Click on the "discounts-service" in the list
1. At the top, you will see a blue outlined button that says "No Monitors or Synthetic Tests" to click
1. Next you will see a list of suggested monitors so let's enable the "Service discounts service has a high p90 latency on env:ruby-shop"

A great place to start with services when they are separated out is to keep an eye on network latency. Especially when these services cross regional boundaries, network speed will change how you think of software design and behavior.
