# VPC information from terraform remote backend (app.terraform.io)
data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "your-organization"
    workspaces = {
      name = "vpc"
    }
  }
}