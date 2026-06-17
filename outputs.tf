output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = module.ec2.instance_id
}

output "instance_arn" {
  description = "The ARN of the EC2 instance"
  value       = module.ec2.instance_arn
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.ec2.instance_private_ip
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.ec2.instance_public_ip
}

output "instance_security_group_id" {
  description = "The security group ID of the EC2 instance"
  value       = module.security_group.security_group_id
}

output "instance_security_group_name" {
  description = "The name of the security group"
  value       = module.security_group.security_group_name
}

output "key_pair_name" {
  description = "Name of the key pair created"
  value       = var.create_key_pair ? module.key_pair[0].key_pair_name : "N/A"
}

output "private_key_file" {
  description = "Path to the private key file"
  value       = var.create_key_pair ? module.key_pair[0].private_key_path : "N/A"
  sensitive   = true
}

output "instance_state" {
  description = "The state of the EC2 instance"
  value       = module.ec2.instance_state
}

output "vpc_security_group_ids" {
  description = "Security group IDs associated with the instance"
  value       = module.ec2.security_group_ids
}

output "connection_command" {
  description = "SSH command to connect to the instance (when available)"
  value       = var.create_key_pair ? "ssh -i ${module.key_pair[0].private_key_path} ec2-user@${module.ec2.instance_public_ip}" : "Use your own key to connect"
  sensitive   = false
}
