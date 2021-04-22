From debian:buster
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server
RUN apt -y install php7.3 php-fpm php-mysql php-xml 

RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.gz
RUN tar -xf phpMyAdmin-latest-english.tar.gz  &&  rm -rf phpMyAdmin-latest-english.tar.gz
RUN mv phpMyAdmin-5.1.0-english phpmyadmin

RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz

RUN openssl req -x509 -nodes -days 365 -subj "/C=RU/ST=Russia/L=Kazan/O=School21/OU=21School/CN=myssl" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

COPY ./srcs/config.inc.php phpmyadmin
COPY ./srcs/wp-config.php wordpress
COPY ./srcs/start.sh /tools/start.sh
COPY ./srcs/nginx.config /etc/nginx/sites-available/
COPY ./srcs/relay_autoindex.sh /tools/relay_autoindex.sh

RUN ln -s /etc/nginx/sites-available/nginx.config /etc/nginx/sites-enabled/nginx.config
RUN unlink /etc/nginx/sites-enabled/default
RUN ln -s /phpmyadmin /var/www/html/phpmyadmin
RUN ln -s /wordpress /var/www/html/wordpress
RUN		chmod +x /tools/start.sh
RUN		chmod +x /tools/relay_autoindex.sh
WORKDIR /tools

CMD bash start.sh