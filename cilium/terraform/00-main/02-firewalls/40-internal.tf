// -------------------------
// VM to VM Security Group
// -------------------------
resource "openstack_networking_secgroup_v2" "internal" {
  name = "internal"
  description = "internal Security Group"
  tags = ["internal-${var.os_env}", var.os_env]
}

//SSH
resource "openstack_networking_secgroup_rule_v2" "dmz_to_internal_22_tcp" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  description = "dmz_tointernal_22_tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = var.cidr["dmz"]
  security_group_id = openstack_networking_secgroup_v2.internal.id
}
