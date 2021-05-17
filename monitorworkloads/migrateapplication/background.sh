#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate labtools

mkdir -p /root/workshop
mkdir -p /root/workshop/ads-service
mkdir -p /root/workshop/store-frontend
mkdir -p /root/workshop/storedog
mkdir -p /root/workshop/discounts-service

cp -r /ecommworkshop/ads-service-fixed/* /root/workshop/ads-service
cp -r /ecommworkshop/store-frontend-instrumented-fixed /root/workshop/store-frontend-instrumented-fixed
cp -r /ecommworkshop/storedog /root/workshop/storedog
cp -r /ecommworkshop/discounts-service-fixed /root/workshop/discounts-service
cp /ecommworkshop/gor /root/workshop
cp -r /ecommworkshop/traffic-replay /root/workshop/traffic-replay

launch.sh
statusupdate complete