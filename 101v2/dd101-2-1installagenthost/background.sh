curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

mkdir -p /etc/datadog-agent
touch /etc/datadog-agent/empty
mkdir -p /root/lab
ln -s /etc/datadog-agent /root/lab/datadog-agent
statusupdate complete
