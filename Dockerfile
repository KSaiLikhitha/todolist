FROM registry.access.redhat.com/ubi8/nodejs-18

WORKDIR /app

# Use root to set permissions
USER root

# Copy backend files
COPY backend/package.json backend/server.js backend/todos.db /app/backend/

# Copy frontend files into backend/frontend
COPY frontend /app/backend/frontend/

# Set correct permissions
RUN mkdir -p /app/backend/node_modules && chown -R 1001:0 /app

# Switch to non-root OpenShift-compatible user
USER 1001

WORKDIR /app/backend

# Install dependencies
RUN npm install

EXPOSE 3333

CMD ["node", "server.js"]
