variable "name_prefix" {
  description = "Prefix for the security group name"
  type        = string
  default     = "localstack-ec2-"
}

variable "description" {
  description = "Description of the security group"
  type        = string
  default     = "Security group for LocalStack EC2 instance"
}

variable "security_group_name" {
  description = "Name tag for the security group"
  type        = string
  default     = "localstack-ec2-sg"
}

variable "vpc_id" {
  description = "VPC ID for the security group (optional)"
  type        = string
  default     = null
}

variable "enable_ssh" {
  description = "Enable SSH (port 22) inbound rule"
  type        = bool
  default     = true
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks allowed for SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_http" {
  description = "Enable HTTP (port 80) inbound rule"
  type        = bool
  default     = true
}

variable "http_cidr_blocks" {
  description = "CIDR blocks allowed for HTTP"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_https" {
  description = "Enable HTTPS (port 443) inbound rule"
  type        = bool
  default     = true
}

variable "https_cidr_blocks" {
  description = "CIDR blocks allowed for HTTPS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "egress_cidr_blocks" {
  description = "CIDR blocks allowed for egress traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {}
}
