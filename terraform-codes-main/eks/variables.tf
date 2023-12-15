variable "vpc_workspace" {
  type        = string
  description = "workspace name of the vpc that contains this eks cluster"
}

variable "cluster_name" {
  type        = string
  description = "cluster name of this eks"
}

variable "cluster_version" {
  type        = string
  description = "eks cluster version"
}