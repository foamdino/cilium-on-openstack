variable "workspace" {
  type = string
}

#Hack to ensure user is in correct workspace
locals {
  assert_correct_workspace = terraform.workspace != var.workspace ? file("ERROR: Current workspace '${terraform.workspace}' is not the expected workspace '${var.workspace}'") : null
}

provider "openstack" {
  cloud = var.workspace
  insecure = true
}

terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.37"
    }
  }

  required_version = ">= 0.13"
}