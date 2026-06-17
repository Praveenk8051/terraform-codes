output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.main.id
}

output "instance_arn" {
  description = "The ARN of the EC2 instance"
  value       = aws_instance.main.arn
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.main.private_ip
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.main.public_ip
}

output "instance_state" {
  description = "Current state of the EC2 instance"
  value       = aws_instance.main.instance_state
}

output "instance_state_name" {
  description = "Current state name of the EC2 instance"
  value       = aws_instance.main.instance_state == "running" ? "running" : aws_instance.main.instance_state
}

output "security_group_ids" {
  description = "Security group IDs associated with the instance"
  value       = aws_instance.main.vpc_security_group_ids
}

output "key_name" {
  description = "Key pair name associated with the instance"
  value       = aws_instance.main.key_name
}
