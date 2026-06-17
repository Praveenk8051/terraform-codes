# Security Group Module
module "security_group" {
  source = "./modules/security_group"

  security_group_name = "${var.instance_name}-sg"
  enable_ssh          = true
  enable_http         = true
  enable_https        = true
  ssh_cidr_blocks     = var.ssh_cidr_blocks
  http_cidr_blocks    = var.http_cidr_blocks
  https_cidr_blocks   = var.https_cidr_blocks
  egress_cidr_blocks  = var.egress_cidr_blocks

  tags = var.tags
}

# Key Pair Module
module "key_pair" {
  count = var.create_key_pair ? 1 : 0

  source = "./modules/key_pair"

  key_pair_name    = var.key_pair_name
  private_key_path = var.private_key_path

  tags = var.tags
}

# User Data script
locals {
  user_data_script = var.enable_user_data ? base64encode(templatefile("${path.module}/user_data.sh", {
    instance_name = var.instance_name
  })) : null
}

# EC2 Instance Module
module "ec2" {
  source = "./modules/ec2"

  ami_id              = var.ami_id
  instance_type       = var.instance_type
  instance_name       = var.instance_name
  key_name            = var.create_key_pair ? module.key_pair[0].key_pair_name : null
  security_group_ids  = [module.security_group.security_group_id]
  user_data           = local.user_data_script
  monitoring_enabled  = true
  ebs_optimized       = false
  root_volume_type    = "gp2"
  root_volume_size    = 20
  root_volume_encrypted = false

  tags = var.tags

  depends_on = [module.security_group]
}
