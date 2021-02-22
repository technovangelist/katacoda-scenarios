#!/bin/bash
while [ ! -f "/usr/local/bin/prepenvironment" ]; do
  sleep 0.3
done
sleep 0.3

kubeloopstart=`date +%s`
until kubectl create secret generic datadog-api --from-literal=token=$DD_API_KEY
do
  kubeloopend=`date +%s`
  kubeloopruntime=$((kubeloopend-kubeloopstart))
  echo "kubectl isn't ready yet."
  echo "It has been $kubeloopruntime seconds"
  echo "If this doesn't resolve after 60 seconds, contact support."
  sleep 2
done
clear

prepenvironment
