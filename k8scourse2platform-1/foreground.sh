while [ ! `ls -l /root/k8s-yaml-files/*.yaml 2>/dev/null | wc -l ` -eq 5 ]; do
  sleep 0.3
done
k create secret generic datadog-api --from-literal=token=$DD_API_KEY

k apply -f k8s-yaml-files/db.yaml
k apply -f k8s-yaml-files/advertisements.yaml
k apply -f k8s-yaml-files/discounts.yaml
k apply -f k8s-yaml-files/frontend.yaml
clear
prepenvironment