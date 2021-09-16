#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

mv /root/docker-compose-fixed.yml /ecommworkshop/deploy/docker-compose/
mv /root/docker-compose-broken.yml /ecommworkshop/deploy/docker-compose/
mv /root/docker-compose.yml /ecommworkshop/deploy/docker-compose/
statusupdate files

/ecommworkshop/gor --input-file-loop --input-file "/ecommworkshop/requests_0.gor|300%" --output-http "http://localhost:3000" >> /dev/null 2>&1