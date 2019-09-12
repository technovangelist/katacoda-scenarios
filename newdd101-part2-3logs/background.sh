#!/bin/bash
# mkdir k8s-yaml-files
touch status.txt
echo "">/root/status.txt
if [ ! -f "/root/provisioned" ]; then
  wall -n "Cloning the Github Repo"
  git clone https://github.com/burningion/distributed-tracing-with-apm-workshop trace
  cd trace
  wall -n "Checking out the right branch"
  git checkout -b k8s-autodiscovery 4b0c105fb3158d0418226642b5a3160c020164e8 # locked to commit on may 6, 2019
  cd ..
  wall -n "Getting everything into the right place"
  mv trace/* .
  cd k8s-yaml-files
  sudo sed -i '76,78d' datadog-agent.yaml #pointerdir in volumes
  sudo sed -i '73,74d' datadog-agent.yaml #pointerdir in vol mounts
  sudo sed -i '42,53d' datadog-agent.yaml #the logs and apm env vars
  sudo sed -i '16d' datadog-agent.yaml #hostnetwork
  sudo sed -i '41,42d' frontend-service.yaml #dd_logs_injection
  sudo sed -i '37,38d' frontend-service.yaml # datadog service name
  sudo sed -i '36,39d' node-api.yaml # service name and logs injection
  sudo sed -i '42,43d' pumps-service.yaml # datadogservice name
  sudo sed -i '36,37d' pumps-service.yaml #logs injections
  sudo sed -i '38,39d' sensors-api.yaml #logs injection
  sudo sed -i '34,35d' sensors-api.yaml #service name
fi
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
