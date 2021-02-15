
# Base
FROM node:alpine AS base
ENV HOME=/home/node
WORKDIR $HOME/app
COPY package*.json ./
RUN chown -R node:node $HOME/*
USER node

# Dependencies
FROM base AS dependencies
RUN npm set progress=false && npm config set depth 0
RUN npm install --only=production

# Release
FROM dependencies as release
COPY index.js ./

EXPOSE 3000

CMD ["node", "index.js"]
