```shell
docker image build -t nginx-with-html .
```

- `image build` : build command to build an image
- `-t nginx-with-html` : adding tage to image
- `.` : path to the `Dockerfile`

```shell
docker system prune
```

- removes all the unused containers

```shell
docker image prune -a
```

- removes all the unused images
