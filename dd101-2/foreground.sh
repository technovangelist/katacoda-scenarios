#!/bin/bash 
clear
sleep 1
prepenvironment
ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null host03 "/root/provision/webprovision.sh&"

ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null host04 "/root/provision/webprovision.sh&"

ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null host05 "/root/provision/webprovision.sh&"

