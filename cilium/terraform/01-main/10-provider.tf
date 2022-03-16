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
  backend "s3" {
    profile = "soteria"
    bucket = "soteria-terraform-state"
    dynamodb_table = "soteria-terraform-state"
    region = "eu-west-1"
    key = "cilium/main"
  }

  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.47"
    }
  }

  required_version = ">= 0.13"
}