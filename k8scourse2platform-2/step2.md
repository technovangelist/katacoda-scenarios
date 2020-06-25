1. Everything seems to be working now, but let's go ahead and break things for a bit. Update lines 194 to 200 of the values.yaml file to show **cpu: 20m** and **memory: 32Mi**. This is much lower than they should be and will help us see what happens when resources are low.
    The resulting yaml will look like this:
    
        resources: 
          requests:
            cpu: 20m
            memory: 32Mi
          limits:
            cpu: 20m
            memory: 32Mi

1. Run the Helm upgrade command again: `helm upgrade datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml stable/datadog`{{execute}}
1. Open the Datadog Events stream and within a couple minutes you should see the agent trying to start several times. After a while you will also see the agent has restarted a few times when you run `k get pods`{{execute}}. If you aren't seeing any restarts, try running the `agent status` command as you did before. Return to lines 194 to 200 and restore the original settings: **cpu: 200m** and **memory: 256MiB**.
1. Run the helm upgrade command: `helm upgrade datadogagent --set datadog.apiKey=$DD_API_KEY --set datadog.appKey=$DD_APP_KEY -f k8s-yaml-files/values.yaml stable/datadog`{{execute}}. You should see that the agent stays up and running now without any restarts.
