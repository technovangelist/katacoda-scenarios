#!/bin/bash
# mkdir k8s-yaml-files
launch.sh
touch status.txt
wall -n "Cloning the Github Repo"
git clone https://github.com/burningion/distributed-tracing-with-apm-workshop trace
cd trace
wall -n "Checking out the right branch"
git checkout -b k8s-autodiscovery 4b0c105fb3158d0418226642b5a3160c020164e8 # locked to commit on may 6, 2019
cd ..
wall -n "Getting everything into the right place"
mv trace/* .
cd k8s-yaml-files
sudo sed -i '16d' datadog-agent.yaml #hostnetwork

#sudo sed -i '6i\ \ updateStrategy:\n    rollingUpdate:\n      maxUnavailable: 1\n    type: RollingUpdate' datadog-agent.yaml
#sudo sed -i '7i\ \ strategy:\n    type: RollingUpdate\n    rollingUpdate:\n      maxUnavailable: 1\n      maxSurge: 1\n' postgres-deploy.yaml

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

echo "complete">>/root/status.txt

