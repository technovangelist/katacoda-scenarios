Helm Install:
`helm install datadogagent datadog/datadog --set datadog.apiKey="$DD_API_KEY" -f /root/workshop/deploy/datadog/helm-values.yaml`{{execute}}

Agent Status:
`k exec $(k get pod -l app=datadogagent -o jsonpath="{.items[0].metadata.name}") agent status`{{execute}}

