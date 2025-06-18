#!/bin/bash
set -e

echo "Waiting for SC to be ready..."
while ! nc -z ${SC_PRIVATE_HOST} 9003; do
  echo "SC not ready, waiting..."
  sleep 5
done

echo "Configuring fluvio profile..."
fluvio profile add railway ${SC_PRIVATE_HOST}:9003

echo "Registering SPU ${SPU_ID} with SC..."
fluvio cluster spu register \
  --id ${SPU_ID:-5001} \
  --public-server ${SPU_PRIVATE_HOST}:9005 \
  --private-server ${SPU_PRIVATE_HOST}:9006

echo "SPU registered successfully!"
echo "Registration complete, keeping container alive for debugging..."
sleep infinity