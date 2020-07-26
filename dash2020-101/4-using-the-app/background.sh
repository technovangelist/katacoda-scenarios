curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate tools
mkdir -p /root/lab
ln -s /ecommworkshop /root/lab/ecommerceapp
statusupdate createdirs
docker pull redis
docker pull datadog/agent
statusupdate dockerpulls
statusupdate complete