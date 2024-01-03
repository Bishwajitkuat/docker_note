# Drupal app with mariadb database.

- cd into the root directory of the app ...../drupal_db_app
- create a drupal app named `drupal` locally

  ```shell
  composer create-project drupal/recommended-project drupal
  ```

- creating container from docker compose file
  ```shell
  docker compose up -d
  ```
- you will able to install drupal site by going to `localhost` in your browser when all the containers are up and running.
