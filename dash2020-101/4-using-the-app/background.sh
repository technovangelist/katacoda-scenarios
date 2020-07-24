curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate tools
mkdir -p /root/lab
sln /ecommworkshop /root/lab/ecommerceapp
statusupdate createdirs
docker pull redis
docker pull datadog/agent
statusupdate dockerpulls
statusupdate complete