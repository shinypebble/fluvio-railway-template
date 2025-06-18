# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Railway template for deploying a Fluvio distributed streaming platform. It consists of three services that must be deployed and configured in a specific order to create a functional cluster.

## Common Commands

### Deployment Commands
```bash
# Deploy to Railway (after setting up the template)
railway up

# Check service logs
railway logs -s sc        # Streaming Controller logs
railway logs -s spu       # SPU logs
railway logs -s registrar # Registrar logs

# SSH into services for debugging
railway ssh -s sc
railway ssh -s spu
```

### Fluvio CLI Commands (after deployment)
```bash
# Configure connection (replace with your TCP proxy endpoint)
fluvio profile add railway tcp-proxy.proxy.rlwy.net:XXXXX

# Verify cluster health
fluvio cluster spu list
fluvio cluster diagnostics

# Topic operations
fluvio topic create test-topic
echo "Hello Fluvio!" | fluvio produce test-topic
fluvio consume test-topic -B -d
```

## Architecture

The system consists of three interconnected services:

1. **Streaming Controller (SC)** at `/sc/`
   - Central metadata coordinator
   - Must start first and be healthy before other services
   - Stores metadata in persistent volume at `/fluvio/metadata`
   - Exposes ports 9003 (public API) and 9004 (private API)

2. **SPU (Streaming Processing Unit)** at `/spu/`
   - Data storage and processing node
   - Requires registration before it can join the cluster
   - Uses startup script to wait for SC availability
   - Stores data in persistent volume at `/fluvio/data`
   - Exposes ports 9005 (public) and 9006 (private)

3. **Registrar** at `/registrar/`
   - One-time service that registers SPU with SC
   - Contains Fluvio CLI (not available in main images)
   - Must run after SC is ready but before SPU starts
   - Uses Alpine Linux with custom Fluvio installation

## Critical Implementation Details

### IPv6 Networking Requirements
All services MUST bind to IPv6 addresses (`[::]`) because Railway uses IPv6-only private networking. Services use `.railway.internal` domains for internal communication.

### Service Startup Order
1. SC must be fully operational first
2. Registrar waits for SC, then registers the SPU
3. SPU waits for registration to complete before starting

### Shell Script Compatibility
Use `#!/bin/sh` (not bash) in shell scripts because the Fluvio images are based on Alpine Linux which doesn't include bash by default.

### Environment Variables
Key variables that must be configured:
- `ENABLE_ALPINE_PRIVATE_NETWORKING=true` - Required for all services
- `SC_PRIVATE_HOST` - Internal SC hostname (usually `sc.railway.internal`)
- `SPU_PRIVATE_HOST` - Internal SPU hostname (usually `spu.railway.internal`)
- `SPU_ID` - Unique identifier for each SPU (default: 5001)

### External Access
To access Fluvio from outside Railway:
1. Enable TCP proxy on SC service (port 9003)
2. For produce/consume operations, also enable TCP proxy on SPU (port 9005)
3. Configure local Fluvio CLI with the TCP proxy endpoints

## Common Issues and Solutions

### SPU Registration Failures
If you see "spu validation failed" errors:
- Check that registrar completed successfully
- Verify SPU_ID uniqueness
- SSH into SC and check `/fluvio/metadata/SPU/` for existing registrations
- Delete old registrations: `rm /fluvio/metadata/SPU/custom-spu-*.yaml`

### Port Configuration Changes
If changing SPU ports from defaults (9005/9006):
- Update in both SPU Dockerfile and start-spu.sh
- Update in registrar's register-spu.sh
- Clear SC metadata to remove old registrations

### Container Startup Errors
"No such file or directory" errors usually mean:
- Wrong shell interpreter (use sh not bash)
- Windows line endings (should be Unix LF)
- Missing execute permissions (handled by Dockerfile)

## Development Workflow

When modifying the template:
1. Test locally with Docker Compose if possible
2. Deploy SC first and verify it's healthy
3. Deploy registrar and check logs for successful registration
4. Deploy SPU and verify it connects to SC
5. Test with Fluvio CLI commands

For adding more SPUs:
1. Create new SPU service with unique SPU_ID (5002, 5003, etc.)
2. Create corresponding registrar service
3. Deploy in order: new registrar → new SPU
4. Update topics for appropriate replication factor