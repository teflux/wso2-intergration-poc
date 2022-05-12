#!/bin/bash

while ! nc -z apim 9444; do
  echo "Waiting for APIM to become active..."
  sleep 10;
done

tmp_dir=$(mktemp -d -t ci-XXXXXXXXXX)
cd $tmp_dir
echo "Creating temp directory for initialisation - ${tmp_dir}"

echo "Create APICTL env - dockerdev"
apictl  add  env   dockerdev  \
--registration https://apim:9444/ \
--admin https://apim:9444/ \
--publisher https://apim:9444/ \
--devportal https://apim:9444/ \
--token https://apim:9444/

echo "Logging into env dockerdev"
apictl -k  login dockerdev -u admin -p admin

echo "Creating new project for sampleapp1"
apictl -k init sampleapp1 --oas /tmp/openapi-specs/openapi-core-topology.yaml --force=true

echo "Updating endpoint urls"
sed -i 's/localhost:8080/sample-api-1:4010/g' sampleapp1/api.yaml
sed -i 's/localhost:8081/sample-api-1:4010/g' sampleapp1/api.yaml

echo "Deploying sampleapp1 to apim"
apictl -k import api -f sampleapp1/ -e dockerdev

