output "key_pair_name" {
  description = "Name of the key pair"
  value       = aws_key_pair.main.key_name
}

output "key_pair_arn" {
  description = "ARN of the key pair"
  value       = aws_key_pair.main.arn
}

output "public_key" {
  description = "Public key"
  value       = tls_private_key.main.public_key_openssh
  sensitive   = true
}

output "private_key_path" {
  description = "Path to the private key file"
  value       = local_file.private_key.filename
  sensitive   = true
}

output "private_key_fingerprint" {
  description = "Fingerprint of the private key"
  value       = tls_private_key.main.public_key_fingerprint_md5
}
