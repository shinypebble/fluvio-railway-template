#!/bin/bash
set -e

echo "Waiting for SC to be ready..."
while ! nc -z ${SC_PRIVATE_HOST} 9003; do
  echo "SC not ready, waiting..."
  sleep 5
done

echo "Configuring fluvio profile..."
fluvio profile add railway ${SC_PRIVATE_HOST}:9003 railway

echo "Registering SPU ${SPU_ID} with SC..."
fluvio cluster spu register \
  --id ${SPU_ID:-5001} \
  --public-server ${SPU_PRIVATE_HOST}:9010 \
  --private-server ${SPU_PRIVATE_HOST}:9011

echo "SPU registered successfully!"
echo "Registration complete, keeping container alive for debugging..."
sleep infinity