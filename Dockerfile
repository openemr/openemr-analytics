FROM ubuntu:latest

# Install dependencies and Download and install shiny server
RUN apt-get update 
RUN apt-get install -y r-base
RUN su - -c "R -e \"install.packages('shiny', repos='https://cran.rstudio.com/')\""
RUN apt-get install -y gdebi-core wget libxml2-dev libcurl4-openssl-dev libssl-dev
RUN wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb
RUN yes | gdebi shiny-server-1.5.3.838-amd64.deb
RUN R -e 'install.packages(c("devtools", "shiny", "rmarkdown", "dplyr", "readr", "ggplot2", "tidyr", "tibble", "purrr", "stringr", "jsonlite", "data.table", "dbplyr", "RMySQL", "lubridate", "xml2", "readxl", "modelr", "broom", "caret", "tidyverse", "forcats", "curl", "leaflet", "ggthemes", "htmltools", "htmlwidgets", "shinythemes"), repos="http://cran.us.r-project.org")'
RUN apt-get install -y libmariadb-client-lgpl-dev
RUN R -e 'devtools::install_github("rstats-db/DBI")'
RUN R -e 'devtools::install_github("rstats-db/RMariaDB")'

COPY shiny-server /srv/shiny-server

CMD shiny-server
EXPOSE 3838
