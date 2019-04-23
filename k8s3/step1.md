1. Once your environment is up and running, log into the <a href="https://app.datadoghq.com" target="_datadog">Datadog application</a>. Verify that metrics from the environment are coming in to the platform.
2. Navigate to Logs in the Datadog application. If the feature hasn't been enabled, click the **Get Started** button and then the **Start Trial** button.
3. On the next page you will see the instructions for getting your logs into Datadog. We already have a Datadog yaml file, but we need to add the information listed in the second and third textboxes.
4. Open the datadog-agent.yaml file in the editor to the right. Scroll down to the **`env`**section. Add the following:
   
  <pre><code>
   - name: DD_LOGS_ENABLED
     value: "true"
   - name: DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL
     value: "true"
  </code></pre>

  You need to make sure the indent level is correct. All of the **- name:** keys under **env:** should be at the same level. You can verify that everything works by running a variation on a command we used earlier:

  `kubectl exec $(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep datadog) -- agent status`{{execute}}

  If you get `error: unable to upgrade connection: container not found ("datadog-agent")`, the datadog agent hasn't had time to launch completely.

