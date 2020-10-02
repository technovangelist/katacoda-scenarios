curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
rmdir /root/lab/ecommerceapp
statusupdate tools
mkdir -p /root/lab
cd /ecommworkshop
git pull
# locked to specific commit on 2020-10-02
git checkout 9ce34516d9a65d6f09a6fffd5c4911a409d31e3f
git reset --hard



statusupdate createdirs
docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml pull
statusupdate dockerpulls
statuscheck dockerstart
while [ -z `docker-compose -f /root/lab/ecommerceapp/docker-compose.yaml ps -q db` ] || [ -z `docker ps -q --no-trunc | grep $(docker-compose -f /root/lab/ecommerceapp/docker-compose.yaml ps -q db)` ]; do
  sleep .5
done
sleep 2
statusupdate dbup

statusupdate complete

