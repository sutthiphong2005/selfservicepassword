FROM centos:latest
RUN  yum update -y && \
     yum install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm -y && \
     yum install httpd -y && \
     yum install mod_ssl -y && \
     yum --enablerepo=remi-php72 install php -y && \
     yum --enablerepo=remi-php72 install php-mbstring -y && \
     yum --enablerepo=remi-php72 install php-ldap -y 

RUN  sed -i -- 's/Options Indexes FollowSymLinks/Options FollowSymLinks/g' /etc/httpd/conf/httpd.conf

COPY . /var/www/html/

COPY selfsignedkey/localhost.crt /etc/pki/tls/certs/
COPY selfsignedkey/localhost.key /etc/pki/tls/private/

RUN rm -rf /var/www/html/selfsignedkey

EXPOSE 443 
CMD apachectl -D FOREGROUND
