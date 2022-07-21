#!/bin/bash

if [ ! -d "/var/www/html/wp-content/" ]
then
  echo "Downloading latest Wordpress zip file...";
  cd /var/www;
  wget https://wordpress.org/latest.zip;
  unzip latest.zip
else
  echo "Found existing Wordpress installation."
fi

if [[ ! -z "${wordpress_is_multisite}" ]]
then
  mv /app/nginx-site-multisite.conf /app/nginx-site.conf
  echo "Using Wordpress multisite alternate nginx config."
fi
