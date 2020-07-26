curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
rmdir /root/lab/ecommerceapp
statusupdate tools
mkdir -p /root/lab
cd /ecommworkshop
git pull

statusupdate createdirs
docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml pull
statusupdate dockerpulls
POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml up -d
while [ -z `docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml ps -q db` ] || [ -z `docker ps -q --no-trunc | grep $(docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml ps -q db)` ]; do
  sleep .5
done
docker-compose -f ./docker-compose-fixed-instrumented.yml exec db psql -U postgres -c  "create user datadog with password 'password';grant pg_monitor to datadog;"
statusupdate complete

