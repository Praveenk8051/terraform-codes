variable "aws_s3_bucket" {
  description = "S3 bucket name"
  type        = string
  default     = "localstack-demo-bucket"
}
variable "tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
  default     = {}
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