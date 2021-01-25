FROM debian:buster
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
git \
gnupg2

# Get available PHP 7.4 packages
RUN \
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -  && \
echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/php.list

# Install PHP
RUN \
apt-get update -y && \
apt-get install -y \
php7.4 \
php7.4-cli \
php7.4-gd \
php7.4-curl \
php7.4-dom \
php7.4-fpm \
php7.4-intl \
php7.4-json \
php7.4-mbstring \
php7.4-memcached \
php7.4-mysqlnd \
php7.4-sqlite3 \
php7.4-pgsql \
php7.4-bcmath \
php7.4-zip

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer
