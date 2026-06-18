# Security Group Module
module "s3" {
  source = "./modules/s3"

  aws_s3_bucket = var.aws_s3_bucket
  tags          = var.tags
  aws_s3_bucket_versioning = var.aws_s3_bucket_versioning
  aws_s3_bucket_encryption = var.aws_s3_bucket_encryption
  aws_s3_bucket_noncurrent_version_expiration = var.aws_s3_bucket_noncurrent_version_expiration
  aws_s3_bucket_standard_ia_transition_days = var.aws_s3_bucket_standard_ia_transition_days
  aws_s3_bucket_glacier_transition_days = var.aws_s3_bucket_glacier_transition_days
}