FROM registry.access.redhat.com/ubi8/nodejs-18

WORKDIR /app

# Ensure we have correct permissions
USER root
COPY backend/package.json backend/server.js /app/
RUN mkdir -p /app/node_modules && chown -R 1001:0 /app

# Set back to default UBI user (non-root user 1001)
USER 1001

RUN npm install

COPY backend /app

EXPOSE 9999
CMD ["node", "server.js"]
