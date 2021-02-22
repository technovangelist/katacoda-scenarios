1. We're going to collect logs from the same application that we worked with in the APM lab. Make sure all the pods in your environment are running or at least being created:

    `kubectl get pods`{{execute}}

    _If you see errors when you run `kubectl get pods`, there was a problem starting your lab environment. Hit the power button at the top right of the window and then refresh the browser. This will give you a new machine._

2. Once all of the pods report 1/1 in the Ready column, log into the <a href="https://app.datadoghq.com" target="_datadog">Datadog application</a>. Click on Infrastructure > Containers to verify that metrics from the environment are coming in to the platform.

3. Navigate to <a href="https://app.datadoghq.com/logs" target="_datadog">Logs in the Datadog application</a>. If you haven't already enabled this feature, you'll see an introduction page. Click the **Get Started** button and then the **Start Trial** button.

4. On the next page you will see the instructions for getting your logs into Datadog based on your log source. We'll skip this, but keep this useful resource in mind when you want to enable logging in your own sources.

5. Run the **agent status** command to see that logs are not being collected yet.

    `kubectl exec $(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep datadog) -- agent status`{{execute}}

    _Running agent status results in a lot of information. Scroll up to see all the different types of info displayed. If you get `error: unable to upgrade connection: container not found ("datadog-agent")`, the datadog agent hasn't had time to launch completely. You should see something like this as you scroll up._

    ```
    ==========
    Logs Agent
    ==========

      Logs Agent is not running
    ```

6. Open the datadog-agent.yaml file in the editor to the right. Scroll down to the **`env`** section. Add the following after the `DD_KUBERNETES_KUBELET_HOST` block.

    <pre class="file" data-target="clipboard">- name: DD_LOGS_ENABLED
               value: "true"
             - name: DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL
               value: "true"
             </pre>

   _You need to make sure the indent level is correct. All of the **- name:** keys under **env:** should be at the same level._

7. Scroll down to **volumeMounts:** and add the following after the `passwd` block:

    <pre class="file" data-target="clipboard">- name: pointerdir
               mountPath: /opt/datadog-agent/run
             </pre>

8. Finally go down to **volumes:** and add the following to the bottom:

    <pre class="file" data-target="clipboard">- hostPath:
              path: /opt/datadog-agent/run
             name: pointerdir
           </pre>

9. Apply your new datadog-agent yaml file:
   `kubectl apply -f k8s-yaml-files/datadog-agent.yaml`{{execute}}

   _Note that this is applying without first deleting due to the **updateStrategy** being set to **RollingUpdate**. Also, if there are any errors with indentation, the command will give you feedback about what needs to be fixed._

10. You can then verify that the logs are being collected by running the **agent status** command again:

    `kubectl exec $(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep datadog) -- agent status`{{execute}}

11. Return to Logs in the Datadog application and within a few minutes, you should see logs starting to appear.
