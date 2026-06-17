#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}LocalStack + Terraform EC2 Setup${NC}"
echo -e "${GREEN}========================================${NC}"

# Check prerequisites
echo -e "\n${YELLOW}Checking prerequisites...${NC}"

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not installed${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Docker is installed${NC}"

if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose is not installed${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Docker Compose is installed${NC}"

if ! command -v terraform &> /dev/null; then
    echo -e "${RED}❌ Terraform is not installed${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Terraform is installed${NC}"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Change to project root
cd "$PROJECT_ROOT"

# Start LocalStack
echo -e "\n${YELLOW}Starting LocalStack...${NC}"
docker-compose up -d

# Wait for LocalStack to be ready
echo -e "${YELLOW}Waiting for LocalStack to be ready...${NC}"
for i in {1..30}; do
    if curl -s http://localhost:4566/health > /dev/null 2>&1; then
        echo -e "${GREEN}✓ LocalStack is ready${NC}"
        break
    fi
    if [ $i -eq 30 ]; then
        echo -e "${RED}❌ LocalStack failed to start${NC}"
        exit 1
    fi
    echo "Attempt $i/30..."
    sleep 2
done

# Initialize Terraform
echo -e "\n${YELLOW}Initializing Terraform...${NC}"
terraform init

# Validate Terraform configuration
echo -e "\n${YELLOW}Validating Terraform configuration...${NC}"
terraform validate

# Show plan
echo -e "\n${YELLOW}Terraform Plan:${NC}"
terraform plan -out=tfplan

# Ask for confirmation
read -p "$(echo -e "${YELLOW}Do you want to apply the Terraform plan? (yes/no): ${NC}")" -n 3 -r
echo
if [[ $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
    echo -e "\n${YELLOW}Applying Terraform configuration...${NC}"
    terraform apply tfplan
    
    echo -e "\n${GREEN}========================================${NC}"
    echo -e "${GREEN}Deployment Complete!${NC}"
    echo -e "${GREEN}========================================${NC}"
    
    echo -e "\n${YELLOW}Instance Details:${NC}"
    terraform output
    
    echo -e "\n${YELLOW}To destroy resources:${NC}"
    echo -e "${GREEN}terraform destroy${NC}"
    
    echo -e "\n${YELLOW}To stop LocalStack:${NC}"
    echo -e "${GREEN}docker-compose down${NC}"
else
    echo -e "${YELLOW}Deployment cancelled${NC}"
    rm -f tfplan
fi
