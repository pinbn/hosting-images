#!/bin/bash

if [ ! -d "/var/www/html/wp-content/" ]
then
  echo "Downloading latest Wordpress zip file...";
  cd /tmp;
  wget https://wordpress.org/latest.zip;
  unzip latest.zip;
  mv /tmp/wordpress/* /var/www/html/
else
  echo "Found existing Wordpress installation."
fi
