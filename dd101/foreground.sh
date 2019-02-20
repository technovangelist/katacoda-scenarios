#!/bin/bash 
clear
ps cax | grep -v grep | grep snapd
sleep 1
prepenvironment
ps cax | grep -v grep | grep snapd

# sleep 10
ansible-playbook /root/ansible/dd101.yaml
sudo service --status-all