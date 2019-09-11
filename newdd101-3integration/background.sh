#!/bin/bash
touch /root/startq
mkdir -p /root/lab
apt-get update -y
apt install redis-server nginx -y
sudo systemctl enable redis-server.service
sudo sed -i '2i maxmemory 256mb' /etc/redis/redis.conf
sudo sed -i '3i maxmemory-policy allkeys-lru' /etc/redis/redis.conf
sudo systemctl restart redis-server.service
/etc/init.d/nginx start
ln -s /etc/redis /root/lab/redis
ln -s /etc/nginx /root/lab/nginx
touch /root/end