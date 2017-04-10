FROM debian:jessie-slim
MAINTAINER sysadmin@kronostechnologies.com

ENV DEBIAN_FRONTEND=noninteractive

# Install z-push debian repository
ADD http://repo.z-hub.io/z-push:/final/Debian_8.0/Release.key /tmp/z-push-release-key
RUN apt-key add /tmp/z-push-release-key && \
    rm /tmp/z-push-release-key && \
    echo "deb http://repo.z-hub.io/z-push:/final/Debian_8.0/ /" >> /etc/apt/sources.list && \
    sed -i "s/jessie main/jessie main contrib non-free/" /etc/apt/sources.list

# Install z-push dependency
RUN apt-get update && apt-get install -y --no-install-recommends \
apache2 \
ca-certificates \
libapache2-mod-fastcgi \
php5-fpm \
php5-curl \
z-push-common \
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Prepare OS
RUN a2dissite 000-default && \
    a2enmod fastcgi actions rewrite

COPY ./start.d/ /k/start.d/
COPY ./stop.d/ /k/stop.d/
COPY ./conf.d/php5.conf /etc/php5/fpm/pool.d/php5-fpm.conf
COPY ./conf.d/apache2.conf /etc/apache2/apache2.conf

EXPOSE 80

ADD https://github.com/kronostechnologies/docker-init-entrypoint/releases/download/1.2.0/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
