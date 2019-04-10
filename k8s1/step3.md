In this exercise, just like in the real world, problems can come up. Unless you know where to look, things can be frustrating. There are a few different commands you can use to try to troubleshoot your Kubernetes environment. 

1. The most common problem users have when working with Datadog is getting the API key wrong. One way to verify this is to open the Integrations > APIs section of the Datadog application. Click on API Keys to see your API key. 
1. Now open the **datadog-agent.yaml** file in the editor. The Datadog agent gets the API key from an environment variable. In the case of this YAML file, the environment variable is being populated from a kubernetes secret. To get the secret you can run:

    kubectl get secret/datadog-api -o json 

  here is a command that will filter down the output and base64 decode the api key all in one: `kubectl get secret/datadog-api -o json | jq .data.token | base64 -d -i`{{execute}}