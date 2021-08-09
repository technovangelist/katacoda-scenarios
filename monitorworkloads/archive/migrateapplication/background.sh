#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate labtools

mkdir -p /root/workshop
mkdir -p /root/workshop/ads-service
mkdir -p /root/workshop/store-frontend
mkdir -p /root/workshop/storedog
mkdir -p /root/workshop/discounts-service

cp -r /ecommworkshop/ads-service-fixed/* /root/workshop/ads-service
cp -r /ecommworkshop/store-frontend-instrumented-fixed /root/workshop/store-frontend-instrumented-fixed
cp -r /ecommworkshop/storedog /root/workshop/storedog
cp -r /ecommworkshop/discounts-service-fixed /root/workshop/discounts-service
cp -r /ecommworkshop/traffic-replay /root/workshop/traffic-replay
mkdir /root/completedfiles
launch.sh
helm repo add datadog https://helm.datadoghq.com
helm repo add stable https://charts.helm.sh/stable
helm repo update
cp /ecommworkshop/deploy/datadog/helm-values.yaml.example /ecommworkshop/deploy/datadog/helm-values.yaml
statusupdate k8s
# launch.sh
statusupdate complete