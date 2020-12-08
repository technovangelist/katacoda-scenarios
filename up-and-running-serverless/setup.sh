#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate tools
ENDPOINT="https://gvgx8c2xfj.execute-api.us-east-1.amazonaws.com/get-credentials"
RESULT=$( curl -s "$ENDPOINT" )
mkdir ~/.aws
touch ~/.aws/credentials
echo "[default]" > ~/.aws/credentials
echo "aws_access_key_id=$( echo $RESULT | jq -r .key )" >> ~/.aws/credentials
echo "aws_secret_access_key=$( echo $RESULT | jq -r .secret )" >> ~/.aws/credentials
statusupdate complete