#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate labtools

mkdir -p /root/workshop



mkdir /root/completedfiles
launch.sh
helm repo add datadog https://helm.datadoghq.com
helm repo add stable https://charts.helm.sh/stable
helm repo update
cp /ecommworkshop/deploy/datadog/helm-values.yaml.example /ecommworkshop/deploy/datadog/helm-values.yaml
cp -r /ecommworkshop/* /root/workshop
statusupdate k8s
# launch.sh
statusupdate complete