1. To get started we need to set a few permissions. The first one is to create a role scoped to the cluster. This role will get and update the ConfigMaps, list and watch the Events, get, update, and create Endpoints, and list the componentstatuses resource. Run the following command on the master:
`kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrole.yaml"`{{execute}}
You can discover what this role is giving access by opening the url above in your browser. But defining the role alone doesn’t really do anything yet
1. Next create the service account:
`kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/serviceaccount.yaml"`{{execute}}
1. The previous two steps are then linked together in the clusterrolebinding which binds the service account to the clusterrole:
`kubectl create -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrolebinding.yaml"`{{execute}}
1. The next step is to create the manifest for the Datadog agent and apply it to the cluster. You can find the manifest in <a href="https://docs.datadoghq.com/agent/kubernetes/daemonset_setup/#create-manifest" target="_datadog">the documentation</a>, but one is already in the k8s-yaml-files directory. Click on the file to see what’s in there
If you compare it with the documentation you may notice that the first block that defines the api-key as a secret is not included. This step has already been completed as part of the provisioning of the training environment. 
1. Apply this manifest using the following command:
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



