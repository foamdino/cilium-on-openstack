// ---------------------------------
// Resources
// ---------------------------------
resource "openstack_networking_network_v2" "dmz_network" {
  name = "dmz-network"
  admin_state_up = "true"
  mtu = var.mtu_value
}

resource "openstack_networking_subnet_v2" "dmz" {
  name = "dmz-subnet"
  network_id = openstack_networking_network_v2.dmz_network.id
  cidr = var.cidr["dmz"]
  allocation_pool {
    start = cidrhost(var.cidr["dmz"], 20)
    end = cidrhost(var.cidr["dmz"], 254)
  }
}

resource "openstack_networking_network_v2" "cilium_network" {
  name = "cilium-network"
  admin_state_up = "true"
  mtu = var.mtu_value
}

resource "openstack_networking_subnet_v2" "cilium" {
  name = "cilium-subnet"
  network_id = openstack_networking_network_v2.cilium_network.id
  cidr = var.cidr["cilium"]
  allocation_pool {
    start = cidrhost(var.cidr["cilium"], 20)
    end = cidrhost(var.cidr["cilium"], 254)
  }
}