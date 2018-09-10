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

# Get available PHP 7.1 packages
RUN \
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -  && \
echo "deb https://packages.sury.org/php/ jessie main" | tee /etc/apt/sources.list.d/php.list

# Install PHP
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
