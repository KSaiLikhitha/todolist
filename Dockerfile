# Base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy backend files
COPY backend/package.json backend/server.js /app/

# Install dependencies
RUN npm install

# Copy frontend
COPY frontend /app/frontend

# Create db directory and make it writable
RUN mkdir -p /app/db && chmod 777 /app/db

# Copy the SQLite DB file into the correct place
COPY backend/todos.db /app/db/todos.db

# Expose backend port
EXPOSE 3333

# Start the server
CMD ["npm", "start"]
