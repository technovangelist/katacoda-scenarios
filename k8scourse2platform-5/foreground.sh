while [ ! `ls -l /root/k8s-yaml-files/*.yaml 2>/dev/null | wc -l ` -eq 5 ]; do
  sleep 0.3
done



kube_apiserver_metrics  > /dev/null
syncyaml.sh &

clear
prepenvironment
