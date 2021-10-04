#!/bin/sh

source ../config/.env

ARGS=" \
  --build-arg SSH_USER=$SSH_USER \
  --build-arg SSH_GROUP=$SSH_GROUP \
  --build-arg SSH_UID=$SSH_UID \
  --build-arg SSH_GID=$SSH_GID \
  --build-arg SSH_BASE_IMG=$SSH_BASE_IMG"

if [ "$SSH_USE_CACHE" = true ]; then
  docker build $ARGS -t $SSH_IMG .
else
  docker pull oraclelinux:8-slim
  docker build $ARGS -t $SSH_IMG . --no-cache
fi
