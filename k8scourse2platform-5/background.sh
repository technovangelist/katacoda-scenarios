#!/bin/bash
touch status.txt
echo "">/root/status.txt

echo "Waiting for kubernetes to start" >>/root/status.txt
while [ "$( kubectl get nodes --no-headers 2>/dev/null | wc -l )" != "2" ]; do
  sleep 1
done
echo "Waiting for all nodes to be ready" >>/root/status.txt
while [ "$( kubectl get nodes --no-headers 2>/dev/null| awk '{print $2}'|xargs )" !=  "Ready Ready" ]; do
  sleep 1
done
echo "kubernetes nodes up and running">>/root/status.txt

curl -L https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
echo "helm installed" >>/root/status.txt

(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
  "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz &&
  "$KREW" update
)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
kubectl krew install match-name
echo "krew installed" >>/root/status.txt



kubectl create secret generic datadog-secret --from-literal=api-key=$DD_API_KEY 

kubectl apply -f /root/k8s-yaml-files/db.yaml
kubectl apply -f /root/k8s-yaml-files/advertisements.yaml
kubectl apply -f /root/k8s-yaml-files/discounts.yaml
kubectl apply -f /root/k8s-yaml-files/frontend.yaml
echo "Kubernetes ready.">>/root/status.txt

echo "background complete">>/root/status.txt