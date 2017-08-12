#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root/with sudo"
  exit
fi
if [ ! -f ./docker-compose ]; then
    curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` > docker-compose
    chmod +x docker-compose
fi
./docker-compose up -d --build