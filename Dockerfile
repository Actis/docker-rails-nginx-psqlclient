FROM ruby:2.2
MAINTAINER Gregory Nickonov, gregory@nickonov.ru

# Updating and installing packages
RUN apt-get update && apt-get install -qq -y \
		imagemagick \
		nodejs \
		postgresql-client \
		software-properties-common && rm -rf /var/lib/apt/lists/*

# Installing Nginx
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update && apt-get install -qq -y nginx && rm -rf /var/lib/apt/lists/*
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx

# Adding default nginx config
ADD nginx-site.conf /etc/nginx/sites-enabled/default

# Creating directory for application
RUN mkdir /app

