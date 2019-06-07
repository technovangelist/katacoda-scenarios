# docker pull datadog/agent:6.11.1
# docker pull redis:5.0.5
# docker pull nginx:1.16.0
cat > apikey.env <<EOL
---
DD_API_KEY=${DD_API_KEY}
EOL

git clone https://github.com/DataDog/TrainingEnvironment.git
cp -r TrainingEnvironment/apm/* .
rm -rf TrainingEnvironment

# sed -i 's|- DD_APM_ENABLED=true|- DD_API_KEY\n\t- DD_APM_ENABLED=true|' docker-compose.yml

