<img src="/technovangelist/scenarios/k8s1-install/assets/agent.png" alt="Postgres in Agent" width="50%" />

In this section, you are going to install the Datadog Agent in your environment. To do this we apply a DaemonSet that states that one single Agent should run per host. The first step is to set up the various role-based access control permissions needed for the Agent. You will create a <a href="https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrole.yaml" target="_datadog">ClusterRole</a>,<a href="https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/serviceaccount.yaml" target="_datadog">ServiceAccount</a>, and a <a href="https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrolebinding.yaml" target="_datadog">ClusterRoleBinding</a> (you will see the actual commands on the next page, but you should visit these links to see what each role does).

Next, create and apply a manifest for the Agent. In the hands-on exercise, you will see some of the interesting aspects of the manifest.

Once the Agent is deployed, running `kubectl get daemonset` will return information about how many agents are running. Ultimately, you will have the agent running and collecting information about an application including its Postgres database.

Let’s move on to see this in action.
