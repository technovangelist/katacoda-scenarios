#!/bin/bash
touch /root/startq
mkdir -p /root/lab
bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"
ln -s /etc/datadog-agent /root/lab/datadog
apt-get update -y
apt install redis-server -y
sudo systemctl enable redis-server.service
sudo sed -i '2i maxmemory 256mb' /etc/redis/redis.conf
sudo sed -i '3i maxmemory-policy allkeys-lru' /etc/redis/redis.conf
sudo systemctl restart redis-server.service
ln -s /etc/redis /root/lab/redis
apt install nginx -y
/etc/init.d/nginx start
ln -s /etc/nginx /root/lab/nginx
docker pull redis 
docker pull nginx
docker pull datadog/agent
touch /root/end