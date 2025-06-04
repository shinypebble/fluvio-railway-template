#!/bin/sh
set -e

# Wait for SC to be ready
echo "Waiting for SC to be available..."
while ! nc -z ${SC_PRIVATE_HOST} 9004; do
  echo "SC not ready, waiting..."
  sleep 5
done

# Start SPU directly - it will auto-register with SC
echo "Starting SPU..."
exec ./fluvio-run spu \
  --id ${SPU_ID:-5001} \
  --public-server ${RAILWAY_PRIVATE_DOMAIN}:9010 \
  --private-server ${RAILWAY_PRIVATE_DOMAIN}:9011 \
  --sc-addr ${SC_PRIVATE_HOST}:9004 \
  --log-base-dir /fluvio/data