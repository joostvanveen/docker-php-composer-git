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

# Get available PHP 7.3 packages
RUN \
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -  && \
echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/php.list

# Install PHP
RUN \
apt-get update -y && \
apt-get install -y \
php7.3 \
php7.3-cli \
php7.3-gd \
php7.3-curl \
php7.3-dom \
php7.3-fpm \
php7.3-intl \
php7.3-json \
php7.3-mbstring \
php7.3-memcached \
php7.3-mysqlnd \
php7.3-sqlite3 \
php7.3-pgsql \
php7.3-bcmath \
php7.3-zip

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer
