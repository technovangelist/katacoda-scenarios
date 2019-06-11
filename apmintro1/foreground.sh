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

# sed -i 's|datadog/agent:6.2.1|datadog/agent:6.11.0|' docker-compose.yml

perl -pi -e "s|datadog/agent:6.2.1|datadog/agent:6.11.0\n\t\tlabels\n      com.datadoghq.ad.check_names: '[\"disk\"]\n      com.datadoghq.ad.init_configs: '[{}]'\n      com.datadoghq.ad.instances: '[{\"mount_point_blacklist\": \"/host/proc/sys/fs/binfmt_misc\asht\"}]'|" step00/docker-compose.yml
./start00

