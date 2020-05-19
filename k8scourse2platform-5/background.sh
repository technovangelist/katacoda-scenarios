#!/bin/bash
touch status.txt
echo "">/root/status.txt
wall -n installing fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all 


# wall -n installing minikube
# curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin

# wall -n installing kubectl
# curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl && chmod +x ./kubectl && sudo mv ./kubectl /usr/local/bin/kubectl && sudo apt-get install -y conntrack
# sudo apt autoremove -y

# wall -n starting minikube
# minikube start --driver=none

wall -n installing helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm repo add stable https://kubernetes-charts.storage.googleapis.com
echo "Waiting for kubernetes to start" >>/root/status.txt
# while [ "$( kubectl get nodes --no-headers 2>/dev/null | wc -l )" != "2" ]; do
#   sleep 1
# done

echo "Waiting for all nodes to be ready" >>/root/status.txt
while [ "$( kubectl get nodes --no-headers 2>/dev/null| awk '{print $2}'|xargs )" !=  "Ready" ]; do
  kubectl get nodes --no-headers 2>/dev/null| awk '{print $2}'|xargs
  sleep 1
done
echo "Kubernetes ready.">>/root/status.txt
  # git clone https://github.com/kubernetes-sigs/metrics-server.git
  # cd metrics-server
  # kubectl create -f deploy/kubernetes
  # cd ..
  # git clone https://github.com/kubernetes/kube-state-metrics.git
  # cd kube-state-metrics
  # kubectl apply -f examples/standard
  # cd ..
  # rm -rf kube-state-metrics
  # rm -rf metrics-server
# kubectl apply -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrole.yaml"

# kubectl apply -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/serviceaccount.yaml"

# kubectl apply -f "https://raw.githubusercontent.com/DataDog/datadog-agent/master/Dockerfiles/manifests/rbac/clusterrolebinding.yaml"


kubectl create secret generic datadog-secret --from-literal=api-key=$DD_API_KEY --namespace=

kubectl apply -f k8s-yaml-files/db.yaml
kubectl apply -f k8s-yaml-files/advertisements.yaml
kubectl apply -f k8s-yaml-files/discounts.yaml
kubectl apply -f k8s-yaml-files/frontend.yaml

# if [ ! -f "/root/provisioned" ]; then
#   apt install datamash
# fi

echo "complete">>/root/status.txt