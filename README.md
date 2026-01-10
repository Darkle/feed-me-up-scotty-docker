- This is a dockerised version of [feed-me-up-scotty](https://feed-me-up-scotty.vincenttunru.com)
- It also runs a static server to serve up the feeds. Default port is `8111`

- Run with:

  - `docker build -t feed-me-up-scotty .`

  - ```sh
    docker run --restart always -d \
      -p 8111:8111 \
      --name feed-me-up-scotty \
      -v /path/to/feeds.toml:/app/feeds.toml \
      -v /path/to/public:/app/public \
      feed-me-up-scotty
    ```

- or with podman:
  - `podman build -t feed-me-up-scotty .`
  - ```sh
    podman run --restart always -d \
      -p 8111:8111 \
      --name feed-me-up-scotty \
      -v /path/to/feeds.toml:/app/feeds.toml \
      -v /path/to/public:/app/public \
      feed-me-up-scotty
    ```
