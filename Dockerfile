# Use the official AlmaLinux 9 base image
FROM almalinux:9

# Install Nginx and PHP 8 with required extensions
RUN dnf install -y nginx php php-cli php-fpm php-mysqlnd php-pdo php-gd php-mbstring php-json php-xml php-opcache php-zip

# Remove the default Nginx configuration file
RUN rm -f /etc/nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Copy custom Nginx configuration file
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php-fpm.d/www.conf
COPY config/php.ini /etc/custom.ini
RUN cat /etc/custom.ini >> /etc/php.ini
RUN rm /etc/custom.ini

# Create directory for php-fpm
RUN mkdir -p /run/php-fpm/

# Setup document root
RUN mkdir -p /var/www/html

# Make sure files/folders needed by the processes are accessable when they run under the nobody user
RUN chown -R nobody.nobody /var/www/html && \
  chown -R nobody.nobody /run && \
  chown -R nobody.nobody /var/lib/nginx && \
  chown -R nobody.nobody /var/log/nginx && \
  chown -R nobody.nobody /var/log/php-fpm

# Switch to use a non-root user from here on
USER nobody

# Add application
WORKDIR /var/www/html
COPY --chown=nobody src/ /var/www/html/

# Expose the port nginx is reachable on
EXPOSE 8080

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure a healthcheck to validate that everything is up&running
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping
