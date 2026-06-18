module "kms" {
  source = "./modules/kms"

  description = "shared encryption key"
}
module "s3" {
  source = "./modules/s3"

  bucket_name = "demo-bucket"

  enable_versioning = true

  kms_key_arn = module.kms.kms_key_arn

  enable_lifecycle = true

  lifecycle_transitions = [
    {
      days          = 30
      storage_class = "STANDARD_IA"
    },
    {
      days          = 90
      storage_class = "GLACIER"
    }
  ]

  enable_logging = true
  logging_bucket = "access-logs"
}