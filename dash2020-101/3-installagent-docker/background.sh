mkdir -p /etc/datadog-agent
touch /etc/datadog-agent/empty
mkdir -p /root/lab
ln -s /etc/datadog-agent /root/lab/datadog-agent
docker pull redis
docker pull datadog/agent