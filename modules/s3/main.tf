# S3 Bucket Module

resource "aws_kms_key" "test_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "test-bucket" {
  bucket = var.aws_s3_bucket


  tags = merge(
    var.tags,
    {
      Name = var.aws_s3_bucket
    }
  )
}
resource "aws_s3_bucket_versioning" "test-bucket" {
  bucket = aws_s3_bucket.test-bucket.id
  versioning_configuration {
    status = var.aws_s3_bucket_versioning ? "Enabled" : "Suspended"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "test-bucket" {
  bucket = aws_s3_bucket.test-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.test_key.arn
    }
    bucket_key_enabled = true 
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "versioning-bucket-config" {
  # Must have bucket versioning enabled first
  depends_on = [aws_s3_bucket_versioning.test-bucket]

  bucket = aws_s3_bucket.test-bucket.bucket

  rule {
    id = "config"

    filter {
      prefix = var.aws_s3_bucket_lifecycle_prefix
    }

    noncurrent_version_expiration {
      noncurrent_days = var.aws_s3_bucket_noncurrent_version_expiration
    }

    noncurrent_version_transition {
      noncurrent_days = var.aws_s3_bucket_standard_ia_transition_days
      storage_class   = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = var.aws_s3_bucket_glacier_transition_days
      storage_class   = "GLACIER"
    }

    status = "Enabled"
  }
}