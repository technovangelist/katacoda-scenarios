mkdir /etc/datadog-agent
mkdir /root/labfiles
mkdir /root/labfiles/vmfiles
# echo "echo 'This directory is actually located at /etc/datadog-agent'" > /etc/datadog-agent/.envrc
ln -s /etc/datadog-agent/datadog.yaml /root/labfiles/vmfiles/datadog.yaml
mkdir /root/labfiles/dockerfiles