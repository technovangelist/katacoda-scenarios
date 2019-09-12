#!/usr/bin/env bash

echo "Enter the API Key for your account"
read DD_API_KEY
cat >ddapikey.sh <<EOL
    #!/bin/bash
    sudo sed -i "s/bogusapikey/${DD_API_KEY}/" /etc/datadog-agent/datadog.yaml
    sudo service datadog-agent restart
EOL
sudo sed -i "s/bogusapikey/$DD_API_KEY/" /etc/datadog-agent/datadog.yaml
sudo service datadog-agent restart
scp -o StrictHostKeyChecking=no ddapikey.sh web3:/root/ddapikey.sh
scp -o StrictHostKeyChecking=no ddapikey.sh web2:/root/ddapikey.sh
scp -o StrictHostKeyChecking=no ddapikey.sh web1:/root/ddapikey.sh
export WEB1=$(getent hosts web1 | awk '{ print $1 }')
export WEB2=$(getent hosts web2 | awk '{ print $1 }')
export WEB3=$(getent hosts web3 | awk '{ print $1 }')
echo "sudo sed -i 's/web1ip/$WEB1/' /etc/haproxy/haproxy.cfg" >>ddapikey.sh
echo "sudo sed -i 's/web2ip/$WEB2/' /etc/haproxy/haproxy.cfg" >>ddapikey.sh
echo "sudo sed -i 's/web3ip/$WEB3/' /etc/haproxy/haproxy.cfg" >>ddapikey.sh
echo "echo '127.0.0.1 lb' >> /etc/hosts" >>ddapikey.sh
echo "echo '$WEB1 web1' >> /etc/hosts" >>ddapikey.sh
echo "echo '$WEB2 web2' >> /etc/hosts" >>ddapikey.sh
echo "echo '$WEB3 web3' >> /etc/hosts" >>ddapikey.sh
scp -o StrictHostKeyChecking=no ddapikey.sh lb:/root/ddapikey.sh
ssh web3 'chmod +x /root/ddapikey.sh;hostname web3;/root/ddapikey.sh' &
ssh web2 'chmod +x /root/ddapikey.sh;hostname web2;/root/ddapikey.sh' &
ssh web1 'chmod +x /root/ddapikey.sh;hostname web1;/root/ddapikey.sh' &
ssh lb 'chmod +x /root/ddapikey.sh;hostname lb;/root/ddapikey.sh;sudo service haproxy restart' &

sleep 1
source /root/.nvm/nvm.sh
clear
