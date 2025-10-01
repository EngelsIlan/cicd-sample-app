#!/bin/bash
set -euo pipefail

mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

cp sample_app.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

cat > tempdir/Dockerfile << _EOF_
FROM node:lts-alpine
RUN apk add --no-cache python3 g++ make
WORKDIR /app
COPY . .
RUN yarn install --production
CMD ["node", "/app/src/index.js"]
_EOF_

cd tempdir || exit
docker build -t getting-started .
docker run -t -d -p 5151:5151 --name todoapp getting-started
docker ps -a
echo "App should be reachable at http://localhost:5151"