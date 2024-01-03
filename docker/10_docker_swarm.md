# Swarm

Swarm mode is an advanced feature for managing a cluster of Docker daemons. Use Swarm mode if you intend to use Swarm as a production runtime environment.

## Creating 3 node Swarn Cluster

- created three droplet in digital ocean and used ssh to connect to droplets
- installed docker in all three of the nodes

## in node1:

```shell
docker warm init
```

- it will give erros saing to use `--advertise-addr` tag with public ip address

![swarm init](resources/imgs/service_advertise_addr.png)

- considering the error we run the following command

```shell
docker swarm init --advertise-addr 142.93.225.143
```

- it initialize the swarm in the current node
- it makes the current node as manager
- also gives command with token how to add worker to this swarm

![swarm init](resources/imgs/swarm_init.png)

## in node2:

```shell
docker swarm join --token SWMTKN-1-1fll5o62pj670w501mbo6qx6k5lvuz7c2255jrqx2wdzkx7tgr-9ajalzp9w1thlo7iaz5eouydl 142.93.225.143:2377
```

- node2 joined as worker in the swarm
  ![swarm join --token](resources/imgs/swarm_join_token.png)

### list all nodes in docker swarm

```shell
docker node ls
```

- return all the running container in the swarm
- all the node and swarm command can be executed only form manager node

![docker node ls](resources/imgs/docker_node_ls.png)

### changing role of node2 to manager

```shell
docker node update --role manager node2
```

- now node2 is manager and node1 is worker

### get join token for worker

```shell
docker swarm join-token worker
```

- return command and token to add another node to the swarm

![swarm join-token worker](resources/imgs/swarm_join_token.png)

### Creating a `nginx` service

```shell
docker service create --name nginx_server -p 8080:80 -d --replicas 3 nginx
```

![service create replicas](resources/imgs/service_create_replicas.png)

- now `http://167.71.74.208:8080/` will serve nginx home page

### `--driver overlay `

```shell
docker network create --driver overlay drupal_app_network
```

- Creates a swarm wide bridge network where different container in different host can connenct in a swarm.
- IPSec (AES) encryption can be enabled

## Creating drupal app

- creating a overlay networ through which cross host container/service can communicate.

```shell
docker network create --driver overlay drupal_app_network
```

### `creating mariadb service`

```shell
docker service create --name drupaldb --network drupal_app_network \
-e MARIADB_ROOT_PASSWORD=pass \
-e MARIADB_USER=bisso \
-e MARIADB_PASSWORD=pass \
-e MARIADB_DATABASE=drupalDB \
mariadb:latest
```

- checking service status

```shell
docker service ps drupaldb
```

- its running in node1
  ![service ps drupaldb](resources/imgs/service_ps_drupaldb.png)

### `Creating drupal service`

```shell
docker service create --name drupal --network drupal_app_network -p 80:80 drupal
```

- checking service status

```shell
docker service ps drupal
```

- it's running in node2
  ![service ps drupal](resources/imgs/service_ps_drupal.png)

- now drupal app is served in id address of any nodes in the swarm.

## Routing Mesh

Routes ingress (incoming) packets for a Service to proper task.
Takes care of load balanching.
This is stateless load blancing.
