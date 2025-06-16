# multistage-nodeapp
Multi-stage Docker build for a Node.js application. Lightweight, production-ready Node.js container using Docker multi-stage builds.

# multistage-nodeapp

A lightweight, production-ready Node.js application containerized using Docker multi-stage builds. This setup ensures smaller image sizes and faster deployments while keeping development dependencies out of production.

## 🛠 Tech Stack

- Node.js
- Docker (Multi-Stage Build)
- Docker Hub (for image distribution)
- AWS EC2 (optional deployment target)

---

## 🚀 Quick Start Guide

### Prerequisites

- Node.js installed (for local dev)
- Docker installed
- Docker Hub account
- (Optional) EC2 instance for deployment

---

### 📝 Dockerfile (Multi-stage)

Below is the multi-stage Dockerfile used for this project:

![Screenshot (59)](https://github.com/user-attachments/assets/23266a9d-3f58-4f92-a794-130c07e28075)
![Screenshot (58)](https://github.com/user-attachments/assets/01b4f97a-4aab-4cad-9044-cdbba4b7cda0)


```Dockerfile
# Stage 1: Build stage
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# Stage 2: Production stage
FROM node:18-alpine AS production

WORKDIR /app

# Copy only production dependencies
COPY package*.json ./
RUN npm install --production

# Copy built app from builder stage
COPY --from=builder /app .

EXPOSE 3000

CMD ["npm", "start"]

# Clone the repository (if not already)
git clone https://github.com/yourusername/multistage-nodeapp.git
cd multistage-nodeapp

# Build Docker Image
docker build -t your-dockerhub-username/multistage-nodeapp:latest .

# Test locally
docker run -p 3000:3000 your-dockerhub-username/multistage-nodeapp:latest

# Log in to Docker Hub
docker login

# Push to Docker Hub
docker push your-dockerhub-username/multistage-nodeapp:latest

ssh ec2-user@your-ec2-public-ip

# Install Docker if not already installed (on Amazon Linux 2 for example)
sudo yum update -y
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user
exit

# Log back into EC2 after adding Docker permissions
ssh ec2-user@your-ec2-public-ip

# Pull and run the image
docker pull your-dockerhub-username/multistage-nodeapp:latest
docker run -d -p 3000:3000 your-dockerhub-username/multistage-nodeapp:latest




