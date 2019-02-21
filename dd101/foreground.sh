#!/bin/bash 
printf "---\ndatadog_api_key: ${DD_API_KEY}" >> /root/ddapikey.yml
clear

sleep 1
env
prepenvironment
# ansible-playbook /root/ansible/dd101.yaml
