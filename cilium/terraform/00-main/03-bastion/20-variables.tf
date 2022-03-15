// ---------------------------------
// Variables
// ---------------------------------
variable "os_env" {
  type = string
}
variable "env" {
  type = string
}
variable "cidr" {
  type = map
}
variable "build_number" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "user_domain_name" {
  type = string
}
variable "os_region" {
  type = string
}
variable "auth_url" {
  type = string
}
variable "compute_availability_zones" {
  type = list
}
variable "centos_image_name" {
  type = string
}
variable "bastion_instance_count" {
  type = number
}
variable "bastion_instance_flavor" {
  type = string
}
variable "whitelisted_networks" {
  type = map
}
variable "pip_version" {
  type = string
}
variable "pip_dependencies" {
  type = string
}
variable "playbook_dir" {
  type = string
}
variable "env_vars_file" {
  type = string
}

// ---------------------------------
// References
// ---------------------------------
data "openstack_images_image_v2" "centos_image" {
  name = var.centos_image_name
  most_recent = true
}
data "openstack_networking_network_v2" "dmz_network" {
  name = "dmz-network"
}
data "openstack_networking_secgroup_v2" "general_access_to_bastion" {
  name = "general_access_to_bastion"
}
data "openstack_networking_floatingip_v2" "bastion_fip" {
  count = var.bastion_instance_count
  description = "${var.env}-bastion-fip-${count.index}"
}
data "openstack_keymanager_secret_v1" "os_service_account_pass" {
  name = "os_service_account_pass"
  mode = "cbc"
}
data "openstack_keymanager_secret_v1" "os_service_account_user" {
  name = "os_service_account_user"
  mode = "cbc"
}
data "openstack_keymanager_secret_v1" "aws_access_key_id" {
  name = "aws_access_key_id"
  mode = "cbc"
}
data "openstack_keymanager_secret_v1" "aws_secret_access_key" {
  name = "aws_secret_access_key"
  mode = "cbc"
}
data "openstack_keymanager_secret_v1" "github_api_token" {
  name = "github_api_token"
  mode = "cbc"
}