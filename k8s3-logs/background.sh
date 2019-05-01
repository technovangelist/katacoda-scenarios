#!/bin/bash
# mkdir k8s-yaml-files
launch.sh
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
sudo sed -i '81,83d' datadog-agent.yaml
sudo sed -i '78,79d' datadog-agent.yaml
sudo sed -i '42,56d' datadog-agent.yaml
sudo sed -i '44,45d' frontend-service.yaml
sudo sed -i '40,41d' frontend-service.yaml
sudo sed -i '36,39d' node-api.yaml
sudo sed -i '42,43d' pumps-service.yaml
sudo sed -i '36,37d' pumps-service.yaml
sudo sed -i '38,39d' sensors-api.yaml
sudo sed -i '34,35d' sensors-api.yaml

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

