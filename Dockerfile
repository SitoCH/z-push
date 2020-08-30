FROM php:7-apache

ENV VERSION 2.3
ENV VERSIONFULL 2.3.9
ENV TERM xterm

ENV ZPUSH_URL zpush_default
ENV CALDAV_SERVER caldav_default
ENV BACKEND_TYPE BackendCalDAV

RUN apt-get update && apt-get install -y wget libawl-php

RUN cd /var/www/html && \
	wget -O - "http://download.z-push.org/final/${VERSION}/z-push-${VERSIONFULL}.tar.gz" | tar --strip-components=1 -x -z && ls -lah

RUN mkdir /var/log/z-push/ && mkdir /var/lib/z-push
RUN chmod -R 777 /var/log/z-push && chmod -R 777 /var/lib/z-push

RUN sed -i "s/#ZPUSH_HOST#/$ZPUSH_URL/" /var/www/html/config.php
RUN sed -i "s/#BACKEND_TYPE#/$BACKEND_TYPE/" /var/www/html/config.php
RUN sed -i "s/#CALDAV_SERVER#/$CALDAV_SERVER/" /var/www/html/config.php

COPY config.php /var/www/html/config.php
COPY default.vhost /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod alias rewrite

COPY ./startup.sh /root/startup.sh
CMD ["/bin/bash", "/root/startup.sh"]