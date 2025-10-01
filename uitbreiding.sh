#!/bin/bash
set -euo pipefail

cat > Dockerfile << _EOF_
FROM node:lts-alpine
RUN apk add --no-cache python3 g++ make

WORKDIR /app

# Copy only dependency files first (better cache + avoids polluting node_modules)
COPY package.json yarn.lock ./
RUN yarn install --production

# Then copy the rest of the source
COPY . .

EXPOSE 3000
CMD ["node", "app/src/index.js"]

_EOF_

docker build -t getting-started .
docker run -t -d -p 3000:3000 --name getting-started getting-started
docker ps -a 