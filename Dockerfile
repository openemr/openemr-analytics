FROM ubuntu:latest

# Install dependencies and Download and install shiny server
RUN echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" >> /etc/apt/sources.list
RUN gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9
RUN gpg -a --export E084DAB9 | apt-key add -
#RUN add-apt-repository ppa:marutter/rdev
RUN apt-get update 
RUN apt-get install -y r-base r-base-dev
RUN su - -c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""
#Pull down prerequisites and install shiny-server
RUN apt-get install -y gdebi-core wget libxml2-dev libcurl4-openssl-dev libssl-dev
RUN wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb
RUN yes | gdebi shiny-server-1.5.3.838-amd64.deb
#install R dependencies
RUN R -e 'install.packages(c("devtools", "shiny", "rmarkdown", "dplyr", "readr", "ggplot2", "tidyr", "tibble", "purrr", "stringr", "jsonlite", "data.table", "dbplyr", "RMySQL", "lubridate", "xml2", "readxl", "modelr", "broom", "caret", "tidyverse", "forcats", "curl", "leaflet", "ggthemes", "htmltools", "htmlwidgets", "shinythemes"), repos="http://cran.us.r-project.org")'
RUN apt-get install -y libmariadb-client-lgpl-dev
RUN R -e 'devtools::install_github("rstats-db/DBI")'
RUN R -e 'devtools::install_github("rstats-db/RMariaDB")'
#install Rstudio-server
RUN wget https://download2.rstudio.org/rstudio-server-1.0.153-amd64.deb
RUN apt-get install -y sudo psmisc locales libapparmor1 git
RUN update-locale
RUN yes | gdebi rstudio-server-1.0.153-amd64.deb
RUN (adduser --disabled-password --gecos "" guest && echo "guest:guest"|chpasswd)
#cleanup
RUN rm shiny-server-1.5.3.838-amd64.deb
RUN rm rstudio-server-1.0.153-amd64.deb
RUN apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*
#add in the shiny apps
#mounted as a volume in the development branch
#COPY shiny-server /srv/shiny-server
#go
CMD /usr/lib/rstudio-server/bin/rserver --server-daemonize off & shiny-server
EXPOSE 3838 8787