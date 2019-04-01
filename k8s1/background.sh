#!/bin/bash
git clone https://github.com/burningion/distributed-tracing-with-apm-workshop trace
cd trace
git checkout k8s-autodiscovery
cd ..
mv trace/* .
