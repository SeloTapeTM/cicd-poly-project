#!/bin/bash

# ARGS
ARG=$1
VER="latest"

# Update repositories
sudo apt update

# Install docker-engine
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Cleanup script
rm -f get-docker.sh

# Run docker container for Polybot
sudo docker run -p 8443:8443 --restart=always selotapetm/polybotaws:${ARG:-$VER}