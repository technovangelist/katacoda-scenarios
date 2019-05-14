We are already collecting traces, but let's customize the environment a bit further.

1. Open the **frontend-service.yaml** file in the editor. Scroll down to the **env:** section and add:

  <pre><code>- name: DD_LOGS_INJECTION
     value: 'true'
  - name: DATADOG_SERVICE_NAME
     value: 'frontend-service'
  - name: DD_TRACE_ANALYTICS_ENABLED
     value: 'true'</code></pre>

2. Apply the frontend-service yaml file:
   `kubectl apply -f k8s-yaml-files/frontend-service.yaml`{{execute}}

3. Return to the <a href="https://app.datadoghq.com/apm/traces" target="_datadog">Trace List view</a> in Datadog. You should see that the service has been renamed.
   *If you aren't seeing any traces coming in, visit the application dashboard again*

4. Continue updating the other yaml files as follows, applying the changes as you go:
   
  **node-api.yaml** 
  <pre><code>- name: DD_SERVICE_NAME
     value: 'users-api'
  - name: DD_LOGS_INJECTION
     value: 'true'
  - name: DD_TRACE_ANALYTICS_ENABLED
     value: 'true'</code></pre>

  `kubectl apply -f k8s-yaml-files/node-api.yaml`{{execute}}

  **pumps-service.yaml**
  <pre><code>- name: DD_LOGS_INJECTION
     value: 'true'
  - name: DATADOG_SERVICE_NAME
     value: 'pumps-service'
  - name: DD_TRACE_ANALYTICS_ENABLED
     value: 'true'</code></pre>

  `kubectl apply -f k8s-yaml-files/pumps-service.yaml`{{execute}}

  **sensors-api.yaml**
  <pre><code>- name: DD_LOGS_INJECTION
     value: 'true'
  - name: DATADOG_SERVICE_NAME
     value: 'sensors-api'
  - name: DD_TRACE_ANALYTICS_ENABLED
     value: 'true'</code></pre>

  `kubectl apply -f k8s-yaml-files/sensors-api.yaml`{{execute}}

5. Return to the **datadog-agent.yaml** file and add the following to the **env:** section. This will make trace search a bit better.
   
  <pre><code>- name: DD_APM_ANALYZED_SPANS
     value: "users-api|express.request=1,sensors-api|flask.request=1,pumps-service|flask.request=1,iot-frontend|flask.request=1"</code></pre>

    `kubectl apply -f k8s-yaml-files/datadog-agent.yaml`{{execute}}

6. Take a look around the other features of APM. As with the Logs section, this is not intended to be a training on using APM, but rather a look at how to setup APM on Kubernetes. For more about APM, see our training here on the Learning Platform.