FROM registry.access.redhat.com/ubi8/nodejs-18

WORKDIR /todolist

# Use root to set permissions
USER root

# Create the necessary directories for backend and frontend
RUN mkdir -p /todolist/backend /todolist/frontend

# Copy backend files (adjusted paths for OpenShift)
COPY backend/package.json backend/server.js /todolist/backend/
COPY backend/todos.db /todolist/backend/todos.db

# Copy frontend files
COPY frontend /todolist/frontend

# Set correct permissions
RUN mkdir -p /todolist/node_modules && chown -R 1001:0 /todolist

# Switch to non-root OpenShift-compatible user
USER 1001

# Install dependencies
RUN npm install --prefix /todolist/backend

EXPOSE 3333

CMD ["node", "/todolist/backend/server.js"]
