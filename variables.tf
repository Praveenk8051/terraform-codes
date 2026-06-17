variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  default     = "test"
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  default     = "test"
  sensitive   = true
}

variable "localstack_endpoint" {
  description = "LocalStack endpoint URL"
  type        = string
  default     = "http://localhost:4566"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "localstack-ec2-demo"
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "development"
}

variable "ami_id" {
  description = "AMI ID to use for the instance (LocalStack)"
  type        = string
  default     = "ami-0c02fb55956c7d316"
}

variable "create_key_pair" {
  description = "Whether to create a new key pair"
  type        = bool
  default     = true
}

variable "key_pair_name" {
  description = "Name of the key pair"
  type        = string
  default     = "localstack-key"
}

variable "private_key_path" {
  description = "Path where private key will be saved"
  type        = string
  default     = "."
}

variable "enable_user_data" {
  description = "Whether to enable user data script"
  type        = bool
  default     = true
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks allowed for SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "http_cidr_blocks" {
  description = "CIDR blocks allowed for HTTP"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "https_cidr_blocks" {
  description = "CIDR blocks allowed for HTTPS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_cidr_blocks" {
  description = "CIDR blocks allowed for egress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project     = "terraform-localstack-demo"
    CreatedBy   = "Terraform"
    ManagedBy   = "IaC"
  }
}
