variable "bucket_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "enable_versioning" {
  type    = bool
  default = false
}

variable "enable_logging" {
  type    = bool
  default = false
}

variable "logging_bucket" {
  type    = string
  default = null

  validation {
    condition = (
      var.enable_logging == false ||
      (var.enable_logging == true && var.logging_bucket != null)
    )
    error_message = "logging_bucket must be provided when enable_logging=true."
  }
}

variable "logging_prefix" {
  type    = string
  default = "logs/"
}

variable "enable_lifecycle" {
  type    = bool
  default = false
}

variable "lifecycle_prefix" {
  type    = string
  default = ""
}

variable "lifecycle_transitions" {
  type = list(object({
    days          = number
    storage_class = string
  }))

  default = []
}

variable "noncurrent_expiration_days" {
  type    = number
  default = 365
}

variable "create_kms_key" {
  type    = bool
  default = false
}

variable "kms_key_arn" {
  type    = string
  default = null

  validation {
    condition = !(
      var.create_kms_key &&
      var.kms_key_arn != null
    )

    error_message = "Specify either create_kms_key=true OR kms_key_arn, not both."
  }
}