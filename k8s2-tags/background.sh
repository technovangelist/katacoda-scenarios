#!/bin/bash
# mkdir k8s-yaml-files
touch status.txt

wall -n "Starting services"
kubectl apply -f k8s-yaml-files/lotsofpods.yaml
kubectl apply -f k8s-yaml-files/datadog.yaml

echo "complete">>/root/status.txt

