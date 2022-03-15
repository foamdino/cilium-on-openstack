#Provider Details
env = "cilium"
os_region = "eu-west"
auth_url = "https://openstack.gb-lon.thghosting.cloud:5000/v3"
tenant_id = "e86e59a3f1274da39c5369b1a626e672"
workspace = "cilium"
os_env = "li-rnd"
user_domain_name = "voyager"

external_network_name = "thg-external-1"
mtu_value = 1450

#Environment Networks
cidr = {
  dmz = "10.66.1.0/24"
  cilium = "10.66.2.0/24"
}

volume_availability_zones = ["gb-lon-1", "gb-lon-2", "gb-lon-3"]
compute_availability_zones = ["gb-lon-1", "gb-lon-2", "gb-lon-3"]

#Server Config
centos_image_name = "CentOS 7 THG Base"
pip_version = "19.3.1"
pip_dependencies = "{\"keystoneauth1\": \"3.18.0\", \"awscli\": \"1.16.290\", \"ansible\": \"2.9.2\", \"six\": \"1.13.0\", \"decorator\": \"4.4.1\", \"openstacksdk\": \"0.43.0\", \"netaddr\": \"0.8.0\"}"
playbook_dir = ""
env_vars_file = "thn2-li-rnd.yml"

bastion_instance_count = 1
bastion_instance_flavor = "c1.tiny"

# github runner
cilium_instance_count = 1
cilium_instance_flavor = "m1.medium"