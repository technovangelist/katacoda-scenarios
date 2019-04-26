We are already collecting traces, but let's customize the environment a bit further.

1. Open the **frontend-service.yaml** file in the editor. Scroll down to the **env:** section and add:

  <pre><code>- name: DD_LOGS_INJECTION
    value: 'true'
  - name: DATADOG_SERVICE_NAME
    value: 'frontend-service'</code></pre>

2. asht

