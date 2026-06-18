variable "description" {
  type = string
}

variable "deletion_window_in_days" {
  type    = number
  default = 10
}

variable "tags" {
  type    = map(string)
  default = {}
}