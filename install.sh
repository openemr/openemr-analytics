#!/bin/bash
sudo docker stop shiny
sudo docker build -t="shiny" .
sudo docker run --add-host=docker:$(ip route show 0.0.0.0/0 | grep -Eo 'via \S+' | awk '{ print $2 }') --rm -d --name shiny -p 3838:3838 shiny
