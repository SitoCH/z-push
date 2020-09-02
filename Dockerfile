FROM php:7-apache

ENV VERSION 2.3
ENV VERSIONFULL 2.3.9
ENV TERM xterm

ENV ZPUSH_URL zpush_default
ENV CALDAV_SERVER caldav_default
ENV BACKEND_TYPE BackendCalDAV

RUN apt-get update && apt-get install -y php5-xsl libawl-php

RUN cd /var/www/html && \
	git clone https://github.com/fmbiete/Z-Push-contrib.git && \
	mv Z-Push-contrib z-push && \
	mkdir /var/lib/z-push && \
	chown www-data /var/lib/z-push && \
	chown www-data /var/log/z-push

COPY config.php /var/www/html/config.php
COPY default.vhost /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod alias rewrite

COPY ./startup.sh /root/startup.sh
CMD ["/bin/bash", "/root/startup.sh"]