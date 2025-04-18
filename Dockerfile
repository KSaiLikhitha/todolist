FROM registry.access.redhat.com/ubi8/nodejs-18

WORKDIR /app

# Use root to set permissions
USER root

# Copy backend code
COPY backend/package.json backend/server.js /app/backend/

# Copy frontend code
COPY frontend /app/backend/frontend/

# Set permissions
RUN chown -R 1001:0 /app

# Switch to non-root user for OpenShift
USER 1001

WORKDIR /app/backend

RUN npm install

EXPOSE 3333

CMD ["node", "server.js"]

