# Cilium on Openstack with self-provisioning

This contains two main directories, the first is the ansible which is executed directly on the hosts. The second contains terraform modules and configuration to build the kubernetes hosts in the Openstack environment

## Infrastructure

The bare vms + user accounts + local iptables/firewalld rules are configured via terraform + ansible contained here.

## Releases

To make a 'release' of the infrastructure which will create a tag in guthub allowing us to download a tarball of this exact version.

    GRGIT_USER='user' GRGIT_PASS='api_token' ./gradlew final

