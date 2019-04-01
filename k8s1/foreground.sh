#!/bin/bash
while [ ! -f "/usr/local/bin/prepenvironment" ]; do
  echo "."
done
cat > ddapikey.yml <<EOL
---
datadog_api_key: ${DD_API_KEY}
EOL

clear


prepenvironment
