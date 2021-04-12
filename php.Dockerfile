FROM php:7.2-apache

# INSTALL PHP EXTENSIONS
RUN docker-php-ext-install pdo_mysql mysqli && docker-php-ext-enable mysqli
RUN apt-get update -y

# Install Imagick.
RUN apt-get update && apt-get install -y \
    imagemagick libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    && docker-php-ext-enable imagick

RUN sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read|write" pattern="PDF" \/>/g' /etc/ImageMagick-6/policy.xml



# ANABLE APACHE MOD REWRITE
RUN a2enmod rewrite

# ANABLE APACHE MOD HEADER
RUN a2enmod rewrite
RUN a2enmod expires
RUN a2enmod headers


# UPDATE APT-GET AND INSTALL LIBS
RUN apt-get update -y
RUN apt-get install -y openssl zip unzip git libnss3 libpng-dev

# INSTALL COMPOSER
RUN apt-get install -y openssl zip unzip git libnss3
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Change www-data user to match the host system UID and GID and chown www directory
RUN usermod --non-unique --uid 1000 www-data \
  && groupmod --non-unique --gid 1000 www-data \
  && chown -R www-data:www-data /var/www

# Defines that the image will have port 80 to expose
EXPOSE 80

WORKDIR /var/www/html
