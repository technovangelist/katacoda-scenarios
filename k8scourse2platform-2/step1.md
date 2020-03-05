In the previous hands on section, you setup the agent using the daemonset manifests. We need the agent in this exercise but this time we will install it using the Helm chart. 

1. The command to run is `helm install <release name> --set datadog.apiKey=<api key> stable/datadog`. We will use the name datadog-agent and the api key is set in an environment variable. So you could run this command now to get it installed and running, but we should first setup a custom values file to make sure we have everything configured correctly.
1. In the editor to the right, click on values.yaml



`helm install datadogagent --set datadog.apiKey=$DD_API_KEY stable/datadog`{{execute}}
1. This just installs the agent with the basic configuration. To customize the installation, 