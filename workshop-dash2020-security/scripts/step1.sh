#!/usr/bin/env bash

echo "setting up the environment. This takes a few minutes. Please wait. We will let you know when it's ready." | wall -n

echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config

apt update && apt install -y python3.8-dev

cd /workspace/
echo "cloning security-workshop" | wall -n
git clone https://github.com/jmassey-datadog/security-workshop.git
cd /workspace/security-workshop

echo "we are setting up terraform" | wall -n
cd /tmp/
wget https://releases.hashicorp.com/terraform/0.12.29/terraform_0.12.29_linux_amd64.zip
unzip terraform_0.12.29_linux_amd64.zip
mv terraform /usr/local/sbin

echo "we are setting up your datadog account" | wall -n
cd /workspace/security-workshop/datadog-terraform/
export TF_VAR_DD_API_KEY=$DD_API_KEY
export TF_VAR_DD_APP_KEY=$DD_APP_KEY
terraform init
terraform apply -auto-approve

echo "we are building your web server" | wall -n
cd /workspace/security-workshop
docker-compose build

echo "we are spinning up your web server" | wall -n
docker-compose up -d

echo "we are building the attacker's tooling"
cd /workspace/security-workshop/attacker/
docker build . -t 'attacker'

echo "the following are the running containers" | wall -n
docker ps | wall -n

echo "Your workspace setup is done! Enjoy the workshop :) " | wall -n



