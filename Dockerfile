FROM ubuntu:16.04
LABEL MAINTAILNER='SURESH' \
      Location='Bangalore' \
      Version='0.0.0'
RUN apt-get update -y
RUN apt-get install apache2 -y
RUN apt-get install git -y
WORKDIR /tmp
RUN git clone https://github.com/sureshbabu-alg/static_website.git
RUN mv static/* /var/www/html/
EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]
