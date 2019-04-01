#!/bin/bash
touch status.txt
wall -n "Cloning the Github Repo"
git clone https://github.com/burningion/distributed-tracing-with-apm-workshop trace
cd trace
wall "Checking out the right branch"
git checkout k8s-autodiscovery
cd ..
wall -n "Getting everything into the right place"
mv trace/* .
echo "complete">>status.txt

