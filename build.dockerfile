# Use the official Red Hat UBI (Universal Base Image) 8
FROM registry.access.redhat.com/ubi8:latest

# Packer version you want to install
ARG PACKER_VERSION=1.8.4

# Update the package manager and install dependencies
# - curl, unzip, python3, pip, etc.
RUN microdnf update -y && \
    microdnf install -y curl unzip python3 python3-pip && \
    microdnf clean all

# Install AWS CLI using pip
RUN pip3 install --no-cache-dir --upgrade awscli

# Download and install Packer
RUN curl -sSLO "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip" && \
    unzip "packer_${PACKER_VERSION}_linux_amd64.zip" -d /usr/local/bin && \
    rm -f "packer_${PACKER_VERSION}_linux_amd64.zip"

# Make sure Packer and AWS CLI are in PATH
ENV PATH="/usr/local/bin:${PATH}"

# Set the default entrypoint/command (optional)
ENTRYPOINT ["/bin/bash"]