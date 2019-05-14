1. Make sure all the pods in your environment are running or at least being created:
   `kubectl get pods`{{execute}}
   *If you see errors when you run `kubectl get pods`, there was a problem starting your lab environment. Hit the power button at the top right of the window and then refresh the browser. This will give you a new machine.*

2. Once your environment is up and running, log into the <a href="https://app.datadoghq.com" target="_datadog">Datadog application</a>. Verify that metrics from the environment are coming in to the platform.

3. Navigate to <a href="https://app.datadoghq.com/logs" target="_datadog">Logs in the Datadog application</a>. If the feature hasn't been enabled, click the **Get Started** button and then the **Start Trial** button.

4. On the next page you will see the instructions for getting your logs into Datadog. We already have a Datadog yaml file, but we need to add the information listed in the second and third textboxes.

5. Run the **agent status** command to see that logs are not being collected yet. 
  `kubectl exec $(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep datadog) -- agent status`{{execute}}

  *Running agent status results in a lot of information. Scroll up to see all the different types of info displayed. If you get `error: unable to upgrade connection: container not found ("datadog-agent")`, the datadog agent hasn't had time to launch completely. You should see something like this as you scroll up.*

  <pre><code>========
  Logs Agent
  ==========

  Logs Agent is not running</code></pre>

6. Open the datadog-agent.yaml file in the editor to the right. Scroll down to the **`env`**section. Add the following:
  <pre><code>- name: DD_LOGS_ENABLED
     value: "true"
   - name: DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL
     value: "true"
  </code></pre>

  *You need to make sure the indent level is correct. All of the **- name:** keys under **env:** should be at the same level.*

5. Scroll down to **volumeMounts:** and add the following:
   
  <pre><code>- name: pointerdir
     mountPath: /opt/datadog-agent/run</code></pre>

6. Finally go down to **volumes:** and add the following:
   
  <pre><code>- hostPath:
       path: /opt/datadog-agent/run
     name: pointerdir</code></pre>

7. Apply your new datadog-agent yaml file: 
  `kubectl apply -f k8s-yaml-files/datadog-agent.yaml`{{execute}}

  *Note that this is applying without first deleting due to the **updateStrategy** being set to **RollingUpdate**. Also, if there are any errors with indentation, the command will give you feedback about what needs to be fixed.*

6. You can then verify that the logs are being collected by running the **agent status** command again:
  `kubectl exec $(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep datadog) -- agent status`{{execute}}

7. Return to Logs in the Datadog application and you should see logs starting to appear.



