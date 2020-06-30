Ideally, all components of the control plane are autodiscovered. That didn't work out for etcd, but that allowed us to see how to setup an integration using Helm. The API Server has been autodiscovered correctly so there is almost nothing we need to do to start working with it. 

1.  Start by verifying that all our pods are up and running: `k get pods -w`{{execute}}. The `-w` command line option means **watch**. Unlike tools like `top`, `k get pods -w` doesn't update each line as information changes, but rather it acts like tailing a log. As the status changes, another line is added. By the time everything is running it might look like you have a dozen datadog-related pods, but you only have two. 
1.  When the main datadogagent pod is fully ready, press `CTRL-C` to quit the process and then get the agent status: `k exec $(k match-name datadogagent-[a-z0-9]{5}) agent status`{{execute}}. 
1.  Scroll up to see what checks are running. You can also take a look at the configcheck command: `k exec $(k match-name datadogagent-[a-z0-9]{5}) agent configcheck`{{execute}}
1.  Now let's create a Timeboard for monitoring the API Server. The first metrics to add are about request rates and latency. There are a number of metrics dealing with this:

    * kube_apiserver.rest_client_requests_total
    * kube_apiserver.rest_client_requests_total.count
    * kube_apiserver.rest_client_request_latency_seconds.sum
    * kube_apiserver.authenticated_user_requests
    * kube_apiserver.rest_client_request_latency_seconds.count
    * kube_apiserver.apiserver_request_count
    * kube_apiserver.apiserver_request_total
    * kube_apiserver.authenticated_user_requests.count
    * kube_apiserver.current_inflight_requests
    * kube_apiserver.apiserver_request_count.count
    * kube_apiserver.apiserver_request_total.count

    * `kube_apiserver.apiserver_request_total` is interesting because its the accumulated number of requests to the API Server, broken down by verb.
    * `kube_apiserver.authenticated_user_requests` breaks down the requests by authenticated user instead of verb.
    * `kube_apiserver.rest_client_request_latency_seconds` then shows what latency is looking like across the requests
    
    You will notice that some of the metrics are deprecated as of version 1.15. They are still available but are likely to be removed at any point in the future, so it would be good to avoid relying on them. 

    Add the three metrics that are called out above into three separate Timeseries widgets. Try out the different ways to visualize the data, such as looking at the count, grouping by verb or user, adding forecasts and so forth.

1. Remember the API Server is a webserver. So also consider looking `docker.container.open_fds`, the various `docker.mem` metrics, and the `kubernetes.cpu` metrics, all filtered down to the tag `short_image:kube-apiserver`.

There are a number of other metrics that come from the API Server you can choose to add to your dashboard. Be sure to take a look at the metrics that deal with Go Threads and Goroutines, certificates, and etcd objects.


