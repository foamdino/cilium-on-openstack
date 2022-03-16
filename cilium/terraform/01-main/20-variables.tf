// ---------------------------------
// Variables
// ---------------------------------
variable "os_env" {
  type = string
}
variable "env" {
  type = string
}
variable "whitelisted_networks" {
  type = map
}
variable "bastion_instance_count" {
  type = number
}
variable "bastion_instance_flavor" {
  type = string
}
variable "cilium_test_vm_instance_count" {
  type = number
}
variable "cilium_test_vm_instance_flavor" {
  type = string
}
variable "external_network_name" {
  type = string
}
variable "mtu_value" {
  type = number
}
variable "cidr" {
  type = map
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
variable "volume_availability_zones" {
  type = list
}
variable "centos_image_name" {
  type = string
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
variable "build_number" {
  type = string
}
