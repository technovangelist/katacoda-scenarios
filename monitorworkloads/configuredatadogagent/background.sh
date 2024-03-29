#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate labtools
kubectl delete -f /opt/katacoda-cloud-provider.yaml

mkdir -p /root/workshop

mkdir /root/completedfiles
launch.sh

# choosing the last asset in index.json and wait for it
while ! [ -f /root/frontend.yaml ]
do 
    # sleeping, waiting for asset to be loaded
    sleep .5
done

helm repo add datadog https://helm.datadoghq.com
helm repo add stable https://charts.helm.sh/stable
helm repo update
cp -r /ecommworkshop/* /root/workshop
cp /root/values.yaml /root/workshop/deploy/datadog/values.yaml
cp /root/frontend.yaml /root/workshop/deploy/generic-k8s/ecommerce-app/frontend.yaml
sed -i 's/development/production/g' /root/workshop/deploy/generic-k8s/ecommerce-app/advertisements.yaml
sed -i 's/development/production/g' /root/workshop/deploy/generic-k8s/ecommerce-app/db.yaml
sed -i 's/development/production/g' /root/workshop/deploy/generic-k8s/ecommerce-app/discounts.yaml
statusupdate k8s
# launch.sh
statusupdate complete
