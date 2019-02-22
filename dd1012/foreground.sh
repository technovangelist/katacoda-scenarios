#!/bin/bash 
clear
sleep 1
prepenvironment
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null webprovision.sh host03:webprovision.sh
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null webprovision.sh host04:webprovision.sh
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null webprovision.sh host05:webprovision.sh

ssh -oStrictHostKeyChecking=no host03 "./webprovision.sh"&

ssh -oStrictHostKeyChecking=no host04 "./webprovision.sh"&

ssh -oStrictHostKeyChecking=no host05 "./webprovision.sh"&

