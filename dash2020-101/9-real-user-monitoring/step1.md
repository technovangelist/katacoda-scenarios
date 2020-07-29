In this lab we are going to use the fixed version of our site, but it's not started yet. First we need to grab our token.


1. look at source code 
2. get the token

3. copy this to the terminal changing the token to your token
   `DD_CLIENT_TOKEN=CHANGEME`{{copy}}

    `POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose -f /root/ecommworkshop/docker-compose-files/docker-compose.yaml up -d`{{copy}}

4. check that docker is up
5. run this `docker-compose -f /root/ecommworkshop/docker-compose-files/docker-compose.yaml exec -T -d db psql -U postgres -c  "create user datadog with password 'password';grant pg_monitor to datadog;grant SELECT ON pg_stat_database to datadog;"`{{execute}}
6. 