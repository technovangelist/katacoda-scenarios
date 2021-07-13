#!/bin/bash

export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres
docker-compose -f /ecommworkshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml up -d
docker-compose -f /ecommworkshop/deploy/docker-compose/docker-compose-traffic-replay.yml up -d
mkdir -p /root/deploy/docker-compose/
cp /ecommworkshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml /root/deploy/docker-compose/
cp -r /ecommworkshop/ads-service-fixed /root/ads-service-fixed
cp -r /ecommworkshop/discounts-service-fixed /root/discounts-service-fixed
cp -r /ecommworkshop/store-frontend-instrumented-fixed /root/store-frontend-instrumented-fixed
cp -r /ecommworkshop/storedog /root/storedog

# cd /ecommworkshop || exit
# ./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000" > /dev/null 2>&1 &
echo 'here'
clear
statuscheck labtools
prepenvironment