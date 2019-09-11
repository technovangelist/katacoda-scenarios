#!/bin/bash
touch /root/startq
apt-get update -Y
apt install redis-server nginx -y
sudo systemctl enable redis-server.service
sudo sed -i '2i maxmemory 256mb' /etc/redis/redis.conf
sudo sed -i '3i maxmemory-policy allkeys-lru' /etc/redis/redis.conf
sudo systemctl restart redis-server.service
/etc/init.d/nginx start
touch /root/end