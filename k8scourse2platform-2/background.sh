#!/bin/bash
touch status.txt
echo "">/root/status.txt

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm repo add stable https://kubernetes-charts.storage.googleapis.com

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

# if [ ! -f "/root/provisioned" ]; then
#   apt install datamash
# fi

echo "complete">>/root/status.txt