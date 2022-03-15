// ---------------------------------
// Resources
// ---------------------------------
data "template_file" "cloudinit_config" {
  template = file("./04-github-runner/start-scripts/cloud-init.cfg.tpl")
  vars = {
    region = var.os_region
    os_service_account_user = data.openstack_keymanager_secret_v1.os_service_account_user.payload
    os_service_account_pass = data.openstack_keymanager_secret_v1.os_service_account_pass.payload
    auth_url = var.auth_url
    project_id = var.tenant_id
    user_domain_name = var.user_domain_name

    aws_access_key_id = data.openstack_keymanager_secret_v1.aws_access_key_id.payload
    aws_secret_access_key = data.openstack_keymanager_secret_v1.aws_secret_access_key.payload
    github_api_token = data.openstack_keymanager_secret_v1.github_api_token.payload
  }
}

data "template_file" "start_script" {
  template = file("./04-github-runner/start-scripts/github-runner-start.sh.tpl")
}

data "template_cloudinit_config" "cilium-test-vm-config" {
  gzip = true
  base64_encode = true
  part {
    filename = "cloudinit-config.cfg"
    content_type = "text/cloud-config"
    content = data.template_file.cloudinit_config.rendered
  }
  part {
    filename = "bootstrap.sh"
    content_type = "text/x-shellscript"
    content = data.template_file.start_script.rendered
  }
}

resource "openstack_compute_instance_v2" "cilium-test-vm" {
  count = var.cilium_test_vm_instance_count
  name = "${var.os_env}-cilium-test-vm-${count.index}"
  flavor_name = var.cilium_test_vm_instance_flavor
  security_groups = [
    data.openstack_networking_secgroup_v2.internal.name
  ]
  availability_zone = element(var.compute_availability_zones, count.index)
  network {
    uuid = data.openstack_networking_network_v2.cilium.id
  }
  metadata = {
    component = "cilium-test-vm"
    environment = var.env
    pip = var.pip_version
    dependencies = var.pip_dependencies
    infra_version = var.build_number
    class = "cilium-test-vm"
    playbook_dir = var.playbook_dir
    playbook = "cilium-test-vm.yaml"
    env_vars_file = var.env_vars_file
  }
  user_data = data.template_cloudinit_config.cilium-test-vm-config.rendered
}