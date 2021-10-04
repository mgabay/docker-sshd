#!/bin/sh

source ../.env

docker pull oraclelinux:8-slim
docker build -t $SSH_IMG .
