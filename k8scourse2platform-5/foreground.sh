while [ ! `ls -l /root/k8s-yaml-files/*.yaml 2>/dev/null | wc -l ` -eq 5 ]; do
  sleep 0.3
done
clear

ssh -q -o StrictHostKeyChecking=no root@node01 mkdir -p /root/k8s-yaml-files/kube_apiserver_metrics  > /dev/null
clear
while [ ! -f "/usr/local/bin/syncyaml.sh" ]; do
  sleep 0.2
done
syncyaml.sh &

clear
prepenvironment
