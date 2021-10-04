#!/bin/sh

# Deploy SSH container
docker compose --env-file ../config/.env up $1
