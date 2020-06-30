1. As with the API Server, there is nothing here we need to configure. 
latency
the workqueue latency - kube_controller_manager.queue.queue_duration.sum
the number of items per time - high value can indicate problems in cluster of some nodes: kube_controller_manager.queue.adds
number of things waiting: kube_controller_manager.queue.depth


node availability and health

scheduled and unscheduled attempts
goroutines and http req

