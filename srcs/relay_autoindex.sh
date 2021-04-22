#!/bin/bash

  if [[ $# == 1 ]];  then
    if [[ $1 == "off" ]];  then
      sed -i "18 s/autoindex on;/autoindex off;/" /etc/nginx/sites-available/nginx.config
      echo "autoindex is off..."
    fi
    if [[ $1 == "on" ]];  then
      sed -i "18 s/autoindex off;/autoindex on;/" /etc/nginx/sites-available/nginx.config
      echo "autoindex is on..."
    fi
  fi
service nginx restart