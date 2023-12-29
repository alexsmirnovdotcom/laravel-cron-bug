# Use a PHP base image with PHP-FPM
FROM php:8.2-fpm-alpine

# Install required PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Copy crontab file to the container
COPY ./crontab /etc/crontabs/root

# Run the cron daemon in the foreground
CMD ["crond", "-f"]
