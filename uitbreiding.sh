#!/bin/bash
set -euo pipefail

cat > app/Dockerfile << _EOF_
FROM node:lts-alpine
RUN apk add --no-cache python3 g++ make
WORKDIR /app
COPY . .
RUN yarn install --production
EXPOSE 5050
CMD ["node", "/app/src/index.js"]
_EOF_

cd app || exit
docker build -t getting-started .
docker run -t -d -p 5050:5050 --name getting-started getting-started
docker ps -a 