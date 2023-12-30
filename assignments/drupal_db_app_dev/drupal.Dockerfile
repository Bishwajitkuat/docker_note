FROM drupal:10-apache

WORKDIR /opt/drupal
COPY ./drupal/* .
COPY ./drupal/web/sites/default/settings.php  ./web/sites/default/settings.php
COPY ./drupal/web/sites/default/files  ./web/sites/default/files
RUN chown -R www-data:www-data ./web/sites/default/settings.php ./web/sites/default/files
RUN composer install
