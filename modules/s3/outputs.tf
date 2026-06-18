output "bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}

output "bucket_domain_name" {
  value = aws_s3_bucket.this.bucket_domain_name
}

output "kms_key_arn" {
  value = local.effective_kms_key_arn
}

output "versioning_enabled" {
  value = var.enable_versioning
}

output "logging_enabled" {
  value = var.enable_logging
}