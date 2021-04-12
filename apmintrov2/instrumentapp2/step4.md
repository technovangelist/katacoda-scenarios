First, you'll restart the docker deployment to apply the changes for monitoring the `store-frontend` service. Then, you'll view the trace and log data being collected by Datadog from the app.

1. Click `rm /ecommworkshop/store-frontend-broken-instrumented/store-frontend/tmp/pids/*; docker-compose -f docker-compose-broken-no-apm-instrumentation.yml up -d`{{execute}} to clear the server cache and restart the docker deployment. <p> ![restarted-agent-frontend](instrumentapp2/assets/restarted-agent-frontend.png)

2. In a new window/tab, log in to the <a href="https://app.datadoghq.com/account/login" target="_datadog">Datadog account/organization</a> that was created for you by learn.datadoghq.com. 

3. If you have previously used the **Logs** in the Datadog organization you are working in, move on to the next step. <p>If you are working in a new Datadog organization, you have to first enable Log Management before you can continue. Navigate to <a href="https://app.datadoghq.com/logs" target="_datadog">**Logs**</a>. Click **Get Started**, then click **Get Started** again. You should now be able to see the Log List.

4. Navigate to <a href="https://app.datadoghq.com/apm/traces" target="_datadog">**APM > Traces** </a> in Datadog to view the list of traces that are being ingested. 

5. In the search field, type `env:ruby-shop` if it is not listed so that the traces list displays traces for the storedog app only.

6. In the **Facets** list, expand **Service** to view the services from the app that are injecting traces into Datadog. <p>![trace-frontendservices](instrumentapp2/assets/trace-frontendservices.png)

7. Click a trace for the `store-frontend` service to view the Flame Graph and Span List. <p> The color of each span is based on the associated service, listed on the right of the Flame Graph. <p> To zoom in and out of the Flame Graph, hover the cursor over the Flame Graph and scroll up and down. 

8. Below the Flame Graph, click each tab to see the Tags, related Hosts, and related Logs. <p> Under **Logs(#)**, you can see the `trace_id:###` tag assigned by Datadog to the trace and the list of logs that are correlated to the trace via the `trace_id:###` tag. Correlating traces with related logs allows you to see all details related to each trace so that you can quickly troubleshoot any issues. To learn more, view the <a href="https://docs.datadoghq.com/tracing/connect_logs_and_traces/" target="_blank">Connect Logs and Traces</a> documentation. 
 
9. Click any of the logs. A new browser tab will open for the **Log Explorer** and the details for the log. <p> Notice the tag selected in the search field above the lists of logs is the `trace_id:###` for the specific trace.

As you can see, the agent and store-frontend service were successfully instrumented for APM and log collection in Datadog. 

Now, let's instrument the Python-Flask services of the app.