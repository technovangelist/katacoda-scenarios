#!/bin/bash
touch status.txt
echo "">/root/status.txt
if [ ! -f "/root/provisioned" ]; then
  apt install datamash
fi

echo "complete">>/root/status.txt

