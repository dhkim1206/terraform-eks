variable "name" {
  type        = string
  default     = "default_sg"
  description = "name of the security group"
}

variable "ingress_rules" {
  type        = list(any)
  description = "ingress rule for this security group"
}

variable "egress_rules" {
  type        = list(any)
  description = "egress rule for this security group"
}