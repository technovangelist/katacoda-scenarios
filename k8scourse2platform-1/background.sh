#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate tools

# if [ ! -f "/root/provisioned" ]; then
#   apt install datamash
# fi

echo "complete">>/root/status.txt