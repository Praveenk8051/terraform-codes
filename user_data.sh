#!/bin/bash
set -e

echo "=== EC2 Instance Initialization ==="
echo "Instance Name: ${instance_name}"
echo "Timestamp: $(date)"

# Update system packages
yum update -y

# Install common utilities
yum install -y \
    curl \
    wget \
    git \
    htop \
    net-tools \
    vim

# Install Docker (optional, comment out if not needed)
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

echo "=== EC2 Instance Initialization Complete ==="
echo "Hostname: $(hostname -f)"
echo "IP Address: $(hostname -I)"
