Run with:

```sh
docker build -t feed-me-up-scotty .

docker run --restart always -d \
  --name feed-me-up-scotty \
  -v /path/to/feeds.toml:/app/feeds.toml \
  -v /path/to/public:/app/public \
  feed-me-up-scotty
```

or with podman:

```sh
podman build -t feed-me-up-scotty .

podman run --restart always -d \
  --name feed-me-up-scotty \
  -v /path/to/feeds.toml:/app/feeds.toml \
  -v /path/to/public:/app/public \
  feed-me-up-scotty
```
