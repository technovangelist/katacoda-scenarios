#!/bin/bash
until [ -f "/usr/local/bin/prepenvironment" ]; do
  sleep 0.3
done
statuscheck labtools
clear
statuscheck k8s
helm install datadogagent-controlplane datadog/datadog --set datadog.apiKey=$DD_API_KEY -f /root/workshop/deploy/datadog/helm-values.yaml
helm install datadogagent datadog/datadog --set datadog.apiKey=$DD_API_KEY -f /root/workshop/deploy/datadog/helm-node-values.yaml
k apply -f /root/workshop/deploy/generic-k8s/ecommerce-app/
cd /root/workshop || exit
prepenvironment