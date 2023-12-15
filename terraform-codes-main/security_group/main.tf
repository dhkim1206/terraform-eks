locals {
  common_tags = {
    project = "miracle-sprinters"
    Owner   = "brian"
  }
}

module "all_access_sg" {
  source  = "tedilabs/network/aws//modules/security-group"
  version = "0.24.0"

  name        = var.name
  description = "security group for all traffic"

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  egress_rules = var.egress_rules

  ingress_rules = var.ingress_rules

  tags = local.common_tags
}