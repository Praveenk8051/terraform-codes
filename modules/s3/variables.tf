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
