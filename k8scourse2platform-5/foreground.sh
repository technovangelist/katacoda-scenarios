while [ ! `ls -l /root/k8s-yaml-files/*.yaml 2>/dev/null | wc -l ` -eq 5 ]; do
  sleep 0.3
done
clear

clear


clear
prepenvironment
