FROM node:23-alpine

WORKDIR /app

COPY . .

RUN npm ci \
    npm run lint && \
    npm run test && \
    find . -type f -name "*.test.ts" -delete && \
    rm -rf ./jest.config.ts && \
    npm prune --production

EXPOSE $NEXTJS_PORT

CMD ["sh", "-c", "npm run build && \
    if [ \"$START\" = \"true\" ]; then \
       npm run start; \
    fi"]