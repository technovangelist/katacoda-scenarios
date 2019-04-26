1. Open the **postgres-deploy.yaml** file in the editor on the right. Scroll down to the commented annotation lines and uncomment them. 
2. Apply the updated yaml:
   `kubectl apply -f k8s-yaml-files/postgres-deploy.yaml`{{execute}}
3. Navigate to the <a href="https://app.datadoghq.com/dashboard/lists" target="_datadog">Dashboards List</a> and click on **Postgres - Overview**. 
   *Within a few minutes you should see Postgres metrics start to show up.*