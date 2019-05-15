In this exercise, just like in the real world, problems can come up. Unless you know where to look, things can be frustrating. There are a few different commands you can use to try to troubleshoot your Kubernetes environment. 

1. The most common problem users have when working with Datadog is getting the API key wrong. One way to verify this is to open the Integrations > APIs section of the Datadog application. Click on API Keys to see your API key. 
1. Now open the **datadog-agent.yaml** file in the editor. The Datadog agent gets the API key from an environment variable. In the case of this YAML file, the environment variable is being populated from a kubernetes secret. To get the secret you can run:

      `kubectl get secret/datadog-api -o json`

  Here is a command that will filter down the output and base64 decode the api key all in one: `kubectl get secret/datadog-api -o json | jq .data.token | base64 -d -i`{{execute}}

1. Of course, we know that the API key isn't the problem because we are getting some data into Datadog, just not the Postgres metrics.
1. The next thing to look at is the status of the Datadog Agent.
1. We need to run the command `agent status` on the Datadog Agent pod. To get the name of the pod, you can run `kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep datadog`{{execute}}. 
1. Once we have that, run `kubectl exec <pod name> -- agent status`. Or just put it all together and run `kubectl exec $(kubectl get pods --no-headers -o custom-columns=":metadata.name" | grep datadog | head -n 1) -- agent status`{{execute}}
   *Note that we are trying this just on the first pod that matches **datadog**. If you didn't update the **tolerations** earlier, you only have one. Otherwise you may have 2 that match.*
2. Now scroll up to the section that mentions **postgres**.
3. You can see there is an error: password authentication failed. Take a look at the yaml file for postgres-deploy. 
4. The problem is that the password was set to datadog and should in this case be postgres. Make the change to the password and redeploy postgres: `kubectl apply -f k8s-yaml-files/postgres-deploy.yaml`{{execute}}.
   *In this exercise we chose to set the password in the yaml file to make it easier to update. But in the real world you should consider storing passwords in Kubernetes' secrets. For instance, the API key that you accessed above was stored using this command: `kubectl create secret generic datadog-api --from-literal=token=<APIKEYHERE>`*
5. Now re-run the Agent status command above. It may take a few minutes for the postgres check to show up again.
   *Note that the deployment needs to stop and restart, and then the agent needs to update the check so even if everything seems to work but you are still getting an error, give it a little longer and try again.*
6. When everything looks normal, take a look at the dashboards in the Datadog application.
7. In preparation for the rest of the course, enable the APM and Logs features in Datadog. When you navigate to those sections for the first time, you will be prompted to Start a Trial or Start Using the feature.