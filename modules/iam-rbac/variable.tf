variable "users" {
  description = "IAM users"

  type = map(object({
    path = optional(string, "/")
  }))

  default = {}
}

variable "groups" {
  description = "IAM groups"

  type = map(object({
    users = list(string)
  }))

  default = {}
}

variable "policies" {
  description = "Custom IAM policies"

  type = map(object({
    description = string
    document    = string
  }))

  default = {}
}

variable "roles" {
  description = "IAM Roles"

  type = map(object({
    assume_role_policy = string
  }))

  default = {}
}

variable "group_policy_attachments" {
  type = map(list(string))
  default = {}
}

variable "role_policy_attachments" {
  type = map(list(string))
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}