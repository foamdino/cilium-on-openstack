module "network" {
  source = "./01-network"
  os_env = var.os_env
  mtu_value = var.mtu_value
  external_network_name = var.external_network_name
  cidr = var.cidr
  workspace = var.workspace
}

module "firewalls" {
  source = "./02-firewalls"
  os_env = var.os_env
  cidr = var.cidr
  whitelisted_networks = var.whitelisted_networks
  workspace = var.workspace
}

module "bastion" {
  source = "./03-bastion"
  os_env = var.os_env
  env = var.env
  cidr  = var.cidr
  build_number = var.build_number
  tenant_id = var.tenant_id
  user_domain_name = var.user_domain_name
  os_region = var.os_region
  auth_url = var.auth_url
  compute_availability_zones = var.compute_availability_zones
  centos_image_name = var.centos_image_name
  bastion_instance_count = var.bastion_instance_count
  bastion_instance_flavor = var.bastion_instance_flavor
  whitelisted_networks = var.whitelisted_networks
  pip_version = var.pip_version
  pip_dependencies = var.pip_dependencies
  playbook_dir = var.playbook_dir
  env_vars_file = var.env_vars_file
  workspace = var.workspace
}
/*
module "github-runner" {
  source = "./04-github-runner"
  os_env = var.os_env
  env = var.env
  cidr  = var.cidr
  build_number = var.build_number
  tenant_id = var.tenant_id
  user_domain_name = var.user_domain_name
  os_region = var.os_region
  auth_url = var.auth_url
  compute_availability_zones = var.compute_availability_zones
  freebsd_image_name = var.freebsd_image_name
  github_runner_instance_count = var.github_runner_instance_count
  github_runner_instance_flavor = var.github_runner_instance_flavor
  whitelisted_networks = var.whitelisted_networks
  pip_version = var.pip_version
  pip_dependencies = var.pip_dependencies
  playbook_dir = var.playbook_dir
  env_vars_file = var.env_vars_file
  workspace = var.workspace
}
*/