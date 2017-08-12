FROM ubuntu:latest

#Install dependencies
RUN apt-get update 
RUN apt-get install -y apache2 git php libapache2-mod-php php-mysql php-xml php-ldap php-soap php-curl curl php-mbstring
#clone openemr
RUN git clone https://github.com/openemr/openemr.git --depth 1
#clean the repo
RUN chmod 666 openemr/sites/default/sqlconf.php
RUN chmod 666 openemr/interface/modules/zend_modules/config/application.config.php
RUN rm -rf openemr/.git
#move it into the apache webroot
RUN mv openemr /var/www/html
RUN chown -R www-data /var/www/html
#configure apache & php properly
COPY php.ini /etc/php/7.0/apache2/php.ini
COPY 000-default.conf /etc/apache2/sites-enabled
#cleanup
RUN apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*
#go
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80