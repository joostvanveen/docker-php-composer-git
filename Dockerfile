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

# Get available PHP 8.2 packages
RUN \
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -  && \
echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/php.list

# Install PHP
RUN \
apt-get update -y && \
apt-get install -y \
php8.2 \
php8.2-cli \
php8.2-gd \
php8.2-curl \
php8.2-dom \
php8.2-fpm \
php8.2-intl \
php8.2-mbstring \
php8.2-memcached \
php8.2-mysqlnd \
php8.2-sqlite3 \
php8.2-pgsql \
php8.2-bcmath \
php8.2-zip

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer
