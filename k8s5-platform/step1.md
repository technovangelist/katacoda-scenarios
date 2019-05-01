When Kubernetes becomes an important part of your infrastructure, it’s crucial to monitor it. We will look at monitoring the applications on top of Kubernetes a bit later, but let’s talk about what you need to pay attention to with the platform itself.


A Kubernetes cluster is made up of two primary node types: control plane nodes and worker nodes. The control plane nodes can include etcd data stores, API servers, and controller managers and schedulers. For each of the components, you are going to need to look at both the system metrics that come from the OS, as well as platform-specific metrics that come through our Prometheus integration.


For system metrics, you need to keep an eye on system load, disk latency, network IO, and memory used. Each component relies on these resources a different amount. For instance, disk latency is incredibly important on etcd, with an SSD providing a huge boost. CPU and memory load is going to be critical on the API Server since it's your connection to etcd and everything else. Of course the exact metrics to watch is largely going to depend on how you architect your Kubernetes environment, but there are some general tips to keep in mind.

1. Login to Datadog and navigate to the <a href="https://app.datadoghq.com/dashboards" target="_datadog">Dashboards list</a>. 
2. Find the **Kubernetes - Overview** dashboard. Is there anything missing from the dashboard that we have talked about so far?
3. Is there anything you would do to tweak the dashboard for your needs? Is this better as a screenboard or a timeboard?