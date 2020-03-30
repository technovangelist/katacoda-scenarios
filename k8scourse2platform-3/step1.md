Install the cluster agent
Understanding security config
Work with autoscaler
Work with cluster checks
Work with EndPoint Checks

In this section you are going to start to work with the Cluster Agent. Remember the Cluster Agent moves much of the job of interrogating the cluster out of the hands of each of the nodes into one instance. Since we are using a cluster made of one master and one node, we won't experience much of a performance gain, but in your production systems, you may see a significant improvement. 

1. Let's start by installing the Cluster Agent. As with the previous section,  we are using the helm chart, so open the `values.yaml` file in the editor to the right.  
1. Scroll down to line 110 and set **enabled:** to true. 
1. In the video you learned that the cluster agent communicates with the node agents. In order to secure that communication, a token needs to be shared between both configurations. If you want to provide that token, you can do so at line 117, otherwise it is generated and secured automatically. 
1. Run helm install to get started. `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml stable/datadog`{{execute}}
1. Let's look at the pods that are now running. Run `k get pods`{{execute}}.
1. Try running the different status commands for the agent. First `k exec <pod name for your cluster agent pod> agent status`. This gets you the normal agent status.
1. To see the metadata the cluster agent is working with, run `k exec <pods name for cluster agent> agent metamap`.
1. Navigate to the <a href="https://app.datadoghq.com/metric/summary" target="_datadog">Metrics Summary</a> page and search for `cluster_agent`. Notice that you now have access to a number of new metrics. 

There are a number of other features you get with the Cluster Agent that help with applications running on top of your Kubernetes cluster. These will be covered in detail in the Advanced Kubernetes Monitoring course focused on the applications, versus the course that you are in focused on the platform.  

* Horizontal Pod Autoscaler - You can autoscale your pods based on any metric collected. For instance, if the number of requests to your nginx pod increases, add a few pods to handle the load. 
* Cluster Checks - 
* Endpoint Checks -
