1. Once your environment is up and running, log into the <a href="https://app.datadoghq.com" target="_datadog">Datadog application</a>. Verify that metrics from the environment are coming in to the platform.

2. Navigate to APM in the Datadog application. If the feature hasn't been enabled, click the **Get Started** button .

3. On the next page you will see the instructions for getting your traces into Datadog. We already have a Datadog yaml file, but we need to configure everything to start collecting traces.

4. Open the datadog-agent.yaml file in the editor to the right. Scroll down to the **`env`**section. Add the following:
  <pre><code>- name: DD_APM_ENABLED
    value: "true"
  - name: DD_APM_NON_LOCAL_TRAFFIC
    value: "true"
  </code></pre>

  *You need to make sure the indent level is correct. All of the **- name:** keys under **env:** should be at the same level.*

5. Apply your new datadog-agent yaml file: 
  `kubectl apply -f k8s-yaml-files/datadog-agent.yaml`{{execute}}

  *Note that this is applying without first deleting due to the **updateStrategy** being set to **RollingUpdate**. Also, if there are any errors with indentation, the command will give you feedback about what needs to be fixed.*

https://[[HOST_SUBDOMAIN]]-5000-[[KATACODA_HOST]].environments.katacoda.com/



6. Now configure the front-end service to start collecting traces
   
7. Return to Logs in the Datadog application and you should see logs starting to appear.

We will look at enabling logs for specific integrations in a later section.
