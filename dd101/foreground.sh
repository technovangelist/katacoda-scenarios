#!/bin/bash 
clear
sleep 1
prepenvironment
ansible-galaxy install Datadog.datadog
ansible-playbook /root/ansible/dd101.yaml