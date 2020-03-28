#!/bin/bash
touch status.txt
echo "">/root/status.txt

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm repo add stable https://kubernetes-charts.storage.googleapis.com
echo "Waiting for kubernetes to start" >>/root/status.txt
while [ "$(k get nodes --no-headers 2>/dev/null | wc -l )" != "2"]; do
  wall -n waiting for nodes to show
  sleep 1
done
echo "Waiting for all nodes to be ready" >>/root/status.txt
while [ "$(k get nodes --no-headers 2>/dev/null| awk '{print $2}'|xargs)" !=  'Ready Ready']; do
  wall -n now waiting for nodes to start
  sleep 1
done
echo "Kubernetes ready.">>/root/status.txt
  git clone https://github.com/kubernetes-sigs/metrics-server.git
  cd metrics-server
  kubectl create -f deploy/kubernetes
  cd ..
  git clone https://github.com/kubernetes/kube-state-metrics.git
  cd kube-state-metrics
  kubectl apply -f examples/standard
  cd ..
  rm -rf kube-state-metrics
  rm -rf metrics-server
k create secret generic datadog-api --from-literal=token=$DD_API_KEY

k apply -f k8s-yaml-files/db.yaml
k apply -f k8s-yaml-files/advertisements.yaml
k apply -f k8s-yaml-files/discounts.yaml
k apply -f k8s-yaml-files/frontend.yaml
# if [ ! -f "/root/provisioned" ]; then
#   apt install datamash
# fi

echo "complete">>/root/status.txt