while [ ! `ls -l *.yaml | wc -l ` -eq 4 ]; do
  sleep 0.3
done
k apply -f db.yaml
k apply -f advertisements.yaml
k apply -f discounts.yaml
k apply -f frontend.yaml
clear
prepenvironment