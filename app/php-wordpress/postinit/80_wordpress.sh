#!/bin/bash
source /app/functions.sh

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

if [[ ! -z "${wordpress_is_multisite}" ]]
then
  mv /app/nginx-site-multisite.conf /app/nginx-site.conf
  echo "Using Wordpress multisite alternate nginx config."
else
  rm /app/nginx-site-multisite.conf
  echo "Removed unused multisite nginx config."
fi