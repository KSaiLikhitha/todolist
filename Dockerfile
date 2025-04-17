# Base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy backend code
COPY backend/package.json backend/server.js /app/

# Install backend dependencies
RUN npm install

# Copy frontend code
COPY frontend /app/frontend

# ✅ Copy the SQLite DB file to the expected location
COPY backend/todos.db /app/todos.db

# Expose the backend port
EXPOSE 3333

# Start the server
CMD ["npm", "start"]
