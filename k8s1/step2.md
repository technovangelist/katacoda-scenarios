1. Login to your Datadog account and take a look around.
1. Navigate to Dashboards List under the Dashboards menu. 

  *Depending on how long your environment has been running, you may see a Redis dashboard already listed. If not, go to Integrations and add the Redis integration. Return to the Redis dashboard and within a minute or so you should start to see Redis metrics.*

1. Add the integration for Postgres, then navigate to the Postgres - Overview dashboard.
1. Even if you wait a long time, no metrics will appear here. This is because the Agent is not reporting any Postgres metrics.
1. In the lab environment, open the postgres-deploy.yaml file. Scroll down to line 14.
1. There is a section for annotations; uncomment each of these lines.

  *When the hashes are removed, **annotations:** should be at the same indent level as **labels:** and each of the three annotation lines will be indented once from **annotations**.*
  *Annotations are how you configure the Datadog Agent to work with one of the integrations. Here we are telling the Agent to use the **Postgres** check, with the corresponding host, port, username, and password.*
  
  *Since we can't possibly know what the host and port are going to be when we write the yaml file, the %%HOST%% is a placeholder that is replaced automatically at run time.*

1. Now apply the Postgres deployment again. `kubectl apply -f k8s-yaml-files/postgres-deploy.yaml`{{execute}}
1. If you take a look at 

`kubectl exec $(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep datadog) -- agent status`{{execute}}