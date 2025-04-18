FROM registry.access.redhat.com/ubi8/nodejs-18

WORKDIR /app

# Use root to set permissions
USER root

# Copy backend and frontend files
COPY backend/package.json backend/server.js /app/backend/
COPY frontend /app/backend/frontend/

# Change ownership of app directory (not individual files like todos.db)
RUN chown -R 1001:0 /app

# Switch to non-root OpenShift-compatible user
USER 1001

WORKDIR /app/backend

# Install dependencies
RUN npm install

EXPOSE 3333

CMD ["node", "server.js"]
