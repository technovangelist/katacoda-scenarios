In the previous hands on section, you setup the agent using the daemonset manifests. We need the agent in this exercise but this time we will install it using the Helm chart. 

1. The command to run is `helm install <release name> --set datadog.apiKey=<api key> stable/datadog`. We will use the name datadog-agent and the api key is set in an environment variable. So you can run this command to get it installed and running:
`helm install datadogagent --set datadog.apiKey=$DD_API_KEY stable/datadog`{{execute}}
1. This just installs the agent with the basic configuration. To customize the installation, 