FROM debian:jessie
MAINTAINER Joost van Veen <joost@accentinteractive.nl>

# Install Git, PHP, xdebug
RUN apt-get update && apt-get install -y openssl ca-certificates curl wget git

# Install dotdeb Repository
RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
    echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
    wget -O- http://www.dotdeb.org/dotdeb.gpg | apt-key add -

# Install Git, PHP, xdebug
RUN \
apt-get update && \
apt-get install -y \
php7.1 \
php7.1-cli \
php7.1-gd \
php7.1-curl \
php7.1-dom \
php7.1-fpm \
php7.1-intl \
php7.1-mbstring \
php7.1-mcrypt \
php7.1-memcached \
php7.1-mysqlnd \
php7.1-sqlite3 \
php7.1-pgsql \
php7.1-xdebug \
php7.1-zip

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer
