#!/bin/bash 
cat > ddapikey.yml <<EOL
---
datadog_api_key: ${DD_API_KEY}
EOL

clear
cat /root/ddapikey.yml
sleep 1
env
prepenvironment
# ansible-playbook /root/ansible/dd101.yaml
