curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate tools
mkdir -p /root/lab
cd /ecommworkshop
git pull
cd /root/lab/ecommworkshop
ln -s /ecommworkshop /root/lab/ecommerceapp
statusupdate createdirs
docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml pull
statusupdate dockerpulls
statusupdate complete