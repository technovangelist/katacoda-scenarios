When Kubernetes becomes an important part of your infrastructure, it’s crucial to monitor it. We will look at monitoring the applications on top of Kubernetes a bit later, but let’s talk about what you need to pay attention to with the platform itself.


A Kubernetes cluster is made up of two primary node types: control plane nodes and worker nodes. The control plane nodes can include etcd data stores, API servers, and controller managers and schedulers. For each of the components, you are going to need to look at both the system metrics that come from the OS, as well as platform-specific metrics that come through our Prometheus integration.


For system metrics, you need to keep an eye on system load, disk latency, network IO, and memory used. Each component relies on these resources a different amount. For instance, disk latency is incredibly important on etcd, with an SSD providing a huge boost. CPU and memory load is going to be critical on the API Server since it's your connection to etcd and everything else. Of course the exact metrics to watch is largely going to depend on how you architect your Kubernetes environment, but there are some general tips to keep in mind.


etcd is the main database that tracks everything in the cluster and its made up of multiple nodes. Although there is a leader, writes are only committed when a quorum of nodes agrees to the write proposal. So you need to ensure that there is always a single leader. Lack of a leader or too many leaders at any one time will be an issue. And you want to make sure you have enough nodes at any time to reach a quorum, but not so many that the network becomes saturated. You also have to make sure your data is sized properly for your nodes. If network IO increases it could be a sign that a new leader is being elected. And while there can be multiple proposals pending at any time, there should not be any failed proposals.


The etcd database defaults to a maximum size of 2GB, though you can configure that to be up to 8GB. Whatever size you choose, you should monitor the size to ensure it stays under that limit. This is a great metric to employ a forecast on, letting you know that it is likely that you will hit the max soon. Another great feature to take a look at is the ability to create a graph based on log events that match a certain criteria. You could watch for the phrase “took too long" which indicates a slow request. Count how many of those happen in any time period and you have an interesting graph that can report when you are having too many slow requests.

The API Server is cpu and memory intensive so keeping an eye on the relevant system metrics is important. The API Server is your interface to etcd and the other components. Its a big server but it's hard to load balance as you normally would like to. 

Review the following materials, and build some dashboards that allow you to monitor the Kubernetes platform in interesting ways:

* <a href="https://www.datadoghq.com/blog/eks-cluster-metrics/" target="_datadog">EKS Cluster Metrics from the Datadog Blog</a>
* <a href="https://www.datadoghq.com/blog/monitoring-kubernetes-performance-metrics/" target="_datadog">Monitoring Kubernetes Metrics from the Datadog Blog</a>
