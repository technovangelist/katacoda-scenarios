curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate tools
mkdir -p /root/lab
cd /ecommworkshop
git pull
cd /root
ln -s /ecommworkshop /root/lab/ecommerceapp
statusupdate createdirs
docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml pull
docker pull redis
docker pull datadog/agent
statusupdate dockerpulls
statusupdate complete