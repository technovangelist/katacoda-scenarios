1. Later on in this hands on, we are going to want to see some issues in memory configuration for the agent so lets change it to be too low. Update lines 193 to 198 to show **cpu: 20m** and **memory: 32Mi**. This is much lower than they should be and will help us see what happens when resources are low.
    The resulting yaml will look like this:
    
        resources: 
          requests:
            cpu: 20m
            memory: 32Mi
          limits:
            cpu: 20m
            memory: 32Mi

1. Open the Datadog Events stream and within a couple minutes you should see the agent trying to start several times. Return to lines 193 to 198 and restore the original settings: **cpu: 200m** and **memory: 256MiB**.
1. Run the helm upgrade command: `helm upgrade datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml stable/datadog`{{execute}}. You should see that the agent stays up and running now without any restarts.
1. Now lets verify the health checks. We need the IP address of the agent pod. You could use something like this: `k get pods -o wide`{{execute}} or if you enjoy using jq and want just the pod name and ip address, try this command: `k get pod -o json | jq -r '.items[] | .metadata.name + " - IP: " + .status.podIPs[].ip '`{{execute}}. A great resource for learning more about manipulating the output of kubectl with tools like jq is https://gist.github.com/so0k/42313dbb3b547a0f51a547bb968696ba. 
1. Review line 200 to 208 of values.yaml. You can see this is where the liveness proble is defined for the agent. Now run `curl <pod ip address>:5555/health`, replacing <pod ip address> with the address you found above. 
1. Try going back to the low memory and cpu settings above and trying the healthcheck again. You will see more items in the unhealthy block and few in the healthy block if any at all. When done, return the memory and cpu settings again to the original good values.
1. Finally you can verify the status of the Datadog Agent the same way you do it on other platforms. Just run `k exec <pod name> agent status` replacing pod name with the full name on your cluster. For example, mine is datadogagent-j2q2d right now so I would run `k exec datadogagent-j2q2d agent status`. 

When scanning through the values.yaml file, you may have noticed a section named clusteragent. We will learn more about that in the next section. Click the continue button to move on. 