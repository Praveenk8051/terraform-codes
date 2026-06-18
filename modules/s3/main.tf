# S3 Bucket Module

resource "aws_s3_bucket" "test-bucket" {
  bucket = var.aws_s3_bucket


  tags = merge(
    var.tags,
    {
      Name = var.aws_s3_bucket
    }
  )
}
