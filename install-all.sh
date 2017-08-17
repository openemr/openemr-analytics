#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "Please run as root/with sudo"
  exit
fi
docker --version >/dev/null 2>&1 || {
    echo "Installing docker..."
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce
}
if [ ! -f ./docker-compose ]; then
    echo "Installing docker-compose..."
    curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` > docker-compose
    chmod +x docker-compose
fi
./docker-compose up -d --build