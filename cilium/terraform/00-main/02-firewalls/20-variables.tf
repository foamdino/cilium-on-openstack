// ---------------------------------
// Variables
// ---------------------------------
variable "os_env" {
  type = string
}
variable "cidr" {
  type = map
}
variable "whitelisted_networks" {
  type = map
}

// ---------------------------------
// References
// ---------------------------------
data "openstack_networking_network_v2" "cilium_network" {
  name = "cilium-network"
}