# Viewing Default Traces Across Systems

To get started, run `./start01`{{execute T1}} in the first terminal tab. Wait for the application to start.

Send a few requests to the application:

`curl http://localhost:5000/think/?subject=war`{{execute T2}}
`curl http://localhost:5000/think/?subject=mankind`{{execute T2}}

Now that a few requests have been sent, we can take a look at the Datadog APM dashboard, and see what's going on with our service.

![Thinker API](/technovangelist/scenarios/apmintro2/assets/first-thinker-api.png)

Looking at the dashboard, it appears our trace - which should be a single trace - is broken out into two separate traces.

Our customer-facing API is hitting the **thinker** microservice, but the trace coming from the **api** service isn't being propagated across both.

By default, Datadog's APM implementation doesn't send or look for the request headers that would go across applications.

This is because traces allow you to pass along potentially private information. It's better if we only pass the headers of our trace along to infrastructure that we know is our own.

Let's walk through adding our trace headers to our APIs, first manually, and then automatically with the **distributed_tracing** flag.

