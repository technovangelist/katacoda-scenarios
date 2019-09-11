mkdir /etc/datadog-agent
apt install direnv
echo "echo 'This directory is actually located at /etc/datadog-agent'" > .envrc
ln -s /etc/datadog-agent /root/vmfiles
mkdir /root/dockerfiles