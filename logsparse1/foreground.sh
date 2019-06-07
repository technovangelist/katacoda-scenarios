# docker pull datadog/agent:6.11.1
# docker pull redis:5.0.5
# docker pull nginx:1.16.0
cat > apikey.env <<EOL
---
DD_API_KEY=${DD_API_KEY}
EOL

git clone https://github.com/DataDog/TrainingEnvironment.git
cp -r TrainingEnvironment/logsparsing/* .
rm -rf TrainingEnvironment

sed -i 's|- DD_HOSTNAME=datadog|- DD_API_KEY\n\t- DD_HOSTNAME=datadog|' docker-compose.yml

sed -i 's|datadog/agent:latest|datadog/agent:6.11.1|' docker-compose.yml
sed -i 's|redis:latest|redis:5.0.5|' docker-compose.yml
sed -i 's|nginx:latest|nginx:1.16.0|' docker-compose.yml

docker-compose up