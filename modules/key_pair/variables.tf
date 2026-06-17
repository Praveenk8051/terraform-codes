variable "key_pair_name" {
  description = "Name of the key pair"
  type        = string
  default     = "localstack-key"
}

variable "algorithm" {
  description = "Algorithm for the private key"
  type        = string
  default     = "RSA"
}

variable "rsa_bits" {
  description = "Number of bits for RSA key"
  type        = number
  default     = 4096
}

variable "private_key_path" {
  description = "Path where the private key will be saved"
  type        = string
  default     = "."
}

variable "tags" {
  description = "Tags for the key pair"
  type        = map(string)
  default     = {}
}
