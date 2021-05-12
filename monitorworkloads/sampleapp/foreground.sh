#!/bin/bash

export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres
docker-compose -f /ecommworkshop/deploy/docker-compose/docker-compose-fixed-instrumented.yml up -d
cd /ecommworkshop || exit
./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000" > /dev/null 2>&1 &
echo 'here'
clear
statuscheck labtools
prepenvironment