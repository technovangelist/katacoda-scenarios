Now that we have configured the database to collect metrics, lets look at adding traces for our frontend application.

1.  In the IDE, open the file called `frontend.yaml` located at `deploy/generic-k8s/ecommerce-app/frontend.yaml`{{open}}. You can see that this manifest defines a **deployment** and a **service**. 
2.  Under `spec.template.spec.containers.env` at line 33 you will see a few environment variables defined to tell the application how to connect to the database. We are going to add a few more environment variables here to configure the connection to Datadog. First we need to start to setup Unified Service Tagging, which will allow for seamless navigation across traces, metrics, and logs. 
3.  The first environment variable to add is for the service to label everything with in Datadog. Add the following at the same level as the DB_PASSWORD environment variable (note: the text below is formatted to paste properly in the editor):
    <pre class="file" data-target="clipboard">
    - name: DD_SERVICE
                  value: "store-frontend"</pre>
4.  Below that, add the corresponding environment variables for version number and environment:
    <pre class="file" data-target="clipboard">- name: DD_ENV
                  value: "production"
                - name: DD_VERSION
                  value: "1.0"</pre>
5.  Let's continue by adding the other environment variables needed for collecting traces (You can find the documentation for these here: https://docs.datadoghq.com/getting_started/tagging/unified_service_tagging?tab=kubernetes):
    <pre class="file" data-target="clipboard">- name: DD_AGENT_HOST
                  valueFrom:
                    fieldRef:
                      fieldPath: status.hostIP
                - name: DD_LOGS_INJECTION
                  value: "true"
                - name: DD_ANALYTICS_ENABLED
                  value: "true"
                - name: DD_PROFILING_ENABLED
                  value: "true"</pre>
6.  Setting the environment variables is important, but to get the full effect of Unified Service Tagging, we also need to set labels at the deployment and the pod level. Add the following labels under `metadata.labels` at line 5:
    <pre class="file" data-target="clipboard">tags.datadoghq.com/env: "production"
        tags.datadoghq.com/service: "store-frontend"
        tags.datadoghq.com/version: "1.0"</pre>
    1.  Next we need to add these same labels to the `spec.template.metadata.labels` section:
    <pre class="file" data-target="clipboard">tags.datadoghq.com/env: "production"
            tags.datadoghq.com/service: "store-frontend"
            tags.datadoghq.com/version: "1.0"</pre>
7.  Apply the changes by running the command `k apply -f deploy/generic-k8s/ecommerce-app/frontend.yaml`{{execute}}
8.  Now if you open the Logs Search and Filter by the Service store-frontend, you can click on any log and see the related Metrics, Processes, and if there are any, Traces. Similarly you can start at the Container view then choose Pods at the top left and choose the Frontend pod, then find all the related information. Unified Service Tagging is the key to getting all of this data to show up correctly as related to each other.