data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = var.backend_organization
    workspaces = {
      name = var.vpc_workspace
    }
  }
}