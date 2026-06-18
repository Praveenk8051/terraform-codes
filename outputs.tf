output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3.aws_s3_bucket_name
}
