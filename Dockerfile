FROM rails:4.2
MAINTAINER Gregory Nickonov, gregory@nickonov.ru

# Updating and installing packages
RUN apt-get update && \
    apt-get install -y imagemagick software-properties-common --no-install-recommends && \
	rm -rf /var/lib/apt/lists/*

# Installing Nginx
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

ENV NGINX_VERSION 1.6.2-5

RUN apt-get update && \
    apt-get install -y ca-certificates nginx=${NGINX_VERSION} && \
	rm -rf /var/lib/apt/lists/*

#RUN add-apt-repository -y ppa:nginx/stable
#RUN apt-get update && \
#    apt-get install -y nginx --no-install-recommends && \
#    rm -rf /var/lib/apt/lists/*

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx

# Adding default nginx config
ADD nginx-site.conf /etc/nginx/sites-enabled/default

# Creating directory for application
RUN mkdir /app

