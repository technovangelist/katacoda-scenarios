curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
rmdir /root/lab/ecommerceapp
statusupdate tools
mkdir -p /root/lab
cd /ecommworkshop
git pull

statusupdate createdirs
docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml pull
statusupdate dockerpulls

statusupdate complete
POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml up -d

