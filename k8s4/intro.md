In this section, you are going to install the Datadog Agent in your environment. To do this we apply a DaemonSet that defines that one Agent should run per host. The first step is to set up the various role-based access control permissions needed for the Agent. You will create a [ClusterRole](https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrole.yaml), a [ServiceAccount](https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/serviceaccount.yaml), and a [ClusterRoleBinding](https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrolebinding.yaml) (you will see the actual commands on the next page).

Next, create and apply a manifest for the Agent. In the hands-on exercise, you will see some of the interesting aspects of the manifest.

Once the Agent is deployed, running `kubectl get daemonset` will return information about how many agents are running.

Let’s move on to see this in action.
