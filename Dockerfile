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

# Get available PHP 8.1 packages
RUN \
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -  && \
echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/php.list

# Install PHP
RUN \
apt-get update -y && \
apt-get install -y \
php8.1 \
php8.1-cli \
php8.1-gd \
php8.1-curl \
php8.1-dom \
php8.1-fpm \
php8.1-intl \
php8.1-mbstring \
php8.1-memcached \
php8.1-mysqlnd \
php8.1-sqlite3 \
php8.1-pgsql \
php8.1-bcmath \
php8.1-zip

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer
