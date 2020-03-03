1. Let's try again, this time using the helm chart to install the Datadog Agent. First, remove the Agent Daemonset:
`kubectl delete -f k8s-yaml-files/datadog-agent.yaml`{{execute}}
1. Now try installing the helm chart for the Agent:
`helm install --name datadog-agent --set datadog.apiKey=$DD_API_KEY stable/datadog`{{execute}}