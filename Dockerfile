# Stage 1: Build the React app
FROM node:current-alpine3.22 AS builder

# Set working directory
WORKDIR /src

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the build using Nginx
FROM nginx:alpine

# Copy the built files from previous stage
COPY --from=builder /src/dist /usr/share/nginx/html

# Copy custom Nginx configuration if needed (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
