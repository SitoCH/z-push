FROM php:7-apache

ENV TERM xterm

RUN apt-get update && apt-get install -y libawl-php git

RUN cd /var/www/html && \
	git clone https://github.com/fmbiete/Z-Push-contrib.git && \
	mv Z-Push-contrib z-push && \
	mkdir /var/log/z-push \
	chown www-data /var/lib/z-push && chown www-data /var/log/z-push

COPY config.php /var/www/html/config.php
COPY default.vhost /etc/apache2/sites-enabled/000-default.conf

RUN a2enmod alias rewrite

COPY ./startup.sh /root/startup.sh
CMD ["/bin/bash", "/root/startup.sh"]