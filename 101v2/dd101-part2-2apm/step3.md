Now that our application is instrumented, let's look at the traces in Datadog to see what we can see.

1. Let's start by looking at <a href="https://app.datadoghq.com/apm/map" target="_datadog">our Service Map</a>. Hover over each of the services to see how they are connected.

2. Compare this to <a href="https://app.datadoghq.com/apm/services" target="_datadog">the Service List</a>.

3. Back in the Service Map, click on any of the services. Notice that you have the choice of going to:
    1. Inspect
    1. View service overview
    1. View in App Analytics
    1. View monitors
    1. View related logs
    1. View related processes
    1. View host map

4. Click on **Inspect**. You can see we have now zoomed in to see just this service and services directly related to it. 

5. Go back to the **Service Map** and choose View service overview for one of the services. On this screen we can see some high level metrics (you can change what you are looking at), a latency distribution, and then a list of spans or queries or endpoints or whatever makes sense depending on what you are looking at.

6. As you drill down you will eventually hit the list of traces. Click on one of them. Each trace shows all the services and hosts that were touched by this request, and you can easily identify any bottlenecks, errors, and more.

7. Now visit <a href="https://app.datadoghq.com/apm/app-analytics/traces" target="_datadog">App Analytics</a>. Here we see a list of all traces and we can filter them by a number of facets. For instance, maybe you are looking for traces from a specific service and a specific status code. You can use the facets on the left to further filter the traces. Click on one of the traces, then click one of the items in the details view. Start playing around with what you can do here.

8. Back in **App Analytics**, notice there is a second button next to the search box that looks like a little graph. Here you can display high level aggregated graphs of whatever you are looking at in Search.

9. One final thing to look at is the <a href="https://app.datadoghq.com/apm/settings" target="_datadog">APM Setup & Configuration</a>, which you can find under the APM icon in the nav bar. Here you filter analyzed spans from 100% to a lower percentage on a service-by-service level. See the <a href="https://docs.datadoghq.com/tracing/visualization/#analyzed-span" target="_datadog">docs about analyzed spans</a> to learn how this can reduce your billing.

10. When you are done with this section, run `grademe`{{execute}} to indicate that you are done and ready for assessment. Then click the **Continue** button.
