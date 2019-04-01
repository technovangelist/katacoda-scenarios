#!/bin/bash
touch status.txt
wall -n "Cloning the Github Repo"
git clone https://github.com/burningion/distributed-tracing-with-apm-workshop trace
cd trace
wall -n "Checking out the right branch"
git checkout k8s-autodiscovery
cd ..
wall -n "Getting everything into the right place"
mv trace/* .
cd k8s-yaml-files
wall -n "Creating Kubernetes Secrets"
kubectl create secret generic datadog-api --from-literal=token=$DD_API_KEY
kubectl create secret generic postgres-user --from-literal=token=postgres
kubectl create secret generic postgres-password --from-literal=token=password
wall -n "Starting services"
# kubectl apply -f redis-deploy.yaml
# kubectl apply -f postgres-deploy.yaml
# kubectl apply -f node-api.yaml
# kubectl apply -f pumps-service.yaml
# kubectl apply -f sensors-api.yaml
# kubectl apply -f frontend-service.yaml
echo "complete">>status.txt

