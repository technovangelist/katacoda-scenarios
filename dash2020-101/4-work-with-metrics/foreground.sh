clear
statuscheck tools
ln -s /ecommworkshop /root/lab/ecommerceapp
cd /root/lab/ecommerceapp/docker-compose-files
clear 
while [ -z `docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml ps -q db` ] || [ -z `docker ps -q --no-trunc | grep $(docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml ps -q db)` ]; do
  sleep 500
  echo "trying again"
done


docker-compose -f ./docker-compose-fixed-instrumented.yml exec db psql-U postgres -c  "create user datadog2 with password 'password';grant pg_monitor to datadog2;"
prepenvironment

