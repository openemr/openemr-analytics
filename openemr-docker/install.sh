#!/bin/bash
sudo docker build -t="openemr" .
sudo docker stop openemr
sudo docker run --add-host=docker:$(ip route show 0.0.0.0/0 | grep -Eo 'via \S+' | awk '{ print $2 }') --rm -d --name openemr -p 81:80 openemr
