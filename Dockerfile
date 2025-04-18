FROM registry.access.redhat.com/ubi8/nodejs-18

WORKDIR /app

USER root

# Copy backend files
COPY backend/package.json backend/server.js /app/backend/
COPY backend/todos.db /app/backend/

# Copy frontend files
COPY frontend /app/frontend

# Set correct permissions
RUN mkdir -p /app/node_modules && chown -R 1001:0 /app

USER 1001

WORKDIR /app/backend

RUN npm install

EXPOSE 3333

CMD ["node", "server.js"]
