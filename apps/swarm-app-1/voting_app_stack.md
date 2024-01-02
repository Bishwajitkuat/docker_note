- creating the networks first, as the services will be part of swarm I will use overlya driver.

```shell
docker network create --driver overlay frontend_network
docker network create --driver overlay backend_networks
```

- vote service

```shell
docker service create --name vote -p 80:80 --replicas 2 --network frontend_network bretfisher/examplevotingapp_vote
```

- redis service

```shell
docker service create --name redis --network frontend_network redis:3.2
```

- worker service

```shell
docker service create --name worker --network frontend_network --network backend_networks bretfisher/examplevotingapp_worker
```

- db service

```shell
docker service create --name db --mount type=volume,source=db-data,target=/var/lib/postgresql/data -e POSTGRES_HOST_AUTH_METHOD=trust --network backend_networks postgres:9.4
```

- result service

```shell
docker service create --name result -p 5001:80 --network backend_networks bretfisher/examplevotingapp_result
```

- hostIPAddress to vote
- hostIPAddress:5001 to see the votes
