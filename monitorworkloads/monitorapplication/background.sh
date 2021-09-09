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
# cp /root/values.yaml /root/workshop/deploy/datadog/helm-values.yaml
# cp /root/nodevalues.yaml /root/workshop/deploy/datadog/helm-node-values.yaml
cp /root/frontend.yaml /root/workshop/deploy/generic-k8s/ecommerce-app/frontend.yaml
cp /root/db.yaml /root/workshop/deploy/generic-k8s/ecommerce-app/db.yaml
cp /root/advertisements.yaml /root/workshop/deploy/generic-k8s/ecommerce-app/advertisements.yaml
cp /root/discounts  .yaml /root/workshop/deploy/generic-k8s/ecommerce-app/discounts.yaml
statusupdate k8s
# launch.sh
statusupdate complete