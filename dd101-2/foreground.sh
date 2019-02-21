#!/bin/bash 
clear
sleep 1
prepenvironment
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null /root/provision/webprovision.sh host03:/root/provision/webprovision.sh
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null /root/provision/webprovision.sh host04:/root/provision/webprovision.sh
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null /root/provision/webprovision.sh host05:/root/provision/webprovision.sh

ssh -oStrictHostKeyChecking=no host03 "/root/provision/webprovision.sh&"

ssh -oStrictHostKeyChecking=no host04 "/root/provision/webprovision.sh&"

ssh -oStrictHostKeyChecking=no host05 "/root/provision/webprovision.sh&"

