#Bastion floating IPs
resource "openstack_networking_floatingip_v2" "bastion-fip" {
  count = var.bastion_instance_count
  pool = var.external_network_name
  description = "${var.env}-bastion-fip-${count.index}"
  tags = ["bastion-fip", "bastion-fip-${count.index}", var.env]
}