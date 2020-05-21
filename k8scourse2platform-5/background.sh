#!/bin/bash
touch status.txt
echo "">/root/status.txt


curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh --version v3.1.2
helm repo add stable https://kubernetes-charts.storage.googleapis.com
echo "Waiting for kubernetes to start" >>/root/status.txt
while [ "$( kubectl get nodes --no-headers 2>/dev/null | wc -l )" != "2" ]; do
  sleep 1
done
echo "Waiting for all nodes to be ready" >>/root/status.txt
while [ "$( kubectl get nodes --no-headers 2>/dev/null| awk '{print $2}'|xargs )" !=  "Ready Ready" ]; do
  sleep 1
done
echo "Kubernetes ready.">>/root/status.txt

kubectl create secret generic datadog-secret --from-literal=api-key=$DD_API_KEY --namespace=

kubectl apply -f k8s-yaml-files/db.yaml
kubectl apply -f k8s-yaml-files/advertisements.yaml
kubectl apply -f k8s-yaml-files/discounts.yaml
kubectl apply -f k8s-yaml-files/frontend.yaml
# if [ ! -f "/root/provisioned" ]; then
#   apt install datamash
# fi

echo "complete">>/root/status.txt