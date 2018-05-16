FROM debian:jessie
MAINTAINER Woraphot Chokratanasombat <guhungry@gmail.com>

# Install Git, PHP, xdebug
RUN apt-get update && apt-get install -y openssl ca-certificates cron curl

# Install dotdeb Repository
RUN curl -o dotdeb.gpg https://www.dotdeb.org/dotdeb.gpg && \
    apt-key add dotdeb.gpg && \
    rm dotdeb.gpg && \
    echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list

# Install Git, PHP, xdebug
RUN apt-get update && apt-get install -y git php7.0-cli php7.0-curl php7.0-dom php7.0-fpm php7.0-intl php7.0-mbstring php7.0-mcrypt php7.0-memcached php7.0-mysqlnd php7.0-sqlite3 php7.0-pgsql php7.0-xdebug php7.0-zip && \
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
