# Step 1: Use the official Node.js image to build the app
FROM node:19 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json (if exists)
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the entire React app into the container
COPY . .

# Build the React app for production
RUN npm run build

# Step 2: Serve the React app using Nginx
FROM nginx:alpine

# Copy the build folder from the previous stage into the nginx container
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start the Nginx server (default command for nginx:alpine)
CMD ["nginx", "-g", "daemon off;"]
