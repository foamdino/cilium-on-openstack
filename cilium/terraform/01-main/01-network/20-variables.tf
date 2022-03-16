variable "os_env" {
  type = string
}
variable "mtu_value" {
  type = number
}
variable "cidr" {
  type = map
}
variable "external_network_name" {
  type = string
}

// ---------------------------------
// References
// ---------------------------------
data "openstack_networking_network_v2" "external_network" {
  name = var.external_network_name
}