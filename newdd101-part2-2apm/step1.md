1. Make sure all the pods in your environment are running or at least being created:
   `kubectl get pods`{{execute}}

2. Once your environment is up and running, log into the <a href="https://app.datadoghq.com" target="_datadog">Datadog application</a>. Verify that metrics from the environment are coming in to the platform. 

3. Open the application dashboard by clicking the second tab in the terminal window to the right. Sometimes this takes a minute to be available, so be patient.

4. You can add a few pumps to the application by pressing the **Add Pump** button. To simulate usage, scroll down and click one of the **Generate API Traffic** buttons.

5. Navigate to <a href="https://https://app.datadoghq.com/apm/intro" target="_datadog">to the APM section</a> in the Datadog application. If the feature hasn't been enabled, click the **Get Started** button .

6. On the next page you will see the instructions for getting your traces into Datadog. We already have a Datadog yaml file, but we need to configure everything to start collecting traces.

7. Open the datadog-agent.yaml file in the editor to the right. Scroll down to the **`env`**section. Add the following:
  <pre class="file" data-target="clipboard">
            - name: DD_APM_ENABLED
              value: "true"
            - name: DD_APM_NON_LOCAL_TRAFFIC
              value: "true"
            </pre>

  *note: formatting here is a little weird to ensure it pastes into the editor correctly*
  *You need to make sure the indent level is correct. All of the **- name:** keys under **env:** should be at the same level.*

8. Apply your new datadog-agent yaml file: 
  `kubectl apply -f k8s-yaml-files/datadog-agent.yaml`{{execute}}

  *Note that this is applying without first deleting due to the **updateStrategy** being set to **RollingUpdate**. Also, if there are any errors with indentation, the command will give you feedback about what needs to be fixed.*

6. Navigate to the <a href="https://app.datadoghq.com/apm/traces" target="_datadog">APM Trace List</a> and you should see traces start showing up. If they aren't there yet, you may need to try the link again. Just refreshing the page will reload the intro page. Also make sure you clicked one of the Generate API traffic buttons.

