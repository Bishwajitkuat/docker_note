FROM drupal:10-apache

RUN apt-get update && apt-get install -y git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html/themes

# bootstrap theam is different for drupal 10

RUN git clone --branch 3.0.x --single-branch --depth 1 https://git.drupalcode.org/project/bootstrap5.git \
  && chown -R www-data:www-data bootstrap5

# working directory is different for drupal 10

WORKDIR /opt/drupal