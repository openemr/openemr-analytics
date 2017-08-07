FROM ubuntu:latest

# Install dependencies and Download and install shiny server
RUN apt-get update 
RUN apt-get install -y r-base
RUN su - -c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""
RUN apt-get install -y gdebi-core wget
RUN wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb
RUN yes | gdebi shiny-server-1.5.3.838-amd64.deb

CMD shiny-server
EXPOSE 3838
