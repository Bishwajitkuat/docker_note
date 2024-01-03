# Swarm Stacks and Production Greade Compose

- In 1.13 Docker adds a new layer of abstraction to Swarm called Stacks
- Stacks accept Compose files as their declarative definition for services, networks and volumes.
- We use docker stack deploy rather then docker service create.
- Stacks manages all those objects for us, including overlay network per stack. Adds stack name to start of their name.
- New `deploy` key in Compose file. But it can't do build
- Compose now ignores `deploy`, Swarm ignores `build`

## Swarm stack example

- file_name: `drupal_app_stack.yml`

```yml
version: "3.9"

services:
  drupal:
    image: drupal
    ports:
      - "80:80"
    volumes:
      - drupal-sites:/var/www/html/sites
    depends_on:
      - drupaldb
    networks:
      - drupal_network
    deploy:
      replicas: 3

  drupaldb:
    image: mariadb
    environment:
      MARIADB_ROOT_PASSWORD: pass
      MARIADB_USER: bisso
      MARIADB_PASSWORD: pass
      MARIADB_DATABASE: drupalDB
    volumes:
      - db-data:/var/lib/mysql
    networks:
      - drupal_network
    deploy:
      replicas: 1

volumes:
  db-data:
  drupal-sites:
networks:
  drupal_network:
```

### deploy a stack

```shell
docker stack deploy -c drupal_app_stack.yml drupal_app
```

### list task in a stack

```shell
docker stack ps drupal_app
```

- return list of task/container in the `drupal_app` stack

### list all services

```shell
docker stack services drupal_app
```

- return list of services benong to drupal_app stack

### removing stack

```shell
docker stack rm drupal_app
```

### removing all unused images, volumes and networks

```shell
docker system prune -a
```

## Secrets Storeage for Swarm

- As of Docker 1.13.0 Swarm Raft DB is encrypted on disk
- Only stored on disk on Manager nodes
- Default is Managers and Worker control plane is TLS + Mutual Auth
- Secrets are first stored in Swarm, then assigned to Service(s)
- Only container in assigned Service(s) can see them
- They look like files in container but are actually in-memory fs
- /run/secrets/secret_anme : like key value pair , file name is key and value is the content
- Local docker-compose can use file-based secrets, but not secure

### Creating a secret file

```shell
echo "bisso" | docker secret create mariadb_user -
```

```shell
echo "pass" | docker secret create mariadb_user_password -
```

```shell
echo "root_pass" | docker secret create mariadb_root_password -
```

### list all secrets

```shell
docker secret ls
```

### inspect secret

```shell
docker secret inspect  mariadb_user
```

- it will return detail info other than actual value

### consume secret

- in console when a service is being created.

```shell
docker service create --name mariadb --secret mariadb_root_password -e MARIADB_ROOT_PASSWORD_FILE=/run/secrets/mariadb_root_password mariadb
```

- in stack file with secret files in project roots

```yml
version: "3.9"
services:
  mariadb:
    image: mariadb
    secrets:
      - mariadb_root_password
      - mariadb_user
      - mariadb_user_password
    environment:
      MARIADB_ROOT_PASSWORD_FILE: /run/secrets/mariadb_root_password
      MARIADB_USER_FILE: /run/secrets/mariadb_user
      MARIADB_PASSWORD_FILE: /run/secrets/mariadb_user_password
      MARIADB_DATABASE: drupalDB

secrets:
  mariadb_root_password:
    # when docker secret file is not being created and need to be created based on value of txt file
    file: ./mariadb_root_password.txt
  mariadb_user:
    file: ./mariadb_user.txt
  mariadb_user_password:
    file: ./mariadb_user_password.txt
```

- in stack file when docker secret already being created

```yml
version: "3.9"
services:
  mariadb:
    image: mariadb
    secrets:
      - mariadb_root_password
      - mariadb_user
      - mariadb_user_password
    environment:
      MARIADB_ROOT_PASSWORD_FILE: /run/secrets/mariadb_root_password
      MARIADB_USER_FILE: /run/secrets/mariadb_user
      MARIADB_PASSWORD_FILE: /run/secrets/mariadb_user_password
      MARIADB_DATABASE: drupalDB

# docker secrests already being created before hand, in that case we have to use external: true
secrets:
  mariadb_root_password:
    external: true
  mariadb_user:
    external: true
  mariadb_user_password:
    external: true
```
