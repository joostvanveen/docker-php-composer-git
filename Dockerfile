FROM debian:jessie
MAINTAINER Woraphot Chokratanasombat <guhungry@gmail.com>

RUN apt-get update && apt-get install -y openssl ca-certificates cron git curl php5-fpm php5-curl php5-cli php5-mcrypt php5-mysqlnd php5-pgsql php5-memcached php5-intl php5-xdebug && \
    apt-get clean && apt-get autoremove && \
    rm -rf /usr/share/locale/* && \
    rm -rf /var/cache/debconf && mkdir -p /var/cache/debconf && \
    rm -rf /var/lib/apt/lists/* && mkdir -p /var/lib/apt/lists/partial && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer


ADD ./php-fpm.conf /etc/php5/fpm/php-fpm.conf

EXPOSE 9000

CMD ["php5-fpm"]
