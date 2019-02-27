#!/bin/bash 
cat > ddapikey.yml <<EOL
---
datadog_api_key: ${DD_API_KEY}
EOL
pip install requests
clear
sleep 1

prepenvironment

# ansible-playbook -v /root/ansible/dd101.yaml
