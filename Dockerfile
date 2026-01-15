FROM oven/bun:1.3.5-slim

ENV NODE_ENV=production

RUN apt-get update && apt-get install -y locales ca-certificates curl

RUN export LC_ALL=en_US.UTF-8
RUN export LANG=en_US.UTF-8
RUN locale-gen en_US.UTF-8

WORKDIR /app

RUN echo '{"dependencies": {"feed-me-up-scotty": "1.10.0", "serve": "14.2.5"}}' > ./package.json

RUN bun install --production 

EXPOSE 8111

# If you need to debug interactively, swap the CMD below with
# CMD ["tail", "-f", "/dev/null"]
# Then after building and running the container, run: `podman exec feed-me-up-scotty -it bash`

# 3600 is one hour in seconds
# Using `&` to have them run in parallel
CMD bunx serve -p 8111 & \
    while true; do \
        # Only run curl if `bunx feed-me-up-scotty` succeded && `HEALTHCHECK_IO_URL` env var set
        if bunx feed-me-up-scotty; then \
            echo "feed-me-up-scotty completed build on $(date)"; \
            if [ -n "$HEALTHCHECK_IO_URL" ]; then \
                curl -fsS --retry 5 -o /dev/null "$HEALTHCHECK_IO_URL"; \
            fi; \
        fi; \
        sleep 3600; \
    done