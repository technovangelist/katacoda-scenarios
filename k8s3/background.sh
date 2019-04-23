#!/bin/bash
# mkdir k8s-yaml-files
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
sudo sed -i '73,74d' datadog-agent.yaml
sudo sed -i '37,51d' datadog-agent.yaml
sudo sed -i '39,40d' frontend-service.yaml
sudo sed -i '33,34d' node-api.yaml
sudo sed -i '31,32d' pumps-service.yaml
sudo sed -i '33,34d' sensors-api.yaml
sudo sed -i '6i\tupdateStrategy:\n    rollingUpdate:\n      maxUnavailable: 1\n    type: RollingUpdate' datadog-agent.yaml

# rm datadog-agent.yaml
wall -n "Creating Kubernetes Secrets"
kubectl create secret generic postgres-user --from-literal=token=datadog
kubectl create secret generic postgres-password --from-literal=token=postgres
wall -n "Starting services"
kubectl apply -f redis-deploy.yaml
kubectl apply -f postgres-deploy.yaml
kubectl apply -f node-api.yaml
kubectl apply -f pumps-service.yaml
kubectl apply -f sensors-api.yaml
kubectl apply -f frontend-service.yaml
kubectl apply -f datadog-agent.yaml

echo "complete">>/root/status.txt

