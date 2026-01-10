FROM ghcr.io/puppeteer/puppeteer:16.1.0
# From https://pptr.dev/guides/docker

# Set working directory
WORKDIR /app

RUN echo '{"dependencies": {"feed-me-up-scotty": "^1.10.0"}}' > ./package.json

# Install npm packages including Puppeteer
RUN npm ci --only=production

# Expose port (adjust as needed)
EXPOSE 8111

# Start command (adjust based on your application)
# 3600 is one hour in seconds
CMD ["watch", "-n", "3600", "npx", "feed-me-up-scotty"]
