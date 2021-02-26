#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
mkdir -p /root/lab/docker

mkdir -p /etc/datadog-agent
touch /etc/datadog-agent/empty

sudo apt-get update -y

sudo apt-get install -y curl
curl --fail --silent --show-error --location https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get install -y software-properties-common
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get install -y docker-ce
sudo usermod -aG docker ${USER}
sudo curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo apt-get install redis-server -y
echo redis installed
sudo systemctl enable redis-server.service
sudo sed -i '2i maxmemory 256mb' /etc/redis/redis.conf
sudo sed -i '3i maxmemory-policy allkeys-lru' /etc/redis/redis.conf
echo sed done
sudo systemctl restart redis-server.service
chmod 644 /var/log/redis/redis-server.log
chmod 777 /var/log/redis
ln -s /etc/redis /root/lab/redis
apt install nginx -y
sudo sed -i '20i location /nginx_status {\n stub_status on;\n  access_log   off;\n allow all;\n}' /etc/nginx/sites-enabled/default
/etc/init.d/nginx stop
/etc/init.d/nginx start
ln -s /etc/nginx /root/lab/nginx
ln -s /etc/datadog-agent /root/lab/datadog

docker pull redis:6.0.11
docker pull nginx:1.19.7
docker pull datadog/agent:7.25.1
chmod 666 /var/log/nginx/access.log
chmod 666 /var/log/nginx/error.log

rm /root/install.sh
statusupdate complete