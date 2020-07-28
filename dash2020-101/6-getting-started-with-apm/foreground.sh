clear
statuscheck tools
# ln -s /ecommworkshop /root/ecommerceworkshop
statuscheck pulls
mv /ecommworkshop /root
mv /root/docker-compose.yaml /root/ecommworkshop/docker-compose-files/
cd /root/ecommworkshop/docker-compose-files
clear
POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose up -d
statusupdate dockerstart
clear 
statuscheck dbup
ln -s docker-compose.yaml ../store-frontend-broken-instrumented

docker-compose exec -T -d db psql -U postgres -c  "create user datadog with password 'password';grant pg_monitor to datadog;grant SELECT ON pg_stat_database to datadog;"

cd
clear
prepenvironment

