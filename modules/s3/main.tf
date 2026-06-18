resource "aws_kms_key" "this" {
  count = var.create_kms_key ? 1 : 0

  description             = "S3 bucket encryption key"
  deletion_window_in_days = 10

  tags = var.tags
}

locals {
  effective_kms_key_arn = (
    var.create_kms_key
    ? aws_kms_key.this[0].arn
    : var.kms_key_arn
  )
}
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name

  tags = merge(
    var.tags,
    {
      Name = var.bucket_name
    }
  )
}
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = local.effective_kms_key_arn
    }

    bucket_key_enabled = true
  }
}
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  count = var.enable_lifecycle ? 1 : 0

  depends_on = [
    aws_s3_bucket_versioning.this
  ]

  bucket = aws_s3_bucket.this.id

  rule {
    id     = "default"
    status = "Enabled"

    filter {
      prefix = var.lifecycle_prefix
    }

    noncurrent_version_expiration {
      noncurrent_days = var.noncurrent_expiration_days
    }

    dynamic "noncurrent_version_transition" {
      for_each = var.lifecycle_transitions

      content {
        noncurrent_days = noncurrent_version_transition.value.days
        storage_class   = noncurrent_version_transition.value.storage_class
      }
    }
  }
}
resource "aws_s3_bucket_logging" "this" {
  count = var.enable_logging ? 1 : 0

  bucket = aws_s3_bucket.this.id

  target_bucket = var.logging_bucket
  target_prefix = var.logging_prefix
}