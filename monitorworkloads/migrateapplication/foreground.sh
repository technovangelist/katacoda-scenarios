#!/bin/bash
until [ -f "/usr/local/bin/prepenvironment" ]; do
  sleep 0.3
done
statuscheck labtools
clear
helm repo add datadog https://helm.datadoghq.com
helm repo add stable https://charts.helm.sh/stable
helm repo update
cp /ecommworkshop/deploy/datadog/helm-values.yaml.example /ecommworkshop/deploy/datadog/helm-values.yaml
helm install datadogagent datadog/datadog --set datadog.apiKey=$DD_API_KEY -f /ecommworkshop/deploy/datadog/helm-values.yaml

cd /root/workshop || exit
prepenvironment