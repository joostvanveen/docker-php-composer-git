# PHP (FPM) Laravel Base Image

![Docker Automated build](https://img.shields.io/docker/automated/joostvanveen/docker-php-composer-git.svg)
![Docker build status](https://img.shields.io/docker/build/joostvanveen/docker-php-composer-git.svg)

Forked from guhungry/docker-php-composer-git. 

Base docker image for Laravel applications. Extended from Debian Jessie (PHP5.6 - 7.2) and Debian Buster (PHP 7.3 and up) and built to be
reasonably small by removing unnecessary system files. See the versioning below.

This Docker image is only 155MB, making it prefect for running unit tests in a CI-CD setup. Because of its small size it load fast and does not fill up your runner server that quickly.

It contains all the necessary extensions to run unit tests for Laravel applications.

**Why not PHP (alpine) base image?**
The PHP image on Docker hub is substantially larger and doesn't include extensions commonly needed by Laravel, which means you'll have to add them making the image even larger. The alpine image provided is an alternative, however at this time you can't install xdebug on Alpine linux and certain applications may run into issues with the alternative libraries it uses.

The goal with this image is to provide sensible defaults and extensions while keeping image size as small as possible.

**Versioning**
`latest` tag currently runs 7.2

All avaliable PHP versions have their own branch in this repository:
- 5.6 ![Build passing](https://img.shields.io/badge/build-passing-green.svg)
- 7.0 ![Build passing](https://img.shields.io/badge/build-passing-green.svg)
- 7.1 ![Build passing](https://img.shields.io/badge/build-passing-green.svg)
- 7.2 ![Build passing](https://img.shields.io/badge/build-passing-green.svg)
- 7.3 ![Build passing](https://img.shields.io/badge/build-passing-green.svg)
- 7.4 ![Build passing](https://img.shields.io/badge/build-passing-green.svg)
- 8.0 ![Build passing](https://img.shields.io/badge/build-passing-green.svg)

**Extensions**
`mcrypt` `pdo_mysql` `pdo_pgsql` `memcached` `xdebug` `intl` `composer` `git`

**Usage**
Extend this image in your `Dockerfile` and add your source code. The `php-fpm` process is set as the CMD default.

**Example usage in a Gitlab CI-CD setup (.gitlab-ci.yml)**
```yaml
# This examples contains only a test stage, used to run unit tests in CI

stages:
  - test

services:
  - mysql

test:
  image: joostvanveen/docker-php-composer-git:7.3
  stage: test
  only:
    - master
    - dev
  services:
    - mysql:5.6
  before_script:
    # Kills the process if its not in a docker
    - '[[ ! -e /.dockerenv ]] && exit 0'
  script:
    - cp .env.testing .env
    - mkdir -p storage/framework/{sessions,views,cache}
    - COMPOSER_CACHE_DIR=$HOME/.composer/cache composer install --prefer-dist --optimize-autoloader --no-suggest --no-interaction
    - php vendor/bin/phpunit tests --colors
  tags:
    - docker
```
