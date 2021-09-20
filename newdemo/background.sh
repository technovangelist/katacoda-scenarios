#!/bin/bash
# Put stuff here that runs in a background process, invisible to the learner.

# # Get the latest scenario tools
# curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

# # Wait for required assets to appear in the filesystem
# until  [ -f /root/docker-compose.yml ]
# do
#   sleep 2
# done

# # Create a tidy workspace for the learner
# mkdir /root/lab
# mv /root/docker-compose.yml /root/lab

# statusupdate "workspace"
# statuscheck "environment-variables"

# # cd /root/lab && docker-compose up -d

# statusupdate "storedog"
