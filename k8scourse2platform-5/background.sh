#!/bin/bash
touch status.txt
echo "">/root/status.txt

echo "Waiting for kubernetes to start" >>/root/status.txt
while [ "$( kubectl get nodes --no-headers 2>/dev/null | wc -l )" != "2" ]; do
  sleep 1
done
echo "Waiting for all nodes to be ready" >>/root/status.txt
while [ "$( kubectl get nodes --no-headers 2>/dev/null| awk '{print $2}'|xargs )" !=  "Ready Ready" ]; do
  sleep 1
done

# Deleting permissive rbac policy
until curl -ksf https://localhost:6443/healthz ;
do 
    sleep 5
done
kubectl delete clusterrolebinding permissive-binding

while [ ! `ls -l /root/k8s-yaml-files/auditpolicy.yaml 2>/dev/null | wc -l ` -eq 1 ]; do
  sleep 0.3
done
sleep 0.3
cp /root/k8s-yaml-files/auditpolicy.yaml /etc/kubernetes/audit-policies/policy.yaml

grep "audit-policy-file" /etc/kubernetes/manifests/kube-apiserver.yaml || \
	sed -i '/tls-private-key-file/a \ \ \ \ - --audit-policy-file=/etc/kubernetes/audit-policies/policy.yaml' /etc/kubernetes/manifests/kube-apiserver.yaml

grep "audit-log-path" /etc/kubernetes/manifests/kube-apiserver.yaml || \
	sed -i '/audit-policy-file/a \ \ \ \ - --audit-log-path=/var/log/kubernetes/apiserver/audit.log' /etc/kubernetes/manifests/kube-apiserver.yaml

grep "path: /etc/kubernetes/audit-policies" /etc/kubernetes/manifests/kube-apiserver.yaml || \
	sed -i '/volumes:/a \ \ - {hostPath: {path: /etc/kubernetes/audit-policies, type: DirectoryOrCreate}, name: k8s-audit-policies}' /etc/kubernetes/manifests/kube-apiserver.yaml

grep "mountPath: /etc/kubernetes/audit-policies" /etc/kubernetes/manifests/kube-apiserver.yaml || \
	sed -i '/volumeMounts:/a \ \ \ \ - {mountPath: /etc/kubernetes/audit-policies, name: k8s-audit-policies, readOnly: true}' /etc/kubernetes/manifests/kube-apiserver.yaml

grep "path: /var/log/kubernetes" /etc/kubernetes/manifests/kube-apiserver.yaml || \
	sed -i '/volumes:/a \ \ - {hostPath: {path: /var/log/kubernetes, type: DirectoryOrCreate}, name: k8s-logs}' /etc/kubernetes/manifests/kube-apiserver.yaml

grep "mountPath: /var/log/kubernetes" /etc/kubernetes/manifests/kube-apiserver.yaml || \
	sed -i '/volumeMounts:/a \ \ \ \ - {mountPath: /var/log/kubernetes, name: k8s-logs}' /etc/kubernetes/manifests/kube-apiserver.yaml


echo "kubernetes nodes up and running">>/root/status.txt

curl -L https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
echo "helm installed" >>/root/status.txt

(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.{tar.gz,yaml}" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
  "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz &&
  "$KREW" update
)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
kubectl krew install match-name
echo "krew installed" >>/root/status.txt



kubectl create secret generic datadog-secret --from-literal=api-key=$DD_API_KEY 

kubectl apply -f /root/k8s-yaml-files/db.yaml
kubectl apply -f /root/k8s-yaml-files/advertisements.yaml
kubectl apply -f /root/k8s-yaml-files/discounts.yaml
kubectl apply -f /root/k8s-yaml-files/frontend.yaml
echo "Kubernetes ready.">>/root/status.txt

echo "background complete">>/root/status.txt
