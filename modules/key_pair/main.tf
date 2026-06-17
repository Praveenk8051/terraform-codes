# Key Pair Module

resource "tls_private_key" "main" {
  algorithm = var.algorithm
  rsa_bits  = var.rsa_bits
}

resource "aws_key_pair" "main" {
  key_name       = var.key_pair_name
  public_key     = tls_private_key.main.public_key_openssh
  tags           = var.tags
}

# Save private key to file
resource "local_file" "private_key" {
  filename          = "${var.private_key_path}/${var.key_pair_name}.pem"
  content           = tls_private_key.main.private_key_pem
  file_permission   = "0600"
  depends_on        = [aws_key_pair.main]
}
