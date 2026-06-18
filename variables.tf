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
  default     = "http://s3.localhost.localstack.cloud:4566"
}

variable "aws_s3_bucket" {
  description = "S3 bucket name"
  type        = string
  default     = "localstack-demo-bucket"
}
variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project   = "terraform-localstack-demo"
    CreatedBy = "Terraform"
    ManagedBy = "IaC"
  }
}
