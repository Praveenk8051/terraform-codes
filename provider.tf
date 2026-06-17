terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

  # LocalStack configuration
  endpoints {
    ec2 = var.localstack_endpoint
  }

  # Skip validation for LocalStack
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_region_validation      = true
}
