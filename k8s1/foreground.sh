#!/bin/bash
cat > ddapikey.yml <<EOL
---
datadog_api_key: ${DD_API_KEY}
EOL

clear


prepenvironment
