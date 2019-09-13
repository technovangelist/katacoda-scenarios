Now that our application is instrumented, let's look at the traces in Datadog to see what we can see.

1. Let's start by looking at <a href="https://app.datadoghq.com/apm/map?env=k8s-apm-workshop" target="_datadog">our Service Map</a>. Hover over each of the services to see how they are connected.
2. Compare this to <a href="https://app.datadoghq.com/apm/services" target="_datadog">the Service List</a>.
3. Back in the Service Map, click on any of the services. Notice that you have the choice of going to **Inspect**, **View service overview**, **View in Trace Search and Analytics**, **View monitors**, **View logs**, and **View host map**.
4. Click on Inspect. You can see we have now zoomed in to see just this service and the other services that directly relate. Go back to the overview map and Inspect another service. Notice that there is a Details button to get more detail about whatever you are focused on.
5. Go back to the Service Map and choose View service overview for one of the services. On this screen we can see some high level metrics (you can change what you are looking at), a latency distribution, and then a list of spans or queries or endpoints or whatever makes sense depending on what you are looking at.
6. As you drill down you will eventually hit the list of traces. Click on one of them. Each trace shows all the services and hosts that were touched by this request, and you can easily identify any bottlenecks, errors, and more.
7. Now visit <a href="app.datadoghq.com/apm/search" target="_datadog">Trace Search</a>. Here we see a list of all traces and we can search for any one. For instance, maybe you are looking for a specific error message or customer ID. You can use the filters on the left to further drill in. Click on one of the traces, then click one of the items in the details view. Start playing around with what you can do here.
8. Back in Trace Search, notice there is a second button next to the search box that looks like a little graph. Here you can display high level aggregated graphs of whatever you are looking at in Search.
9. One final thing to look at is the APM settings. Here you can adjust your filtering rate for each service.
