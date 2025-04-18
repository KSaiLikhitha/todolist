FROM registry.access.redhat.com/ubi8/nodejs-18

WORKDIR /app

# Use root to set permissions
USER root

# Copy backend files
COPY backend/package.json backend/server.js backend/todos.db /app/backend/

# Copy frontend files into backend/frontend
COPY frontend /app/backend/frontend/

# Set correct permissions for backend and database files
RUN chown -R 1001:0 /app/backend
RUN chmod 666 /app/backend/todos.db

# Switch to non-root OpenShift-compatible user
USER 1001

WORKDIR /app/backend

# Install dependencies
RUN npm install

EXPOSE 3333

CMD ["node", "server.js"]
