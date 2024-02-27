# Start from a slim version of the official Node Docker image
FROM node:lts-bookworm-slim

# Update system dependencies and install basic tools in a single step to reduce layer size
# Remove the /var/lib/apt/lists/* directory after installing packages to reduce the image size by cleaning up cached package data.
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    ffmpeg \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install zx globally using the --unsafe-perm flag to avoid permission issues
RUN npm install -g --unsafe-perm zx

# Create a directory for your application code
WORKDIR /app

# Copy the zx script into the container
COPY ./BBDown_1.6.1_linux-x64.zip /app/BBDown.zip
COPY ./batchAudio.mjs /app/batchAudio.mjs

RUN unzip -o BBDown.zip && chmod +x BBDown && rm BBDown.zip && rm -rf download

# Make the script executable
RUN chmod +x /app/batchAudio.mjs

CMD ["zx", "/app/batchAudio.mjs"]

