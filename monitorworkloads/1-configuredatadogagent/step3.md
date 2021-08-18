Now that we have configured the database to collect metrics, lets look at adding traces for our frontend application.

1.  In the IDE, open the file called `frontend.yaml` located under `deploy/generic-k8s/ecommerce-app`. You can see that this manifest defines a **deployment** and a **service**. 
2.  Under `spec/template/spec/containers/env` you will see a few environment variables defined to tell the application how to connect to the database. We are going to add a few more environment variables here to configure the connection to Datadog. First we need to start to setup Unified Service Tagging, which will allow for seamless navigation across traces, metrics, and logs. 
3.  The first environment variable to add is for the service to label everything with in Datadog. Add the following at the same level as the DB_PASSWORD environment variable:
        - name: DATADOG_SERVICE_NAME
          value: "store-frontend"
4.  Below that, add the corresponding environment variables for version number and environment:
        - name: DD_ENV
          value: "development"
        - name: DD_VERSION
          value: "1.0"
5.  Let's continue by adding the other environment variables needed for collecting traces:
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
6.  Setting the environment variables is important, but to get the full effect of Unified Service Tagging, we also need to set labels at the deployment and the pod level. Add the following labels under metadata.labels at line 5:
        
7.  asht