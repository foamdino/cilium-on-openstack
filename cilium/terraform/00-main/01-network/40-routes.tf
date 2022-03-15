// ---------------------------------
// Resources
// ---------------------------------
resource "openstack_networking_router_v2" "router" {
  admin_state_up = "true"
  name = "${var.os_env}-router"
  external_network_id = data.openstack_networking_network_v2.external_network.id
}

resource "openstack_networking_port_v2" "router_port_to_dmz" {
  name = "router_port_to_dmz"
  network_id = openstack_networking_network_v2.dmz_network.id
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.dmz.id
    ip_address = cidrhost(var.cidr["dmz"], 1)
  }
}
resource "openstack_networking_router_interface_v2" "router_interface_router_to_dmz" {
  router_id = openstack_networking_router_v2.router.id
  port_id = openstack_networking_port_v2.router_port_to_dmz.id
}

resource "openstack_networking_port_v2" "router_port_to_cilium" {
  name = "router_port_to_cilium"
  network_id = openstack_networking_network_v2.cilium_network.id
  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.cilium.id
    ip_address = cidrhost(var.cidr["cilium"], 1)
  }
}

resource "openstack_networking_router_interface_v2" "router_interface_router_to_cilium" {
  router_id = openstack_networking_router_v2.router.id
  port_id = openstack_networking_port_v2.router_port_to_cilium.id
}