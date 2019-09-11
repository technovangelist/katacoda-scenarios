#!/bin/bash
set -ex
wall -n startqq
mkdir -p /root/lab
wall -n starting datadog
curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh -o /root/install.sh
chmod +x /root/install.sh
/root/install.sh
rm /root/install.sh
# mkdir -p /etc/datadog-agent
touch /etc/datadog-agent/empty

ln -s /etc/datadog-agent /root/lab/datadog
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
sleep 2
docker pull redis 
docker pull nginx
docker pull datadog/agent
touch /root/end
wall -n end