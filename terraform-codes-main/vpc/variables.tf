variable "vpc_name" {
  type        = string
  default     = "default"
  description = "the name of the associated VPC"
}

variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "cidr block of the VPC"
}

variable "public_subnets" {
  type        = map(map(any))
  description = "A map of public subnet's rule"
}

variable "private_subnets" {
  type        = map(map(any))
  description = "A map of private subnet's rule"
}

variable "nacl_ingress_rules_public" {
  type        = map(map(any))
  description = "A map of ingress rules of public subnets in a network ACL. Use the key of map as the rule number"
}

variable "nacl_egress_rules_public" {
  type        = map(map(any))
  description = "A map of egress rules of public subnets in a network ACL. Use the key of map as the rule number"
}

variable "nacl_ingress_rules_private" {
  type        = map(map(any))
  description = "A map of ingress rules of public subnets in a network ACL. Use the key of map as the rule number"
}

variable "nacl_egress_rules_private" {
  type        = map(map(any))
  description = "A map of egress rules of public subnets in a network ACL. Use the key of map as the rule number"
}