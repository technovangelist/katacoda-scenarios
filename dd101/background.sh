#!/bin/sh

echo "Setup Installation Framework" > status.txt
apt-add-repository --yes --update ppa:ansible/ansible
apt --yes install ansible

ansible-galaxy install Datadog.datadog
ansible-galaxy install bertvv.httpd
# geerlingguy.php geerlingguy.apache-php-fpm

echo "Installing Services"> status.txt
# ansible-playbook /root/ansible/dd101.yaml
echo "done" > status.txt