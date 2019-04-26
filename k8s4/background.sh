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
# sudo sed -i '44,51d' datadog-agent.yaml
# sudo sed -i '39,40d' frontend-service.yaml
# sudo sed -i '33,34d' node-api.yaml
# sudo sed -i '31,32d' pumps-service.yaml
# sudo sed -i '33,34d' sensors-api.yaml
# sudo sed -i '6i\ \ updateStrategy:\n    rollingUpdate:\n      maxUnavailable: 1\n    type: RollingUpdate' datadog-agent.yaml
# sudo sed -i '7i\ \ strategy:\n    type: RollingUpdate\n    rollingUpdate:\n      maxUnavailable: 1\n      maxSurge: 1\n' postgres-deploy.yaml
# sudo sed -i '7i\ \ strategy:\n    type: RollingUpdate\n    rollingUpdate:\n      maxUnavailable: 1\n      maxSurge: 1\n' redis-deploy.yaml
# sudo sed -i '9i\ \ strategy:\n    type: RollingUpdate\n    rollingUpdate:\n      maxUnavailable: 1\n      maxSurge: 1\n' node-api.yaml
# sudo sed -i '9i\ \ strategy:\n    type: RollingUpdate\n    rollingUpdate:\n      maxUnavailable: 1\n      maxSurge: 1\n' sensors-api.yaml
# sudo sed -i '9i\ \ strategy:\n    type: RollingUpdate\n    rollingUpdate:\n      maxUnavailable: 1\n      maxSurge: 1\n' pumps-service.yaml
# sudo sed -i '9i\ \ strategy:\n    type: RollingUpdate\n    rollingUpdate:\n      maxUnavailable: 1\n      maxSurge: 1\n' frontend-service.yaml


sudo sed -i '49,56d' datadog-agent.yaml
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

