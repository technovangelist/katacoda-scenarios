#!/bin/bash 
sleep 1
# prepenvironment
# apt update --yes
# sleep 1
# echo "install spc" > status.txt
# apt install software-properties-common --yes
# sleep 1
# echo "add repo" > status.txt
apt-add-repository --yes --update ppa:ansible/ansible
# sleep 1
# echo "install ansible" > status.txt
apt --yes install ansible
# echo "ansible ready" > status.txt
