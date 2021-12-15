#!/bin/bash
until [ -f "/usr/local/bin/prepenvironment" ]; do
  sleep 0.3
done
statuscheck labtools
clear
statuscheck k8s

helm install datadogagent datadog/datadog --set datadog.apiKey=$DD_API_KEY -f /root/workshop/deploy/datadog/values.yaml

k apply -f /root/workshop/deploy/generic-k8s/ecommerce-app/db.yaml
clear

k apply -f /root/workshop/deploy/generic-k8s/ecommerce-app/discounts.yaml
k apply -f /root/workshop/deploy/generic-k8s/ecommerce-app/advertisements.yaml
k apply -f /root/workshop/deploy/generic-k8s/ecommerce-app/frontend.yaml

cd /root/workshop
prepenvironment
