- This is a dockerised version of [feed-me-up-scotty](https://feed-me-up-scotty.vincenttunru.com)
- It also runs a static server to serve up the feeds (using [serve](https://github.com/vercel/serve)). Default port is `8111`

- If you would like to be notified if the container exits, you can comment out the current `CMD` in the `Dockerfile` and uncomment out the `CMD` below. Then run the `docker run` or `podman run` with the extra arg of `-e HEALTHCHECK_IO_URL=https://foo` with `https://foo` being the https://healthchecks.io check URL.

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
