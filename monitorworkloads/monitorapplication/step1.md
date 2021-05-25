1.  In a Kubernetes environment, the main configuration process for the Datadog agent is through environment variables. Let's start with advertisements. At spec.template.spec.containers.env add the following environment variables:

    - name: DATADOG_SERVICE_NAME
      value: "advertisements-service"
    - name: DD_ENV
      valueFrom:
        fieldRef:
          fieldPath: metadata.labels['tags.datadoghq.com/env']
    - name: DD_AGENT_HOST 
      valueFrom:
        fieldRef:
          fieldPath: status.hostIP
    - name: DD_LOGS_INJECTION
      value: "true"
    - name: DD_ANALYTICS_ENABLED
      value: "true"
    - name: DD_PROFILING_ENABLED
      value: "true"
2.  In discounts add the following environment variables:

    - name: DATADOG_SERVICE_NAME
      value: "discountsservice"
    - name: DD_AGENT_HOST
      valueFrom:
        fieldRef:
          fieldPath: status.hostIP
    - name: DD_LOGS_INJECTION
      value: "true"
    - name: DD_ANALYTICS_ENABLED
      value: "true"
    - name: DD_PROFILING_ENABLED
      value: "true"
    - name: DD_ENV
      valueFrom:
        fieldRef:
          fieldPath: metadata.labels['tags.datadoghq.com/env']
3.  And in frontend, add the following environment variables:

    - name: DD_AGENT_HOST
      valueFrom:
        fieldRef:
          fieldPath: status.hostIP
    - name: DD_LOGS_INJECTION
      value: "true"
    - name: DD_ENV
      valueFrom:
        fieldRef:
          fieldPath: metadata.labels['tags.datadoghq.com/env']
    - name: DD_ANALYTICS_ENABLED
      value: "true"
4.  asht