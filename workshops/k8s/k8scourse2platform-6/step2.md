Let's continue working on the Controller and Scheduler dashboard by adding a few metrics for the Scheduler.

1. Again we want to pay attention to http requests, so add a timeseries for `kube_scheduler.client.http.requests` and group by method and code. 
1. Getting an average duration is useful, though we only have metrics for the duration and the count. Thankfully with the advanced view when creating a timeseries, we can divide `kube_scheduler.client.http.requests_duration.sum` by `kube_scheduler.client.http.requests_duration.count`. Group both by verb and url. 
1. Then add a couple of query values for `kube_scheduler.threads` and `kube_scheduler.goroutines`.

The scheduler has only a few metrics that are really critical to watch, so that should get you most of what you need. 