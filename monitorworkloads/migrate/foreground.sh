#!/bin/bash
until [ -f "/usr/local/bin/prepenvironment" ]; do
  sleep 0.3
done
statuscheck labtools
clear
prepenvironment