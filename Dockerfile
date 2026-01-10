FROM ghcr.io/puppeteer/puppeteer:24.34.0
# From https://pptr.dev/guides/docker

# For some reason we are missing the libx11-xcb1 library, so change back to root to install missing lib. 
# Also need user to be root to fix issue with writing to public folder.
USER root

RUN apt-get install -y libx11-xcb1

# Set working directory
WORKDIR /app

RUN echo '{"dependencies": {"feed-me-up-scotty": "^1.10.0"}}' > ./package.json

# Install npm packages including Puppeteer
RUN npm i

# Expose port (adjust as needed)
EXPOSE 8111

# Start command (adjust based on your application)
# 3600 is one hour in seconds
# CMD ["watch", "-n", "3600", "npx", "feed-me-up-scotty"]
# CMD ["/usr/bin/bash"]
CMD ["tail", "-f", "/dev/null"]
