clear
statuscheck tools
ln -s /ecommworkshop /root/lab/ecommerceapp
cd /root/lab/ecommerceapp/docker-compose-files
clear 
statuscheck dbup
docker-compose -f ./docker-compose-fixed-instrumented.yml exec db psql -U postgres -c  "create user datadog with password 'password';grant pg_monitor to datadog;"
clear
prepenvironment

