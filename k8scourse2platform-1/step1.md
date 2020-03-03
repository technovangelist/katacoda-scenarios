Let's start the course with a reminder of how to install the Datadog agent. 

1. To get started we need to set a few permissions. We covered a little bit about what these manifests are for in the first Kubernetes course and will go into much more detail in a video coming up after this section. Run the following command on the master:
`kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrole.yaml"`{{execute}}
1. Next create the service account:
`kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/serviceaccount.yaml"`{{execute}}
1. The previous two steps are then linked together in the clusterrolebinding which binds the service account to the clusterrole:
`kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrolebinding.yaml"`{{execute}}
1. Apply the manifest for the Datadog agent using the following command:
`kubectl apply -f k8s-yaml-files/datadog-agent.yaml`{{execute}}
1. Everything should be running now. To verify, run: 
`kubectl get daemonset`{{execute}}
You should see a list of how many agents are installed and running.
1. But wait, we have a cluster that is running on two servers, why aren’t there two agents running. Normally, only the nodes in the cluster will run the agent, but it’s also possible to run the agent on master if you add the tolerance to the pod. After line 15 in datadog-agent.yaml, add the following:
  <pre><code>tolerations:
  - key: node-role.kubernetes.io/master
     effect: NoSchedule
  </code></pre>

  *tolerations: should be at the same indent level as containers: below it*

1. Now apply the file again:
`kubectl apply -f k8s-yaml-files/datadog-agent.yaml`{{execute}}
1. Get the daemonset again and you should see two agents are running.
1. Open the datadog-agent.yaml file. Notice that many of the configuration options for the agent are defined with environment variables. 
