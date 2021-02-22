sudo service datadog-agent stop
docker kill $(docker ps -q)
docker container rm $(docker container ls -qa)
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
rmdir /root/lab/ecommerceapp
statusupdate tools
cd /ecommworkshop
git pull
# locked to specific commit on 2020-10-02
git checkout 9ce34516d9a65d6f09a6fffd5c4911a409d31e3f
git reset --hard


statusupdate createdirs
docker-compose -f /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml pull
statusupdate dockerpulls

statusupdate complete
