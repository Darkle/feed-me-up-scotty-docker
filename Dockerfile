# https://github.com/philiplehmann/container/blob/main/apps/puppeteer/Dockerfile

FROM oven/bun:1.3.5-slim

ENV NODE_ENV=production
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV DBUS_SESSION_BUS_ADDRESS=autolaunch:
ENV LANG=en_US.UTF-8


RUN apt-get update && \
    apt-get install --no-install-recommends --yes \
                    libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libgbm1 libasound2 \
                    libpangocairo-1.0-0 libxss1 libgtk-3-0 libgtk2.0-0 libdrm2 libxkbcommon0 \
                    wget gnupg \
                    dbus dbus-x11 \
                    fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-freefont-ttf \
                    chromium curl && \
    rm -rf /var/lib/apt/lists/*


WORKDIR /app

RUN mkdir /app/chromium-data && \
    chown -R 1000:1000 /app/chromium-data

# COPY --chown=1000:1000 dist/apps/puppeteer puppeteer

RUN echo '{"dependencies": {"feed-me-up-scotty": "1.10.0", "serve": "14.2.5"}}' > ./package.json

RUN bun install --production 

USER root

EXPOSE 8111

# `watch` needs a terminal
ENV TERM=xterm

# If you need to debug interactively, swap the CMD below with
# CMD ["tail", "-f", "/dev/null"]
# Then after building and running the container, run: `podman exec feed-me-up-scotty -it bash`

# `watch` runs a command every n seconds.
# 3600 is one hour in seconds
# -e is to exit watch if the command exits with a non-0 exit code
# Using `&` to have them run in parallel
CMD bunx serve -p 8111 & watch -n 3600 -e bunx feed-me-up-scotty
# CMD bunx serve -p 8111 & watch -n 3600 -e bunx feed-me-up-scotty && curl -fsS --retry 5 -o /dev/null $HEALTHCHECK_IO_URL
