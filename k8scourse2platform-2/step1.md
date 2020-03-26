In the previous hands on section, you setup the agent using the daemonset manifests. We need the agent in this exercise but this time we will install it using the Helm chart. 

1. The command to run is `helm install <release name> --set datadog.apiKey=<api key> stable/datadog`. If this is your introduction to using Helm, then release name is whatever you want to call this deployment. We will use the name datadog-agent and the api key is set in an environment variable. So you could run this command now to get it installed and running, but we should first setup a custom values file to make sure we have everything configured correctly.
1. In the editor to the right, click on values.yaml
1. Usually the cluster's name will be automatically figured out based on configuration information, but for this training, lets set it. Uncomment line 25 and set the name to *trainingcluster*.
1. Later on in this hands on, we are going to want to see some issues in memory configuration for the agent so lets change it to be too low. Update lines 193 to 198 to show **cpu: 20m** and **memory: 32Mi**. This is much lower than they should be and will help us see what happens when resources are low.
1. Now run this helm install command: `helm install datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml stable/datadog`{{execute}}.
1. Open the Datadog Events stream and within a couple minutes you should see the agent trying to start several times. Return to lines 193 to 198 and restore the original settings: **cpu: 200m** and **memory: 256MiB**.
1. Run the helm upgrade command: `helm upgrade datadogagent`{{execute}}. You should see that the agent stays up and running now without any restarts.
1. Now lets verify the health checks;