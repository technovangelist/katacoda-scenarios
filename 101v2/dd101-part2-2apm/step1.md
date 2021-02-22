1. The application we're going to monitor in this lab consists of services running on 10 containers across 7 Kubernetes pods. Make sure all the pods in your environment are running or at least being created:

    `kubectl get pods`{{execute}}.

2. Once all of the pods report 1/1 in the Ready column, log into the <a href="https://app.datadoghq.com" target="_datadog">Datadog application</a>. Click on Infrastructure > Containers to verify that metrics from the environment are coming in to the platform.

    To figure out which integrations are installed in this environment, run the Agent status command in the terminal using `kubectl exec $(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep datadog) -- agent status`{{execute}}. This command figures out which pod is running the Datadog agent, and executes `agent status` on that pod.

3. Open the application dashboard by clicking the second tab in the terminal window to the right. Sometimes this takes a minute to be available, so be patient.

4. You can add a few pumps to the application by pressing the **Add Pump** button. To simulate usage, scroll down and click one of the **Generate API Traffic** buttons.

5. Navigate to <a href="https://app.datadoghq.com/apm/intro" target="_datadog">to the APM section</a> in the Datadog application. Because we haven't enabled traces from our application services yet, you'll see an introduction page. Click the **Get Started** button.

6. On the next page you will see the instructions for getting your traces into Datadog based on how your application is hosted and the types of services you want to trace. We'll skip this, but keep this useful resource in mind when you want to enable tracing in your own applications.

    Let's go back to the lab and configure everything to start collecting traces.

7. Open the datadog-agent.yaml file in the editor to the right. Scroll down to the **`env`**section. Add the following after the DD_KUBERNETES_KUBELET_HOST block.

    <pre class="file" data-target="clipboard">- name: DD_APM_ENABLED
               value: "true"
             - name: DD_APM_NON_LOCAL_TRAFFIC
               value: "true"
             </pre>

    _Note: formatting here is a little weird to ensure it pastes into the editor correctly. You need to make sure the indent level is correct. All of the **- name:** keys under **env:** should be at the same level._

8. Apply your updated datadog-agent.yaml file: 
  `kubectl apply -f k8s-yaml-files/datadog-agent.yaml`{{execute}}

    _Note that this is applying without first deleting due to the **updateStrategy** being set to **RollingUpdate**. Also, if there are any errors with indentation, the command will give you feedback about what needs to be fixed._

9. New menu options become available under APM in the nav bar when application traces are detected. Navigate to the <a href="https://app.datadoghq.com/apm/traces" target="_datadog">APM Trace List</a> and you should see traces start showing up. 

    If you still see the APM intro page, you may need to try the link again. Just refreshing the page will reload the APM intro page. Also make sure you clicked one of the Generate API traffic buttons, and that you ran the `kubectl apply` command after making changes to datadog-agent.yaml.
 