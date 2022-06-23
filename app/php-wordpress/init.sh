#!/bin/bash

if [ ! -d "/var/www/wp-content/" ]
then
  echo "Downloading latest Wordpress zip file...";
  cd /var/www;
  wget https://wordpress.org/latest.zip;
  unzip latest.zip
else
  echo "Found existing Wordpress installation."
fi