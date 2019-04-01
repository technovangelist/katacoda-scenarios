#!/bin/bash
mkdir /tracing-workshop
git clone --bare https://github.com/burningion/distributed-tracing-with-apm-workshop ./
git checkout k8s-autodiscovery
