#!/bin/bash

export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres
docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml up -d
echo 'here'
prepenvironment