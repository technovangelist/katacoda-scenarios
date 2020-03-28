#!/bin/bash
touch status.txt
echo "">/root/status.txt
if [ ! -f "/root/provisioned" ]; then
  apt install datamash
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

fi

echo "complete">>/root/status.txt

