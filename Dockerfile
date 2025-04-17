# Base image
FROM node:18

# Set working directory inside container
WORKDIR /app

# Copy backend files
COPY backend/package.json backend/server.js /app/

# Install backend dependencies
RUN npm install

# Copy frontend files
COPY frontend /app/frontend

# Copy DB if needed (optional if you want a prefilled DB)
# COPY backend/todos.db /app/todos.db

# Expose the backend port
EXPOSE 3333

# Create db directory and make it writable
RUN mkdir -p db && chmod 777 db

# Start the Node.js server
CMD ["npm", "start"]
