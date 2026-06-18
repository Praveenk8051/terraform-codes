# Security Group Module
module "s3" {
  source = "./modules/s3"

  aws_s3_bucket = var.aws_s3_bucket
  tags          = var.tags
}