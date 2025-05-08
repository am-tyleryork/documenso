###########################
#     BASE CONTAINER      #
###########################
FROM node:22-alpine3.20 AS base

RUN apk add --no-cache openssl

###########################
#    BUILDER CONTAINER    #
###########################
FROM base AS builder

# ✅ Add bash here
RUN apk add --no-cache libc6-compat jq bash

WORKDIR /app

COPY . .

RUN npm install -g turbo@1.9.3
RUN npm ci

ENV NODE_OPTIONS=--max-old-space-size=2048
RUN turbo run build --filter=@documenso/remix...

###########################
#     RUNNER CONTAINER    #
###########################
FROM base AS runner

ENV NODE_OPTIONS=--max-old-space-size=2048

RUN addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 nodejs && \
    mkdir -p /app && chown -R nodejs:nodejs /app

USER nodejs
WORKDIR /app

COPY --from=builder --chown=nodejs:nodejs /app .

RUN npm ci --only=production

RUN npx prisma generate --schema ./packages/prisma/schema.prisma

CMD ["node", "apps/remix/build/server/main.js"]