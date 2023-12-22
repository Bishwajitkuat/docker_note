## Image

A Docker container image is a lightweight, standalone, executable package of software that includes everything needed to run an application: code, runtime, system tools, system libraries and settings.

## Container

A running instance of a `Image`.

## Common commands

#### Docker command structure

`docker Command/Management_Command sub_command options`

#### Versions & info

```shell
docker version
```

- Returns info about server and client

```shell
docker info
```

- Returns detail info

#### Creating a container

```shell
docker container run --publish 8080:80 --detach --name webhost nginx
```

- docker container run : will create a container instance
- --publish : right side port (80) is the internal port of from nginx, which will be exposed to outside of the container by left side port (8080)
- --detach : allows the container to run in background
- --name : allows to assign a name (webhost) to the container, name has to be unique.
- nginx : image name in dockerHub

#### Starting a container

```shell
docker start container_name
```

#### Container list

```shell
docker container ls
```

- return the list of running containers

```shell
docker container ls -a
```

- return the list of all containers, running and stopped

#### List of images

```shell
docker image ls
```

#### Stopping Containers

```shell
 docker container stop container_ID
```

- stop the container, we can pass multiple container ids by haveing single space between ids.

#### Logs of a container

```shell
docker container logs container_name
```

- returns logs for the container

#### Stopping container

```shell
docker container top container_name
```

- returns all the processes inside the container.

#### Removing or Deleting Containers

```shell
docker container rm container_names/container_IDs
```

- Removes the stop contianer(s), we can pass multiple names or ids with spaces between.

```shell
dokcer container rm -f container_names
```

- -f: this force flage will remove the container even if it was running.

#### Examplse

##### mysql container

```shell
docker container run --publish 3306:3306 --detach --name db --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql
```

randomly generated passwod can be found form logs

```shell
docker container logs db
```

##### apache server

```shell
docker container run --publish 8080:80 --detach --name webserver httpd
```

##### nginx

```shell
docker container run --publish 80:80 --detach --name proxyserver nginx
```

#### Inspecting config data of a container

```shell
docker container inspect container_name
```

- returns config info as json array

#### See container stat

```shell
docker container stats container_name
```

#### Getting a shell inside containers

```shell
docker container run -p 80:80 --name proxyserver -it nginx bash
```

- -it : allow to interact with container system
- bash : it always goes after the image name and it's indicate the prompt

The `exit` command is used to get out from container prompt. After exiting from the container, the container will be stopped because we are modifed the command promt. In order to get back into the container prompt and start the container, the following command is used.

```shell
docker container start -ai container_name
```

- -ai : this flag will take back to containers command prompt

Creating a mariadb container

```shell
docker run -d -p 3306:3306 --name db -e MARIADB_ROOT_PASSWORD=pass mariadb
```

Inoder to access into a running container we can use the follwing command

```shell
docker container exec -it db bash
```

```shell
ps aux
```

- returns all the running process in the container

```shell
mariadb -u root -p
```

- to enter into mariadb command prompt
