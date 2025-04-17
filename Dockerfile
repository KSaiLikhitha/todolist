FROM registry.access.redhat.com/ubi8/nodejs-18

WORKDIR /app

# Use root to set permissions
USER root

# Copy backend files
COPY backend/package.json backend/server.js backend/todos.db /app/

# Copy frontend files (important!)
COPY frontend /app/frontend

# Set correct permissions
RUN mkdir -p /app/node_modules && chown -R 1001:0 /app

RUN chmod 777 backend/todos.db  # Ensure the todos.db file is writable by OpenShift user


# Switch to non-root OpenShift-compatible user
USER 1001

# Install dependencies
RUN npm install

EXPOSE 3333

CMD ["node", "server.js"]
