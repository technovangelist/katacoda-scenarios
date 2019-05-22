# docker pull datadog/agent:6.11.1
# docker pull redis:5.0.5
# docker pull nginx:1.16.0

git clone https://github.com/DataDog/TrainingEnvironment.git
cp -r TrainingEnvironment/logsintro/* .
rm -rf TrainingEnvironment
sed -i 's|datadog/agent:latest|datadog/agent:6.11.1|' docker-compose.yml
sed -i 's|redis:latest|redis:5.0.5|' docker-compose.yml
sed -i 's|nginx:latest|nginx:1.16.0|' docker-compose.yml
echo "DD_API_KEY=thisisabogusapikey" >> apikey.env
docker-compose up