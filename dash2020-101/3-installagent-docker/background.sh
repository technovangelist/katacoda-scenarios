curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate tools
mkdir -p /etc/datadog-agent
touch /etc/datadog-agent/empty
mkdir -p /root/lab
ln -s /etc/datadog-agent /root/lab/datadog-agent
statusupdate createdirs
docker pull redis
docker pull datadog/agent
statusupdate dockerpulls
statusupdate complete