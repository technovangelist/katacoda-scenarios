#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate labtools

mkdir -p /root/workshop

mkdir /root/completedfiles
launch.sh

# choosing the last asset in index.json and wait for it
while ! [ -f /root/inituserdb.sh ]
do 
    # sleeping, waiting for asset to be loaded
    sleep .5
done

helm repo add datadog https://helm.datadoghq.com
helm repo add stable https://charts.helm.sh/stable
helm repo update
cp -r /ecommworkshop/* /root/workshop
cp /root/values.yaml /root/workshop/deploy/datadog/helm-values.yaml
cp /root/nodevalues.yaml /root/workshop/deploy/datadog/helm-node-values.yaml
cp /root/frontend.yaml /root/workshop/deploy/generic-k8s/ecommerce-app/frontend.yaml
mkdir -p /root/workshop/deploy/generic-k8s/ecommerce-app/dbinit
cp /root/inituserdb.sh /root/workshop/deploy/generic-k8s/ecommerce-app/dbinit/inituserdb.sh
statusupdate k8s
# launch.sh
statusupdate complete
