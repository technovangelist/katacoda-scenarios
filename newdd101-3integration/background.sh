#!/bin/bash
wall -n Starting to install Redis and Nginx
mkdir -p /root/lab/docker

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
chmod 666 /var/log/redis/redis-server.log
ln -s /etc/redis /root/lab/redis
apt install nginx -y
sudo sed -i '20i location /nginx_status {\n stub_status on;\n  access_log   off;\n allow all;\n}' /etc/nginx/sites-enabled/default
/etc/init.d/nginx stop
/etc/init.d/nginx start
ln -s /etc/nginx /root/lab/nginx
ln -s /etc/datadog-agent /root/lab/datadog
wall -n Redis and Nginx are installed. You can start to follow the instructions now.
docker pull redis 
docker pull nginx
docker pull datadog/agent
chmod 666 /var/log/nginx/access.log
chmod 666 /var/log/nginx/error.log
docker config create nstatus /root/lab/docker/nginx.conf

rm /root/install.sh