variable "env" {
  type = string
}

variable "sys_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "aws_account_id" {
  type = string
}

# IAM Role
variable "batch_service_role_arn" {
  type = string
}

variable "instance_role_name" {
  type = string
}

# Network
variable "subnet_ids" {
  type = list(string)
}

variable "security_group_ids" {
  type = list(string)
}
