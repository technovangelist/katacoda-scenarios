We are already collecting traces, but let's customize the environment a bit further.

1. Open the **frontend-service.yaml** file in the editor. Scroll down to the **env:** section and add:

  <pre><code>- name: DD_LOGS_INJECTION
     value: 'true'
  - name: DATADOG_SERVICE_NAME
     value: 'frontend-service'</code></pre>

2. Apply the frontend-service yaml file:
   `kubectl apply -f k8s-yaml-files/frontend-service.yaml`{{execute}}

3. Return to the <a href="https://app.datadoghq.com/apm/traces" target="_datadog">Trace List view</a> in Datadog. You should see that the service has been renamed.
   *If you aren't seeing any traces coming in, visit the application dashboard again*

4. Continue updating the other yaml files as follows, applying the changes as you go:
   
  **node-api.yaml** 
  <pre><code>- name: DD_SERVICE_NAME
     value: 'users-api'
  - name: DD_LOGS_INJECTION
     value: 'true'</code></pre>

  `kubectl apply -f k8s-yaml-files/node-api.yaml`{{execute}}

  **pumps-service.yaml**
  <pre><code>- name: DD_LOGS_INJECTION
     value: 'true'
  - name: DATADOG_SERVICE_NAME
     value: 'pumps-service'</code></pre>

  `kubectl apply -f k8s-yaml-files/node-api.yaml`{{execute}}