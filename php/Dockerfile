FROM php:8.2-apache

# Aggiornamento e installazione delle dipendenze
RUN apt-get update \
    && apt-get install -y build-essential curl zlib1g-dev g++ git libicu-dev zip libzip-dev libpng-dev libjpeg-dev libwebp-dev libfreetype6-dev \
    && docker-php-ext-install intl opcache pdo pdo_mysql \
    && pecl install apcu \
    && docker-php-ext-enable apcu \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip

# Installazione di gd e exif
RUN docker-php-ext-configure gd --with-freetype --with-webp --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install exif

# Abilitazione dei moduli Apache
RUN a2enmod rewrite && a2enmod ssl && a2enmod socache_shmcb

# Impostazione della cartella di lavoro
WORKDIR /var/www

# Installazione di Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Installazione di Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash \
    && mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

# Configurazione di Git
RUN git config --global user.email "salisoumoussa1@gmail.com"
RUN git config --global user.name "salisou moussa"
