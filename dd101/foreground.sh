#!/bin/bash 
clear
sudo service --status-all

sleep 1
prepenvironment

sleep 1
ansible-playbook /root/ansible/dd101.yaml