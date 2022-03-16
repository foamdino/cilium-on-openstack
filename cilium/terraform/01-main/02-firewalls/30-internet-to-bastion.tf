// ---------------------------------
// Internet to Bastion Security Group (assigned to bastions in the DMZ)
// ---------------------------------
resource "openstack_networking_secgroup_v2" "general_access_to_bastion" {
  name = "general_access_to_bastion"
  description = "SSH access to Bastion"
  tags = ["general_access_to_bastion_${var.os_env}", var.os_env, "general", "ssh"]
}

resource "openstack_networking_secgroup_rule_v2" "general_access_to_bastion_22_tcp" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  description = "internet_to_bastion_22_tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.general_access_to_bastion.id
}