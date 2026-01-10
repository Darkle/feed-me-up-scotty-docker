FROM ghcr.io/puppeteer/puppeteer:24.34.0
# From https://pptr.dev/guides/docker

# For some reason we are missing the libx11-xcb1 library, so change back to root to install missing lib. 
# Also need user to be root to fix issue with writing to public folder.
USER root

RUN apt-get install -y libx11-xcb1

# Set working directory
WORKDIR /app

RUN echo '{"dependencies": {"feed-me-up-scotty": "1.10.0", "serve": "14.2.5"}}' > ./package.json

# Install npm packages including Puppeteer
RUN npm i

EXPOSE 8111

# If you need to debug interactively, swap the CMD below with
# CMD ["tail", "-f", "/dev/null"]
# Then after building and running the container, run: `podman exec feed-me-up-scotty -it bash`

# Start command (adjust based on your application)
# 3600 is one hour in seconds
# -e is to exit watch if the command exits with a non-0 exit code
# Using `&` to have them run in parallel
CMD watch -n 3600 -e npx feed-me-up-scotty & npx serve -p 8111
