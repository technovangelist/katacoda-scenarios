#!/bin/bash
wall Starting to install Redis and Nginx
mkdir -p /root/lab

mkdir -p /etc/datadog-agent
touch /etc/datadog-agent/empty

sudo apt-get update -y
sudo apt-get install redis-server -y
echo redis installed
sudo systemctl enable redis-server.service
sudo sed -i '2i maxmemory 256mb' /etc/redis/redis.conf
sudo sed -i '3i maxmemory-policy allkeys-lru' /etc/redis/redis.conf
echo sed done
sudo systemctl restart redis-server.service
ln -s /etc/redis /root/lab/redis
apt install nginx -y
/etc/init.d/nginx start
ln -s /etc/nginx /root/lab/nginx
ln -s /etc/datadog-agent /root/lab/datadog
wall Redis and Nginx are installed. You can start to follow the instructions now.
docker pull redis 
docker pull nginx
docker pull datadog/agent


rm /root/install.sh