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

module "rbac" {
  source = "../../modules/iam-rbac"

  users = {
    alice = {}
    bob   = {}
    john  = {}
  }

  groups = {
    developers = {
      users = ["alice", "bob"]
    }

    admins = {
      users = ["john"]
    }
  }

  policies = {
    developer-policy = {
      description = "Developer access"

      document = jsonencode({
        Version = "2012-10-17"

        Statement = [
          {
            Effect = "Allow"
            Action = [
              "s3:*"
            ]
            Resource = "*"
          }
        ]
      })
    }
  }

  roles = {
    EKSAdminRole = {
      assume_role_policy = jsonencode({
        Version = "2012-10-17"

        Statement = [{
          Effect = "Allow"

          Principal = {
            Service = "ec2.amazonaws.com"
          }

          Action = "sts:AssumeRole"
        }]
      })
    }
  }

  group_policy_attachments = {
    developers = [
      "developer-policy"
    ]
  }

  role_policy_attachments = {
    EKSAdminRole = [
      "developer-policy"
    ]
  }
}