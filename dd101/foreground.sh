#!/bin/bash 
clear

sleep 1
prepenvironment

sleep 10
ansible-playbook /root/ansible/dd101.yaml
sudo service --status-all