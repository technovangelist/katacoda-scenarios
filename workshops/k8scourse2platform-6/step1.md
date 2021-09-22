As with the API Server, there is nothing here we need to configure to start collecting Controller Manager metrics.

1. Review the `configcheck` command to see how the Controller Manager check is configured: `k exec $(k match-name datadogagent-[a-z0-9]{5}) agent configcheck`{{execute}}
1. Create a new Timeboard to focus on the Controller Manager and Scheduler.
1. Keeping an eye on the number of healthy nodes in your controller manager is always important, so add a Query Value to look at `kube_controller_manager.nodes.count`. 
1. Repeat that for the `kube_controller_manager.nodes.unhealthy` metric. 
1. Whenever you have a queue, ensuring queue depth is relatively low means items are processed quickly. In the Controller Manager, this is shown in `kube_controller_manager.queue.depth`. Grouping by `queue` lets you see which queues are longer. So add a Timeseries for that. Adding another timeseries for `kube_controller_manager.queue.retries` is also useful. 
1. As with the other components, watching the numbers of requests coming in is important, so create a Timeseries for `kube_controller_manager.client.http.requests` and group by method and code. 
1. Finally add another Query Value for `kube_controller_manager.goroutines`.

