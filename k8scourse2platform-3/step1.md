In the previous hands on section, you setup the agent using the daemonset manifests. We need the agent in this exercise but this time we will install it using the Helm chart. 

1. The command to run to install the Datadog helm chart is `helm install <release name> --set datadog.apiKey=<api key> stable/datadog`. If this is your introduction to using Helm, then release name is whatever you want to call this deployment. We will use the name datadogagent and the api key is set with an environment variable. So you could run this command now to get it installed and running, but we should first setup a custom values file to make sure we have everything configured correctly.
1. Open values.yaml in the editor to the right.
1. Set the API and App Key to come from environment variables but uncommenting lines 16 and 18.
1. Usually the cluster's name will be automatically figured out based on configuration information, but for this training, lets set it. Uncomment line 25 and set the name to *trainingcluster*.
1. Later on in this hands on, we are going to want to see some issues in memory configuration for the agent so lets change it to be too low. Update lines 193 to 198 to show **cpu: 20m** and **memory: 32Mi**. This is much lower than they should be and will help us see what happens when resources are low.
1. Now run this helm install command: `helm install datadogagent -f k8s-yaml-files/values.yaml stable/datadog`{{execute}}.
1. Open the Datadog Events stream and within a couple minutes you should see the agent trying to start several times. Return to lines 193 to 198 and restore the original settings: **cpu: 200m** and **memory: 256MiB**.
    The resulting yaml will look like this:
    
        resources: 
          requests:
            cpu: 20m
            memory: 32Mi
          limits:
            cpu: 20m
            memory: 32Mi

1. Run the helm upgrade command: `helm upgrade datadogagent -f k8s-yaml-files/values.yaml stable/datadog`{{execute}}. You should see that the agent stays up and running now without any restarts.
1. Now lets verify the health checks. We need the IP address of the agent pod. You could use something like this: `k get pods -o wide`{{execute}} or if you enjoy using jq and want just the pod name and ip address, try this command: `k get pod -o json | jq -r '.items[] | .metadata.name + " - IP: " + .status.podIPs[].ip '`{{execute}}. A great resource for learning more about manipulating the output of kubectl with tools like jq is https://gist.github.com/so0k/42313dbb3b547a0f51a547bb968696ba. 
1. Review line 200 to 208 of values.yaml. You can see this is where the liveness proble is defined for the agent. Now run `curl <pod ip address>:5555/health`, replacing <pod ip address> with the address you found above. 
1. Try going back to the low memory and cpu settings above and trying the healthcheck again. You will see more items in the unhealthy block and few in the healthy block if any at all. When done, return the memory and cpu settings again to the original good values.
1. Finally you can verify the status of the Datadog Agent the same way you do it on other platforms. Just run `k exec <pod name> agent status` replacing pod name with the full name on your cluster. For example, mine is datadogagent-j2q2d right now so I would run `k exec datadogagent-j2q2d agent status`. 

When scanning through the values.yaml file, you may have noticed a section named clusteragent. We will learn more about that in the next section. Click the continue button to move on. 