#cloud-config
write_files:
  - path: /etc/openstack/clouds.yaml
    content: |
      clouds:
        openstack:
          auth:
            auth_url: "${auth_url}"
            username: "${os_service_account_user}"
            password: "${os_service_account_pass}"
            project_id: "${project_id}"
            user_domain_name: "${user_domain_name}"
          region_name: "${region}"
          interface: "public"
          identity_api_version: 3
    owner: root:root
    permissions: '0644'

  - path: /etc/profile.d/thg-env-vars.sh
    content: |
      export AWS_ACCESS_KEY_ID=${aws_access_key_id}
      export AWS_SECRET_ACCESS_KEY=${aws_secret_access_key}
    owner: root:root
    permissions: '0644'