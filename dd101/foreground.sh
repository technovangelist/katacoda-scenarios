#!/bin/bash 
clear
sleep 1
prepenvironment
ps -ax|grep apt
# ansible-galaxy install Datadog.datadog
# sleep 1
# ansible-playbook /root/ansible/dd101.yaml