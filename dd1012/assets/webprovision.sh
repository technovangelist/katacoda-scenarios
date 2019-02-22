echo "starting" > status.txt
sleep 15
apt --yes update
apt install --yes apache2
echo "woo hoo, got to the end of webprovision" > status.txt