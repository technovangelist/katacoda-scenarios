#!/bin/bash
until [ -f "/usr/local/bin/prepenvironment" ]; do
  sleep 0.3
done
statuscheck labtools
clear
statuscheck k8s
helm install datadogagent-controlplane datadog/datadog --set datadog.apiKey=$DD_API_KEY -f /root/workshop/deploy/datadog/helm-values.yaml
# sleep 5
# wait-for-it $(k get service/db -o jsonpath='{.spec.clusterIP}'):6443
# waitfork8s
while ! k get pods
do
    sleep 1
done
k get deploy/db -o jsonpath='{.status}' |jq
sleep 2
k get deploy/db -o jsonpath='{.status}' |jq
sleep 2
k get deploy/db -o jsonpath='{.status}' |jq
sleep 2
k get deploy/db -o jsonpath='{.status}' |jq
sleep 2
k get deploy/db -o jsonpath='{.status}' |jq
sleep 2
k get deploy/db -o jsonpath='{.status}' |jq

# k wait deploy/datadogagent-controlplane-cluster-agent --for condition=available
# k config get-clusters 

# k get pods
# k get nodes
helm install datadogagent datadog/datadog --set datadog.apiKey=$DD_API_KEY -f /root/workshop/deploy/datadog/helm-node-values.yaml
# kubectl wait --for=condition=ready pod -l app=datadogagent
k apply -f /root/workshop/deploy/generic-k8s/ecommerce-app/db.yaml
k get pod/db
# clear
# wait-for-it $(k get service/db -o jsonpath='{.spec.clusterIP}'):5432
# k wait deploy/db --for condition=available
k apply -f /root/workshop/deploy/generic-k8s/ecommerce-app/discounts.yaml
k apply -f /root/workshop/deploy/generic-k8s/ecommerce-app/advertisements.yaml
k apply -f /root/workshop/deploy/generic-k8s/ecommerce-app/frontend.yaml

cd /root/workshop || exit
# prepenvironment