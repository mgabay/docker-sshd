#!/bin/sh

# Remove SSH container
docker compose --env-file ../config/.env down $1
