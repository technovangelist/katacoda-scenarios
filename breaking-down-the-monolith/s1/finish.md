# Resources

As you have seen, it is not very hard to instrument your monolith and eventual microservices with Datadog. Why and how you break apart your monolith will have to be a further discussion with your team and organization. While it might add complexity to separate services, in using observability we can better understand these complex systems and make better arguments for their separation.

Things to remember when moving from a Monolith to Microservices:

* Remember that separating services creates network latency at a minimum
* Evaluate your Service Level Objectives with your services often to maintain quality
* Establish clear communication guidelines between teams for existing and new services
* Revisit your services architecture often with the help of all the observability data you collect to guide you to better designs
* Consider what happens in your monolith when services go down because they absolutely will. Can it gracefully handle the error?

Here are some useful resources to check out after this workshop:

* Book: Microservice Architecture by Mike Amundsen and Matt McLarty (ISBN 1491956259)
* Book: Monolith to Microservices by Sam Newman (ISBN 1492047848)
* Research paper: [Pivot Tracing](https://cs.brown.edu/~jcmace/papers/mace15pivot.pdf)
