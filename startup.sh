#!/bin/bash

sed -i "s/#ZPUSH_HOST#/$ZPUSH_URL/" /var/www/html/config.php
sed -i "s/#BACKEND_TYPE#/$BACKEND_TYPE/" /var/www/html/config.php
sed -i "s/#CALDAV_SERVER#/$CALDAV_SERVER/" /var/www/html/config.php

apache2-foreground