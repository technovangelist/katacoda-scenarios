curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
rmdir /root/lab/ecommerceapp
statusupdate tools
# mkdir -p /root/lab
cd /ecommworkshop
git pull

statusupdate createdirs
docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-broken-instrumented.yml pull
statusupdate dockerpulls
statuscheck dockerstart
while [ -z `docker-compose -f /root/ecommerceworkshop/docker-compose.yaml ps -q db` ] || [ -z `docker ps -q --no-trunc | grep $(docker-compose -f /root/ecommerceworkshop/docker-compose.yaml ps -q db)` ]; do
  sleep .5
done
sleep 2
statusupdate dbup

statusupdate complete

