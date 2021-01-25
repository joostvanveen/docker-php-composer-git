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

# Get available PHP 8.0 packages
RUN \
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -  && \
echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/php.list

# Install PHP
RUN \
apt-get update -y && \
apt-get install -y \
php8.0 \
php8.0-cli \
php8.0-gd \
php8.0-curl \
php8.0-dom \
php8.0-fpm \
php8.0-intl \
php8.0-mbstring \
php8.0-memcached \
php8.0-mysqlnd \
php8.0-sqlite3 \
php8.0-pgsql \
php8.0-bcmath \
php8.0-zip

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer
