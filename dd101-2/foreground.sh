#!/bin/bash 
clear
sleep 1
prepenvironment
ssh -oStrictHostKeyChecking=no host03 "/root/provision/webprovision.sh&"

ssh -oStrictHostKeyChecking=no host04 "/root/provision/webprovision.sh&"

ssh -oStrictHostKeyChecking=no host05 "/root/provision/webprovision.sh&"

