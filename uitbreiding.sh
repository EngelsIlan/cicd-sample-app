#!/bin/bash
set -euo pipefail

cat > Dockerfile << _EOF_
FROM node:lts-alpine
RUN apk add --no-cache python3 g++ make

WORKDIR /app

# Copy dependency files from app/
COPY app/package.json app/yarn.lock ./

# Install dependencies
RUN yarn install --production

# Copy the rest of the source code
COPY app/ . 

EXPOSE 3000
CMD ["node", "src/index.js"]

_EOF_

docker build -t getting-started .
docker run -t -d -p 3000:3000 --name getting-started getting-started
docker ps -a 