1. Login to <a href="https://app.datadoghq.com" target="_datadog">your Datadog account</a> and take a look around. 
2. Make sure you take a look at the Event Stream.
   *Here you will see an event for each of the containers as they appear in the Datadog interface. Note that it could take a few minutes for them to show up in the interface for the first time.*
   
3. Navigate to the <a href="https://app.datadoghq.com/account/settings" target="_datadog">Integrations List</a> .

4. Enable the tile for the <a href="https://app.datadoghq.com/account/settings#integrations/postgres" target="_datadog">integration for Postgres</a>.
   *Normally you would follow the instructions displayed in the **Configuration** tab in the tile. Most of those steps have already been completed and all that is necessary here is to enable the tile.*
5. Now go to the <a href="https://app.datadoghq.com/dashboard/lists" target="_datadog">Dashboards list</a> and find the Postgres - Overview dashboard.
6. Even if you wait a long time, no metrics will appear here. This is because the Agent is not reporting any Postgres metrics.
7. In the lab environment editor to the right, open the postgres-deploy.yaml file. Scroll down to line 19.
8. There is a section for annotations; uncomment each of these lines.

  *When the hashes are removed, **annotations:** should be at the same indent level as **labels:** and each of the three annotation lines will be indented two spaces from **annotations**.*
  *Annotations are how you configure the Datadog Agent to work with one of the integrations. Here we are telling the Agent to use the **Postgres** check, with the corresponding host, port, username, and password.*
  
  *Since we can't possibly know what the host and port are going to be when we write the yaml file, the %%HOST%% is a placeholder that is replaced automatically at run time.*
7. Now apply the Postgres deployment again. `kubectl apply -f k8s-yaml-files/postgres-deploy.yaml`{{execute}}
8. If you take a look at the Datadog dashboard now, even if you wait a few minutes, you still won't be seeing anything. We have configured the Postgres Integration, but it's not working.
9. Just to make sure all the pods are running, lets look at the results of `kubectl get pods`{{execute}}. Looks like everything is running.
10.  Move on to the next section to find a few methods for seeing what's wrong.
