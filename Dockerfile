# Dockerfile (multi-stage build)
FROM node:18 as builder

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .

# Final smaller image
FROM node:18-slim

WORKDIR /app
COPY --from=builder /app .

EXPOSE 3000
CMD ["node", "index.js"]
