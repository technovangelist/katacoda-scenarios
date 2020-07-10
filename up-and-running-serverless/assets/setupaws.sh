#!/bin/bash
ENDPOINT="https://dd.pinkerton.io/4d8bd97f03109ac1ffd4f20894ed216d86476ec97220a3ae5a8a5b3078892139"
RESULT=$( curl -s -d "" "$ENDPOINT" )
echo "AWS_ACCESS_KEY_ID=$( echo $RESULT | jq -r .key )" >> ~/.bashrc
echo "AWS_SECRET_ACCESS_KEY=$( echo $RESULT | jq -r .secret )" >> ~/.bashrc
