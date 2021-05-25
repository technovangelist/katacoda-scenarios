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
    DATADOG_SERVICE_NAME overrides the service name to be used for the program. DD_ENV defines the environment used, such as prod or staging. DD_AGENT_HOST overrides the address of the trace agent host that the default tracer will attempt to submit to, DD_LOGS_INJECTION enables logs injection in Python. DD_PROFILING_ENABLED enables profiling when you use ddtrace-run. 
2.  At spec.template.spec.containers, update the command to launch flask from ddtrace-run:

        command: ["ddtrace-run"]
        args: ["flask", "run", "--port=5002", "--host=0.0.0.0"]
3.  In discounts.yaml add the following environment variables:

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
4.  And then make the same update to the command:

        command: ["ddtrace-run"]
        args: ["flask", "run", "--port=5001", "--host=0.0.0.0"]
5.  And in frontend, add the following environment variables:

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
6.  asht