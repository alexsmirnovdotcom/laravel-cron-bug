FROM php:8.2-fpm

ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libzip-dev \
    libmagickwand-dev \
    mariadb-client \
    cron \
    supervisor

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pecl install imagick redis \
    && docker-php-ext-enable imagick redis

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl bcmath gd

COPY ./supervisor.conf /etc/supervisor/conf.d/supervisor.conf

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY ./laravel /var/www/laravel

RUN adduser $user

# Create system user to run Composer and Artisan Commands
RUN chown -R $user:$user /var/www/laravel

RUN usermod -aG www-data $user

RUN chmod -R g+rx /var/www/laravel/public

USER $user

# Set working directory
WORKDIR /var/www/laravel

RUN composer install

EXPOSE 9000
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisor.conf"]
