#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate labtools
kubectl delete -f /opt/katacoda-cloud-provider.yaml
while ! [ -f /root/advertisements.yaml ]
do 
    # sleeping, waiting for asset to be loaded
    sleep .5
done

mkdir -p /root/workshop

mkdir /root/completedfiles
launch.sh

# git clone https://github.com/kiritbasu/Fake-Apache-Log-Generator /apachelogs
# cd /apachelogs
# pip install -r requirements.txt
# python apache-fake-log-gen.py -n 100 -o LOG 
helm repo add datadog https://helm.datadoghq.com
helm repo add stable https://charts.helm.sh/stable

helm repo update
# kubectl delete -f /opt/katacoda-cloud-provider.yaml
cp -r /ecommworkshop/* /root/workshop
cp /root/values.yaml /root/workshop/deploy/datadog/helm-values.yaml
cp /root/nodevalues.yaml /root/workshop/deploy/datadog/helm-node-values.yaml
cp /root/frontend.yaml /root/workshop/deploy/generic-k8s/ecommerce-app/frontend.yaml
cp /root/db.yaml /root/workshop/deploy/generic-k8s/ecommerce-app/db.yaml
cp /root/advertisements.yaml /root/workshop/deploy/generic-k8s/ecommerce-app/advertisements.yaml
cp /root/discounts.yaml /root/workshop/deploy/generic-k8s/ecommerce-app/discounts.yaml
statusupdate k8s
# launch.sh
statusupdate complete
