#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate tools
mv /root/docker-compose.yml /ecommworkshop/
cd /ecommworkshop
git fetch

# fix 2.5 second delay in ads service
git checkout e400e3fc ./ads-service-fixed/ads.py
mv ./ads-service-fixed/ads.py ./ads-service/ads.py

# fix env tagging
sed -i 's/.ruby-shop./ENV["DD_ENV"]/' ./store-frontend-instrumented-fixed/api/config/initializers/datadog.rb
sed -i 's/.ruby-shop./ENV["DD_ENV"]/' ./store-frontend-instrumented-fixed/config/initializers/datadog.rb
sed -i 's/.ruby-shop./ENV["DD_ENV"]/' ./store-frontend-instrumented-fixed/frontend/config/initializers/datadog.rb

# update ddtrace
sed -i 's/ddtrace==0.28.0/ddtrace==0.41.0/g' ./ads-service/requirements.txt
sed -i 's/ddtrace==0.28.0/ddtrace==0.41.0/g' ./discounts-service-fixed/requirements.txt
mv /root/frontend-docker-entrypoint.sh ./store-frontend-instrumented-fixed/docker-entrypoint.sh

statusupdate setup

# Start storedog
statuscheck "environment-variables"
docker-compose --env-file ./docker.env up -d

# Wait for the discounts container to fire up
while [[ -z $(docker ps --filter "name=ecommworkshop_discounts_1" --format '{{.Names}}') ]]
do sleep 5
done

# Break networking on discounts service.
docker run -it -d --rm --name pumba -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba --log-level=info --skip-error netem --tc-image=gaiadocker/iproute2 --duration 90m loss ecommworkshop_discounts_1 --percent 55 

statusupdate complete

# Generate traffic
/ecommworkshop/gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000" >> /dev/null 2>&1
