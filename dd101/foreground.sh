#!/bin/bash 
clear

sleep 1
prepenvironment

sleep 1
ansible-playbook -vvvv /root/ansible/dd101.yaml
sudo service --status-all