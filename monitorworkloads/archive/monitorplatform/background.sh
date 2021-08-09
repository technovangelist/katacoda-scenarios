#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate labtools

mkdir -p /root/workshop

mkdir /root/completedfiles
launch.sh
helm repo add datadog https://helm.datadoghq.com
helm repo add stable https://charts.helm.sh/stable
helm repo update
cp -r /ecommworkshop/* /root/workshop
cp /root/values.yaml /root/workshop/deploy/datadog/helm-values.yaml
statusupdate k8s
# launch.sh
statusupdate complete