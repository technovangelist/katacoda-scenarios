Now that we've got the basics for how traces work, it's time to trace our first distributed system.

In our case, we'll use **docker-compose** to load up two Flask APIs, an Agent, and a Redis server. We'll first manually instrument our application, and then see how to enable the distributed tracer in Datadog to automatically instrument our API.
