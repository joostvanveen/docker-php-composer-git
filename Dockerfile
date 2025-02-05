FROM debian:bookworm-slim
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

# Get available PHP 8.4 packages
RUN \
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -  && \
echo "deb https://packages.sury.org/php/ bookworm main" | tee /etc/apt/sources.list.d/php.list

# Install PHP
RUN \
apt-get update -y && \
apt-get install -y \
php8.4 \
php8.4-cli \
php8.4-gd \
php8.4-curl \
php8.4-dom \
php8.4-fpm \
php8.4-intl \
php8.4-mbstring \
php8.4-memcached \
php8.4-mysqlnd \
php8.4-sqlite3 \
php8.4-pgsql \
php8.4-bcmath \
php8.4-zip

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer
