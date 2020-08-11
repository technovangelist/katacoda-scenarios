#!/bin/bash
# Load it up!
while true; do
  sleep 1
  if sudo grep -i "COMPOSE_FILE" /root/.bashrc; then
    source ~/.bashrc
    break
  fi
done

clear

echo "Your environment is ready to go!"
