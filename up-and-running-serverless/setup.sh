#!/bin/bash
# source /root/setupaws.sh
ENDPOINT="https://dd.pinkerton.io/4d8bd97f03109ac1ffd4f20894ed216d86476ec97220a3ae5a8a5b3078892139"
RESULT=$( curl -s -d "" "$ENDPOINT" )
mkdir ~/.aws
touch ~/.aws/credentials
echo "[default]" >> ~/.aws/credentials
echo "aws_access_key_id=$( echo $RESULT | jq -r .key )" >> ~/.aws/credentials
echo "aws_secret_access_key=$( echo $RESULT | jq -r .secret )" >> ~/.aws/credentials
