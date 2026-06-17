# Security Group Module

resource "aws_security_group" "main" {
  name_prefix = var.name_prefix
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = var.security_group_name
    }
  )
}

# Inbound SSH
resource "aws_security_group_rule" "ssh_inbound" {
  count             = var.enable_ssh ? 1 : 0
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.ssh_cidr_blocks
  security_group_id = aws_security_group.main.id
  description       = "SSH access"
}

# Inbound HTTP
resource "aws_security_group_rule" "http_inbound" {
  count             = var.enable_http ? 1 : 0
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.http_cidr_blocks
  security_group_id = aws_security_group.main.id
  description       = "HTTP access"
}

# Inbound HTTPS
resource "aws_security_group_rule" "https_inbound" {
  count             = var.enable_https ? 1 : 0
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.https_cidr_blocks
  security_group_id = aws_security_group.main.id
  description       = "HTTPS access"
}

# Outbound all traffic
resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.egress_cidr_blocks
  security_group_id = aws_security_group.main.id
  description       = "Allow all outbound traffic"
}
