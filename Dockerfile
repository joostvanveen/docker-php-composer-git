FROM debian:bullseye-slim
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

# Get available PHP 8.3 packages
RUN \
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -  && \
echo "deb https://packages.sury.org/php/ bullseye main" | tee /etc/apt/sources.list.d/php.list

# Install PHP
RUN \
apt-get update -y && \
apt-get install -y \
php8.3 \
php8.3-cli \
php8.3-gd \
php8.3-curl \
php8.3-dom \
php8.3-fpm \
php8.3-intl \
php8.3-mbstring \
php8.3-memcached \
php8.3-mysqlnd \
php8.3-sqlite3 \
php8.3-pgsql \
php8.3-bcmath \
php8.3-zip

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer
