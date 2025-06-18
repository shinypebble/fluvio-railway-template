#!/bin/sh
set -e

# Wait for SC to be ready
echo "Waiting for SC to be available..."
while ! nc -z ${SC_PRIVATE_HOST} 9004; do
  echo "SC not ready, waiting..."
  sleep 5
done

# Give registrar time to register this SPU
echo "Waiting for SPU registration to complete..."
sleep 10

# Start SPU
echo "Starting SPU..."
exec ./fluvio-run spu \
  --id ${SPU_ID:-5001} \
  --public-server ${RAILWAY_PRIVATE_DOMAIN}:9005 \
  --private-server ${RAILWAY_PRIVATE_DOMAIN}:9006 \
  --sc-addr ${SC_PRIVATE_HOST}:9004 \
  --log-base-dir /fluvio/data
  