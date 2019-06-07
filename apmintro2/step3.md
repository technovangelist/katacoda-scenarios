# Viewing Cross Service Spans

In order to view our cross service spans, we'll first need to generate some more requests, creating new traces to be sent back to Datadog.

Let's do that now:

`curl http://localhost:5000/think/?subject=war`{{execute T2}}

    One is left with the horrible feeling now that war settles nothing; that to win a war is as disastrous as to lose one.Agatha Christie

`curl http://localhost:5000/think/?subject=mankind`{{execute T2}}

    I think that God in creating Man somewhat overestimated his ability.Oscar Wilde

Let's try generating an error in our application:

`curl http://localhost:5000/think/?subject=peace`{{execute T1}}

Now, when we switch over to view our traces in Datadog, we see them coming in as a single span, traversing our microservices.

![](/technovangelist/scenarios/apmintro2/assets/second-thinker-api.png)

But if you looked closely, you'll see that we have a library that can be instrumented by Datadog but isn't.

That's the **requests** library, which is used to send our requests across from one microservice to the other.


