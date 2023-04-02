#
# Builder
#
FROM node as builder

WORKDIR /app

COPY ./server/package.json ./server/yarn.lock ./server/tsconfig.json ./

RUN yarn install --frozen-lockfile

COPY ./server .

RUN yarn build

#
# Runner
#
FROM node:slim

WORKDIR /app

COPY ./server/package.json ./server/yarn.lock ./server/tsconfig.json ./

COPY --from=builder /app/build /app/build

RUN yarn install --production --frozen-lockfile

CMD [ "node", "build/index.js" ]
