#!/bin/bash
while [ ! -f "/usr/local/bin/start" ]; do
  echo -n "."
  sleep 0.2
  
done
/usr/local/bin/start
clear