#!/bin/bash -xe
source /etc/profile.d/thg-env-vars.sh

#Clear /tmp out
rm -rf /tmp/*

#Install pip, ansible & requirements
yum update -y
curl -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o /tmp/jq
mv /tmp/jq /usr/bin
chmod +x /usr/bin/jq

META=$(curl -s http://169.254.169.254/openstack/2018-08-27/meta_data.json | jq -r '.meta')
PIP_VERSION=$(echo $META | jq -r '.pip')
DEPENDENCIES=$(echo $META | jq -rj '.dependencies' | jq -j 'keys_unsorted[] as $k | "\($k)==\(.[$k]) "')
INFRA_BUILD_NUMBER=$(echo $META | jq -rj '.infra_version')
PLAYBOOK_DIR=$(echo $META | jq -rj '.playbook_dir')
PLAYBOOK=$(echo $META | jq -rj '.playbook')
ENV_VARS=$(echo $META | jq -rj '.env_vars_file')

curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
python3 /tmp/get-pip.py "pip==$PIP_VERSION"
pip3 install --ignore-installed --upgrade $DEPENDENCIES

cd /tmp
curl -LJO -H "Authorization: token $GITHUB_API_TOKEN" "https://github.com/foamdino/cilium-on-openstack/archive/v$INFRA_BUILD_NUMBER.tar.gz"
tar -zxvf /tmp/cilium-on-openstack-$INFRA_BUILD_NUMBER.tgz

cd "/tmp/cilium-on-openstack-$INFRA_BUILD_NUMBER/ansible/playbooks/$PLAYBOOK_DIR"
ansible-playbook $PLAYBOOK -i /tmp/cilium-on-openstack-$INFRA_BUILD_NUMBER/ansible/inventories/openstack.yaml \
  --extra-vars="@/tmp/cilium-on-openstack-$INFRA_BUILD_NUMBER/ansible/environment_vars/$ENV_VARS"