#!/bin/bash
until [ -f /usr/local/bin/prepenvironment ]
do
     sleep 0.3
done
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

sed -i '12 i \ \ \ \ \ \ - DD_API_KEY' docker-compose.yml 

sed -i 's|datadog/agent:latest|datadog/agent:6.11.1|' docker-compose.yml

sed -i 's|redis:latest|redis:5.0.5|' docker-compose.yml
sed -i 's|nginx:latest|nginx:1.16.0|' docker-compose.yml

# Insert placeholders for Katacoda IDE
sed -i '/DD_PROCESS_AGENT_ENABLED.*/a # insert environment variables here' docker-compose.yml
sed -i '/\/etc\/passwd:ro.*/a # insert volume here' docker-compose.yml

docker-compose up