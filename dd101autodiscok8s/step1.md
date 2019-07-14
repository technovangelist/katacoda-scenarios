Let's create the same environment in Kubernetes. 

1.  Review the datadog-agent.yaml file above.
2.  Start the DaemonSet by running `kubectl apply -f docker/datadog-agent.yaml`{{execute}}
3.  Review the `redisapp.yaml` file above.
4.  Add the Deployments by running `kubectl apply -f docker/redisapp.yaml`{{execute}}.
5.  Find the name of your agent pod: `kubectl get pods -l app=datadog-agent`{{execute}}. Then run the Datadog Agent info command on that pod: `kubectl exec [agent pod]  /etc/init.d/datadog-agent info`. Or just merge it all together with this command `kubectl exec $(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' -l app=datadog-agent) agent status`{{execute}}
    If you see an error like container not found, the agent is still starting. Run `kubectl get pods`{{execute}} to see the current status of all the pods.
6.  You should see that only a single redis instance is being monitored.
7.  Update the redis-slave deployment as follows:

    ```
        metadata:
          annotations:
            service-discovery.datadoghq.com/slave.check_names: '["redisdb"]'
            service-discovery.datadoghq.com/slave.init_configs: '[{}]'
            service-discovery.datadoghq.com/slave.instances: '[{"host":"%%host%%","port":"%%port%%"}]'
    ```
8.  Apply the redisapp.yaml file again. Try the Datadog Agent Info command to see how many instances are being monitored.
9.  Can you see where the info in the annotations come from?

Once you have the Redis container running, choose another local integration from the [Integration documentation](http://docs.datadoghq.com/integrations/). Start the container using an image found on the [Docker Hub](https://hub.docker.com/) and create a configuration. At the end of this session, lets talk about how you did it.