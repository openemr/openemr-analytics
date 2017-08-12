#!/bin/bash
if [ ! -f docker-compose ]; then
    curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` > docker-compose
    chmod +x docker-compose
fi
./docker-compose up -d --build