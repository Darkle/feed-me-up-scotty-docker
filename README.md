Run with:
```sh
docker run --restart always -d \
  --name feed-me-up-scotty
  -v /path/to/feeds.toml:/feeds.toml \
  feed-me-up-scotty
```
or with podman:
```sh
podman run --restart always -d \
  --name feed-me-up-scotty
  -v /path/to/feeds.toml:/feeds.toml \
  feed-me-up-scotty
```  