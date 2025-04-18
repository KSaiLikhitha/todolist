FROM registry.access.redhat.com/ubi8/nodejs-18

WORKDIR /app

USER root

# Copy backend and frontend
COPY backend /app/backend
COPY frontend /app/backend/frontend

# Create the data directory and set permissions
RUN mkdir -p /app/backend/data && \
    chown -R 1001:0 /app && \
    chmod -R ug+rwx /app

USER 1001

WORKDIR /app/backend

RUN npm install

EXPOSE 3333

CMD ["node", "server.js"]
