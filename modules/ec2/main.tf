# EC2 Instance Module

resource "aws_instance" "main" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.security_group_ids
  user_data              = var.user_data
  subnet_id              = var.subnet_id

  monitoring    = var.monitoring_enabled
  ebs_optimized = var.ebs_optimized

  root_block_device {
    volume_type           = var.root_volume_type
    volume_size           = var.root_volume_size
    delete_on_termination = true
    encrypted             = var.root_volume_encrypted
  }

  tags = merge(
    var.tags,
    {
      Name = var.instance_name
    }
  )
}
