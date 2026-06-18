output "aws_s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.test-bucket.bucket
}

output "aws_s3_bucket_versioning" {
  description = "The versioning status of the S3 bucket"
  value       = aws_s3_bucket_versioning.test-bucket.status
}

output "aws_s3_bucket_encryption" {
  description = "The encryption status of the S3 bucket"
  value       = aws_s3_bucket_server_side_encryption_configuration.test-bucket.rule[0].apply_server_side_encryption_by_default.sse_algorithm
}