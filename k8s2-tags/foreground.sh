#!/bin/bash
launch.sh
while [ ! -f "/usr/local/bin/prepenvironment" ]; do
  sleep 0.3
done
sleep 0.3
cat > ddapikey.yml <<EOL
---
datadog_api_key: ${DD_API_KEY}
EOL
kubectl create secret generic datadog-api --from-literal=token=$DD_API_KEY
clear


# prepenvironment
