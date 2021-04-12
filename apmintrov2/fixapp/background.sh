#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

/ecommworkshop/gor --input-file-loop --input-file /ecommworkshop/requests_0.gor --output-http "http://localhost:3000" >> /dev/null 2>&1