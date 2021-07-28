1.  In the terminal and editor, change to section4. Upgrade your Datadog agent Helm chart with the following command: `helm upgrade datadogagent datadog/datadog --set datadog.apiKey=$DD_API_KEY -f ./values.yaml`, and then apply the changes for the application with this command: `k apply -f ./db.yaml;k apply -f ./discounts.yaml;k apply -f ./advertisements.yaml;k apply -f ./frontend.yaml`
2.  The values file that we used to upgrade the helm chart was specifically tweaked for our control plane node. Let's deploy again for the nodes: `helm install datadogagentnode datadog/datadog --set datadog.apiKey=$DD_API_KEY --set clusterAgent.enabled=false --set datadog.orchestratorExplorer.enabled=false`
3.  Now lets take a look at what has changed. 
    1.  Open the **advertisements.yaml** file in the editor.
    2.  Scroll down to **spec.template.spec.containers.env**. You can see a number of new environment variables here, including: DATADOG_SERVICE_NAME, DD_ENV, DD_AGENT_HOST, DD_LOGS_INJECTION, DD_ANALYTICS_ENABLED, DD_PROFILING_ENABLED. These environment variables are all that is needed to enabled different features like profiling, and more. 
    3.  Open the **discounts.yaml** file in the editor. 
    4.  You will find many of the same environment variables here. You will also find that we changed the command at spec.template.spec.containers.command. It is now ddtrace-run, with flask being moved to the first of the command line variables. ddtrace-run is a tool for auto instrumenting python-based applications. 
    5.  Finally open **frontend.yaml**. Not much has changed here beyond the environment variables, but we will update this later to enable **Real User Monitoring**.
4.  Remember what we had to do to figure out the URL to open to visit the frontend of our site? `k get services` will show any external IP addresses we can use. But the **frontend.yaml** file also specifies that an ELB should be created. And that takes a few minutes to start. To see the current state of the ELB, run this command: `aws elbv2 describe-load-balancers`. You will probably only see a single load balancer and you want the **State** to be **active**.



You can find all of the YAML configuration files for our app in deploy/generic-k8s/ecommerce-app in the IDE. In a Kubernetes environment, the main configuration process for the Datadog agent is through environment variables. Let's start by reviewing what's new in advertisements.yaml. 
1.  Open advertisements.yaml and scroll down to line 27. We have updated the command run from flask to ddtrace-run with flask as the first argument. 
2.  Then in spec.template.spec.containers.env are the environment variables. DATADOG_SERVICE_NAME overrides the service name to be used for the program. DD_ENV defines the environment used, such as prod or staging. DD_AGENT_HOST overrides the address of the trace agent host that the default tracer will attempt to submit to, DD_LOGS_INJECTION enables logs injection in Python. DD_PROFILING_ENABLED enables profiling when you use ddtrace-run. 
3.  In discounts.yaml you can see that we have made the same changes.
4.  In frontend, you can see there are a few environment variables set. Since frontend, discounts, and advertisements are Python and Ruby apps, we are relying on APM for much of the integration, along with some collection of metrics within the applications themselves. You can learn more about the exact steps to follow here in our APM courses. 

