# docker pull datadog/agent:6.11.1
# docker pull redis:5.0.5
# docker pull nginx:1.16.0
cat > apikey.env <<EOL
---
DD_API_KEY=${DD_API_KEY}
EOL

git clone https://github.com/DataDog/TrainingEnvironment.git
cp -r TrainingEnvironment/logsintro/* .
rm -rf TrainingEnvironment
sed -i 's|vagrant|var/log|g' /root/main.py
sed -i "s|write_text_log('.|write_text_log('/var/log|g" /root/main.py
sed -i "s|write_json_log('.|write_json_log('/var/log|g" /root/main.py

rm install.sh
rm provision.sh
rm Vagrantfile
rm docker-compose.yml
python main.py &
echo "ready"