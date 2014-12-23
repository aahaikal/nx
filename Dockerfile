# Dockerfile for installing and running Nginx

# Select ubuntu as the base image
FROM ubuntu

# Install nginx
RUN apt-get update
RUN apt-get install -y libssl-dev
RUN apt-get install -y nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN sed -i 's/user .*;/user root;/' /etc/nginx/nginx.conf
ADD .htpasswd /etc/nginx/.htpasswd
ADD nginx.conf /etc/nginx/sites-enabled/default

# SSL 
RUN mkdir /etc/nginx/ssl
WORKDIR /etc/nginx/ssl

ADD key.pem /etc/nginx/ssl/key.pem
ADD cert.pem /etc/nginx/ssl/cert.pem

EXPOSE 2375

CMD ["nginx"]
