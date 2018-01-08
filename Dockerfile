FROM php:7.1-apache

# SMF Version
ENV version 2-0-15

# Copy Conifgurations
COPY php.ini ${PHP_INI_DIR}/php.ini
COPY site.conf /etc/apache2/sites-available/000-default.conf

# Configure PHP and Apache
RUN apt-get update -y && apt-get install -y libpng-dev curl libcurl4-openssl-dev
RUN docker-php-ext-install pdo pdo_mysql mysqli gd curl

RUN a2enmod rewrite
RUN service apache2 restart

# DOWNLOAD and Extract SMF
ADD https://download.simplemachines.org/index.php/smf_${version}_install.tar.gz ./smf.tar.gz
RUN tar xvzf smf.tar.gz
RUN rm smf.tar.gz
