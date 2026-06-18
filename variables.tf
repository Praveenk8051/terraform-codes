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
variable "aws_s3_bucket_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = true
}
variable "aws_s3_bucket_encryption" {
  description = "Enable server-side encryption for the S3 bucket"
  type        = bool
  default     = true
}
variable "aws_s3_bucket_noncurrent_version_expiration" {
  description = "Number of days after which noncurrent versions of objects in the S3 bucket will be permanently deleted"
  type        = number
  default     = 30
}
variable "aws_s3_bucket_standard_ia_transition_days" {
  description = "Number of days after which noncurrent versions of objects in the S3 bucket will be transitioned to the STANDARD_IA storage class"
  type        = number
  default     = 30
}
variable "aws_s3_bucket_glacier_transition_days" {
  description = "Number of days after which noncurrent versions of objects in the S3 bucket will be transitioned to the GLACIER storage class"
  type        = number
  default     = 60
}
variable "aws_s3_bucket_lifecycle_prefix" {
  description = "Prefix for the S3 bucket lifecycle rule"
  type        = string
  default     = "config/"
}