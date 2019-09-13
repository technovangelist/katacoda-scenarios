We are already collecting traces, but let's customize the environment a bit further.

1. Open the **frontend-service.yaml** file in the editor. Scroll down to the **env:** section and add:

  <pre class="file" data-target="clipboard">- name: DD_LOGS_INJECTION
             value: 'true'
           - name: DATADOG_SERVICE_NAME
             value: 'frontend-service'
           - name: DD_TRACE_ANALYTICS_ENABLED
             value: 'true'
     </pre>

  *note: formatting here is a little weird to ensure it pastes into the editor correctly*

2. Apply the frontend-service yaml file:
   `kubectl apply -f k8s-yaml-files/frontend-service.yaml`{{execute}}

3. Return to the <a href="https://app.datadoghq.com/apm/traces" target="_datadog">Trace List view</a> in Datadog. You should see that the service has been renamed.
   *If you aren't seeing any traces coming in, visit the application dashboard again*

4. Continue updating the other yaml files as follows, applying the changes as you go:
   **node-api.yaml**
     <pre class="file" data-target="clipboard">- name: DD_SERVICE_NAME
        value: 'users-api'
      - name: DD_LOGS_INJECTION
        value: 'true'
      - name: DD_TRACE_ANALYTICS_ENABLED
        value: 'true'
      </pre>
   *note: formatting here is a little weird to ensure it pastes into the editor correctly*

  `kubectl apply -f k8s-yaml-files/node-api.yaml`{{execute}}

  **pumps-service.yaml**

  <pre class="file" data-target="clipboard">- name: DD_LOGS_INJECTION
          value: 'true'
        - name: DATADOG_SERVICE_NAME
          value: 'pumps-service'
        - name: DD_TRACE_ANALYTICS_ENABLED
          value: 'true'
     </pre>

  *note: formatting here is a little weird to ensure it pastes into the editor correctly*

  `kubectl apply -f k8s-yaml-files/pumps-service.yaml`{{execute}}

  **sensors-api.yaml**

  <pre class="file" data-target="clipboard">- name: DD_LOGS_INJECTION
          value: 'true'
        - name: DATADOG_SERVICE_NAME
          value: 'sensors-api'
        - name: DD_TRACE_ANALYTICS_ENABLED
          value: 'true'
       </pre>

  *note: formatting here is a little weird to ensure it pastes into the editor correctly*

  `kubectl apply -f k8s-yaml-files/sensors-api.yaml`{{execute}}

5. Return to the **datadog-agent.yaml** file and add the following to the **env:** section. This will make trace search a bit better.

  <pre class="file" data-target="clipboard">- name: DD_APM_ANALYZED_SPANS
               value: "users-api|express.request=1,sensors-api|flask.request=1,pumps-service|flask.request=1,iot-frontend|flask.request=1"</pre>

  `kubectl apply -f k8s-yaml-files/datadog-agent.yaml`{{execute}}
