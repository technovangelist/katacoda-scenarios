#!/bin/bash
while [ ! -f "/usr/local/bin/prepenvironment" ]; do
  sleep 0.3
done
sleep 0.3


kubectl create secret generic datadog-api --from-literal=token=$DD_API_KEY
clear


prepenvironment
