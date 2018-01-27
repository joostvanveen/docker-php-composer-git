FROM debian:jessie
MAINTAINER Woraphot Chokratanasombat <guhungry@gmail.com>

# Install Git, PHP, xdebug
RUN apt-get update && apt-get install -y openssl lsb-release apt-transport-https ca-certificates cron curl

# Install sury Repository
RUN curl -o sury.gpg https://packages.sury.org/php/apt.gpg && \
    apt-key add sury.gpg && \
    rm sury.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" >> /etc/apt/sources.list

# Install Git, PHP, xdebug
RUN apt-get update && apt-get install -y git php7.1-cli php7.1-curl php7.1-dom php7.1-fpm php7.1-intl php7.1-mbstring php7.1-mcrypt php7.1-memcached php7.1-mysqlnd php7.1-pgsql php7.1-xdebug php7.1-zip && \
    apt-get clean && apt-get autoremove && \
    rm -rf /usr/share/locale/* && \
    rm -rf /var/cache/debconf && mkdir -p /var/cache/debconf && \
    rm -rf /var/lib/apt/lists/* && mkdir -p /var/lib/apt/lists/partial

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer
