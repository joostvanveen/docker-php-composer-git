FROM debian:jessie
MAINTAINER Joost van Veen <joost@accentinteractive.nl>

# Install Linux packages
RUN \
apt-get update && \
apt-get install -y \
wget \
openssl \
apt-transport-https \
lsb-release \
ca-certificates \
curl \
git

# Get available PHP 7.2 packages
RUN \
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -  && \
echo "deb https://packages.sury.org/php/ jessie main" | tee /etc/apt/sources.list.d/php.list

# Install PHP
RUN \
apt-get update && \
apt-get install -y \
php7.2 \
php7.2-cli \
php7.2-gd \
php7.2-curl \
php7.2-dom \
php7.2-fpm \
php7.2-intl \
php7.2-mbstring \
php7.2-memcached \
php7.2-mysqlnd \
php7.2-sqlite3 \
php7.2-pgsql \
php7.2-zip

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer
