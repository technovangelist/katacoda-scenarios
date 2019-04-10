In this exercise, just like in the real world, problems can come up. Unless you know where to look, things can be frustrating. There are a few different commands you can use to try to troubleshoot your Kubernetes environment. 

1. The most common problem users have when working with Datadog is getting the API key wrong. One way to verify this is to open the Integrations > APIs section of the Datadog application. Click on API Keys to see your API key. 
1. Now open the **datadog-agent.yaml** file in the editor. The Datadog agent gets the API key from an environment variable. In the case of this YAML file, the environment variable is being populated from a kubernetes secret. To get the secret you can run:

      `kubectl get secret/datadog-api -o json`

  Here is a command that will filter down the output and base64 decode the api key all in one: `kubectl get secret/datadog-api -o json | jq .data.token | base64 -d -i`{{execute}}

1. Of course, we know that the API key isn't the problem because we are getting some data into Datadog, just not the Postgres metrics.
1. The next thing to look at is the status of the Datadog Agent.
1. We need to run the command `agent status` on the Datadog Agent pod. To get the name of the pod, you can run `kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep datadog`. 
1. Once we have that, run `kubectl exec <pod name> -- agent status`. Or just put it all together and run `kubectl exec $(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep datadog) -- agent status`{{execute}}
1. Now scroll up to the section that mentions **postgres**.
1. You can see there is an error: password authentication failed. Take a look at the yaml file for postgres-deploy. 
1. The problem is that the password was set to datadog and should in this case be postgres. Make the change to the password and redeploy postgres: `kubectl delete -f k8s-yaml-files/postgres-deploy.yaml;kubectl apply -f k8s-yaml-files/postgres-deploy.yaml`{{execute}}.
1. Now re-run the Agent status command above. It may take a few minutes for the postgres check to show up again.
1. When everything looks normal, take a look at the dashboards in the Datadog application. 