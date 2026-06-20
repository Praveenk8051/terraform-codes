# Terraform EC2 on LocalStack

A complete Terraform configuration to deploy an EC2 instance with security group and key pair on LocalStack (local AWS mock environment).

## Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Configuration](#configuration)
- [Deployment](#deployment)
- [Outputs](#outputs)
- [Cleanup](#cleanup)
- [Troubleshooting](#troubleshooting)

## Prerequisites

You'll need the following tools installed on your system:

1. **Docker** - For running LocalStack
   - [Install Docker](https://docs.docker.com/get-docker/)

2. **Docker Compose** - For orchestrating LocalStack
   - [Install Docker Compose](https://docs.docker.com/compose/install/)

3. **Terraform** - For infrastructure as code
   - [Install Terraform](https://www.terraform.io/downloads)
   - Recommended version: v1.0 or later

4. **AWS CLI** (optional) - For interacting with LocalStack
   - [Install AWS CLI](https://aws.amazon.com/cli/)

## Quick Start

### Option 1: Automated Setup (Recommended)

```bash
# Make the setup script executable
chmod +x scripts/setup.sh

# Run the setup script (Linux/macOS)
./scripts/setup.sh

# For Windows PowerShell
.\scripts\setup.ps1  # (if available) or use WSL
```

### Option 2: Manual Setup

#### 1. Start LocalStack

```bash
docker-compose up -d
```

Verify LocalStack is running:
```bash
curl http://localhost:4566/health
```

#### 2. Initialize Terraform

```bash
terraform init
```

#### 3. Validate Configuration

```bash
terraform validate
```

#### 4. Review Plan

```bash
terraform plan
```

#### 5. Apply Configuration

```bash
terraform apply
```

## Project Structure

```
.
├── docker-compose.yml       # LocalStack Docker Compose configuration
├── .env                     # Environment variables and Terraform vars
├── .gitignore               # Git ignore patterns
├── provider.tf              # AWS provider configuration pointing to LocalStack
├── variables.tf             # Input variables for customization
├── main.tf                  # EC2, security group, and key pair resources
├── outputs.tf               # Output values (instance ID, IPs, etc.)
├── user_data.sh             # EC2 initialization script (optional)
├── scripts/
│   └── setup.sh             # Automated setup script (Linux/macOS)
└── readme.md                # This file
```

## Configuration

### LocalStack Endpoint

The Terraform configuration connects to LocalStack at `http://localhost:4566` by default.

To change this, modify in `.env`:
```bash
LOCALSTACK_ENDPOINT=http://localhost:4566
```

Or pass as variable:
```bash
terraform apply -var="localstack_endpoint=http://localhost:4566"
```

### EC2 Instance Variables

Customize instance configuration via `.env` or command line:

| Variable | Default | Description |
|----------|---------|-------------|
| `instance_type` | `t2.micro` | EC2 instance type |
| `instance_name` | `localstack-ec2-demo` | Name tag for the instance |
| `environment` | `development` | Environment tag |
| `ami_id` | `ami-0c02fb55956c7d316` | AMI ID (Amazon Linux 2) |
| `create_key_pair` | `true` | Whether to create a key pair |
| `key_pair_name` | `localstack-key` | Name of the key pair |
| `enable_user_data` | `true` | Whether to run user data script |
| `aws_region` | `us-east-1` | AWS region |

#### Custom Instance Configuration

Via environment variables:
```bash
export TF_VAR_instance_type="t2.small"
export TF_VAR_instance_name="my-custom-instance"
terraform apply
```

Via command line:
```bash
terraform apply \
  -var="instance_type=t2.small" \
  -var="instance_name=my-custom-instance"
```

Via tfvars file (create `terraform.tfvars`):
```hcl
instance_type = "t2.small"
instance_name = "my-custom-instance"
environment   = "staging"
```

## Deployment

### Step-by-Step Deployment

1. **Check LocalStack Status**
   ```bash
   curl http://localhost:4566/health
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Review Resources to be Created**
   ```bash
   terraform plan
   ```

4. **Deploy Resources**
   ```bash
   terraform apply
   ```

5. **View Outputs**
   ```bash
   terraform output
   ```

### Verify Deployment

Check your instance in LocalStack:

```bash
aws ec2 describe-instances \
  --endpoint-url http://localhost:4566 \
  --region us-east-1
```

### SSH into Instance (if applicable)

```bash
ssh -i localstack-key.pem ec2-user@<PUBLIC_IP>
```

**Note**: In LocalStack, SSH connectivity may be limited. This setup creates the infrastructure correctly, but actual SSH access depends on LocalStack's networking capabilities.

## Outputs

After deployment, Terraform outputs important information:

- **instance_id** - The EC2 instance ID
- **instance_private_ip** - Private IP address
- **instance_public_ip** - Public IP address (if available)
- **instance_security_group_id** - Security group ID
- **key_pair_name** - Name of the generated key pair
- **private_key_file** - Path to the private key file
- **connection_command** - SSH command to connect
- **instance_state** - Current state of the instance

View outputs anytime:
```bash
terraform output
terraform output <output_name>  # For specific output
terraform output -json          # JSON format
```

## Cleanup

### Destroy Infrastructure

```bash
terraform destroy
```

### Stop LocalStack

```bash
docker-compose down
```

### Complete Cleanup

```bash
# Destroy Terraform resources
terraform destroy

# Stop and remove LocalStack containers
docker-compose down

# Remove LocalStack volume (optional)
docker-compose down -v

# Remove Terraform state
rm -f terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl

# Remove generated key pair
rm -f localstack-key.pem

# Remove Terraform working directory
rm -rf .terraform/
```

## Advanced Configuration

### Remote State (AWS S3)

To store state in AWS S3 (non-LocalStack):

1. Create `backend.tf`:
```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "localstack-demo/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
```

2. Reinitialize:
```bash
terraform init
```

### Multiple Environments

Create environment-specific tfvars files:

```bash
# development.tfvars
environment = "development"
instance_type = "t2.micro"

# staging.tfvars
environment = "staging"
instance_type = "t2.small"

# production.tfvars
environment = "production"
instance_type = "t2.medium"
```

Deploy specific environment:
```bash
terraform apply -var-file="staging.tfvars"
```

### Custom User Data

Modify `user_data.sh` to customize EC2 initialization:

```bash
#!/bin/bash
# Add your custom commands here
yum install -y nginx
systemctl start nginx
systemctl enable nginx
```

Then apply:
```bash
terraform apply -var="enable_user_data=true"
```

## Troubleshooting

### LocalStack Not Starting

**Issue**: `docker-compose up` fails

**Solution**:
```bash
# Check Docker daemon
docker ps

# View logs
docker-compose logs -f localstack

# Rebuild
docker-compose down
docker-compose pull
docker-compose up -d
```

### Terraform Init Fails

**Issue**: `terraform init` throws errors

**Solution**:
```bash
# Clear Terraform cache
rm -rf .terraform/
rm .terraform.lock.hcl

# Reinitialize
terraform init -upgrade
```

### Health Check Fails

**Issue**: LocalStack shows as unhealthy

**Solution**:
```bash
# Wait longer (LocalStack startup can take 30-60 seconds)
sleep 60
curl http://localhost:4566/health

# Check logs
docker-compose logs localstack

# Restart
docker-compose restart localstack
```

### Port Already in Use

**Issue**: Port 4566 is already in use

**Solution**:
```bash
# Find and kill process using port 4566
# Linux/macOS
lsof -i :4566
kill -9 <PID>

# Windows
netstat -ano | findstr :4566
taskkill /PID <PID> /F

# Or change port in docker-compose.yml
# Change "4566:4566" to "4567:4566" and update .env
```

### Terraform Apply Fails

**Issue**: Resource creation errors

**Solution**:
```bash
# Check LocalStack logs
docker-compose logs -f localstack

# Validate configuration
terraform validate

# Plan with verbose output
TF_LOG=DEBUG terraform plan

# Destroy and retry
terraform destroy -auto-approve
terraform apply
```

## Best Practices

1. **Version Control**: Commit `.tf` files but exclude:
   - `.terraform/` directory
   - `*.tfstate` files
   - `*.tfstate.backup` files
   - `*.pem` key files
   - `.env` with sensitive values

2. **State Management**: 
   - For production: Use remote state (S3, Terraform Cloud)
   - For local development: Local state is fine (already in `.gitignore`)

3. **Security**:
   - Never commit `.env` files with real credentials
   - Use IAM roles instead of access keys when possible
   - Restrict security group CIDR blocks (avoid `0.0.0.0/0` in production)

4. **Documentation**:
   - Update this README for team reference
   - Document custom modifications
   - Keep track of variable customizations

## References

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [LocalStack Documentation](https://docs.localstack.cloud/)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)

## License

This project is open source and available under the MIT License.

## Support

For issues or questions:
1. Check the [Troubleshooting](#troubleshooting) section
2. Review LocalStack logs: `docker-compose logs localstack`
3. Enable Terraform debug: `TF_LOG=DEBUG terraform apply`
4. Consult [LocalStack Issues](https://github.com/localstack/localstack/issues)
5. Check [Terraform Issues](https://github.com/hashicorp/terraform-provider-aws/issues)


iam-rbac

Use Case

```
Developers Group
 ├── Alice
 ├── Bob

Admins Group
 ├── John

ReadOnly Group
 ├── Sarah
```

 Policies

```
DeveloperPolicy
AdminPolicy
ReadOnlyPolicy
```

Roles

```
EKSAdminRole
S3ReadRole
CrossAccountRole
```