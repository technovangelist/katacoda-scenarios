#!/bin/bash
# mkdir k8s-yaml-files
touch status.txt

wall -n "Starting services"
kubectl apply -f lotsofpods.yaml

echo "complete">>/root/status.txt

