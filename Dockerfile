# Use a lightweight Linux base image
FROM rust:latest

# Install dependencies for Foundry (you can adjust this as per the project's needs)
RUN apt-get update && apt-get install -y \
    libssl-dev \
    pkg-config \
    cmake \
    build-essential \
    curl \
    git

# Set the working directory in the container
WORKDIR /app

# Copy the project files into the container
COPY . .

# Install Foundry
RUN curl -L https://foundry.paradigm.xyz | bash
RUN ~/.foundry/bin/foundryup

# Set Foundry binaries in PATH
ENV PATH="/root/.foundry/bin:${PATH}"

# Build the project (optional, depending on your workflow)
RUN forge build

# Command to start the container (adjust as needed)
CMD ["bash"]