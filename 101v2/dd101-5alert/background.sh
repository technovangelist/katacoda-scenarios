#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
echo "Installing Services"> status.txt
echo "done" > status.txt
statusupdate complete