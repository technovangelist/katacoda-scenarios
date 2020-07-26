clear
statuscheck tools
ln -s /ecommworkshop /root/lab/ecommerceapp
cd /root/lab/ecommerceapp/docker-compose-files
clear
statuscheck dockerpulls
POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml up -d
statusupdate dockerstart
clear 
statuscheck dbup
docker-compose -f ./docker-compose-fixed-instrumented.yml exec -T -d db psql -U postgres -c  "create user datadog with password 'password';grant pg_monitor to datadog;"


clear
prepenvironment

