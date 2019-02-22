#!/bin/bash 
if [ ! -f /root/provisioned ]; then
  cat > ddapikey.yml <<EOL
  ---
  datadog_api_key: ${DD_API_KEY}
  EOL
  clear
  sleep 1

  prepenvironment
fi
# ansible-playbook /root/ansible/dd101.yaml
