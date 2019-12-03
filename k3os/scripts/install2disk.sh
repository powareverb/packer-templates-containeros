#!/bin/bash
set -e -x

check_version() {
    if [ -z "$K3OS_VERSION" ]; then
        echo "K3OS_VERSION must be set"
        exit 1
    fi
}

#PACKER_BUILDER_TYPE=${PACKER_BUILDER_TYPE:?"PACKER_BUILDER_TYPE is not set"}
set PACKER_BUILDER_TYPE=k3os
set PACKER_BUILD_NAME=k3os

echo "type: $PACKER_BUILDER_TYPE"
echo "name: $PACKER_BUILD_NAME"
env
echo "----------------------------------------"

case ${PACKER_BUILD_NAME} in

    "k3os")
        echo "Installing k3os"
        cat >cloud-config.yml<<EOF
ssh_authorized_keys:
- ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAqTKCokee2XPlggoWBkc+IH6CRcLGZ722T8UKPBwR8GuaKoS4QMDKmTwPQhIuSj4vLlQKU7trvgJAXi/fRBo1C4Ija8eoKpBce9C3ofcHWVvqkhsDqM+qe/8+dJih9MZfNTiDRstMaQjIDUHTI7+v92OKnkMDGHc9T48pbZBxJikKULBWvfiYKImXTRvdig7kN9/1GCwPOC1SwmMsn8j22VbRJqAIMtc7Yf4jhqO3NFFpmGF1cgikVSEubOCUEFvJQjSM1NV+ikOoc6Tx7Ycnt6wfgLLeJleMU8YwCU/SKYt1qDfxv+v16NgpoSxnOQiPoW+KynWrFnQf78ShsjTd+Q== c6:86:74:6c:5a:54:ef:a5:44:3f:3f:ad:e2:49:c2:2f rsa-key-20150424
- github:powareverb
write_files:
- encoding: ""
  content: |-
    #!/bin/bash
    echo hi
  owner: root
  path: /etc/rc.local
  permissions: '0755'
hostname: k3os-base

k3os:
  data_sources:
  - cdrom
  modules:
  - kvm
  - nvme
  # HyperV
  - hv_storvsc
  sysctl:
    kernel.printk: 4 4 1 7
    kernel.kptr_restrict: 1
  dns_nameservers:
  - 8.8.8.8
  - 1.1.1.1
  ntp_servers:
  - 0.nz.pool.ntp.org
  - 1.nz.pool.ntp.org
#  password: rancher
# If an agent
#  server_url: https://someserver:6443
#  token: TOKEN_VALUE
  labels:
    region: nz-ni-wkto
    basedomain: pd-net-nz
  k3s_args:
  - server
  #- "--disable-agent"
  environment:
      basedomain: pd.net.nz
  #   http_proxy: http://myserver
  #   https_proxy: http://myserver
  # taints:
  # - key1=value1:NoSchedule
  # - key1=value1:NoExecute
EOF
        check_version
        #sudo k3os install
        exit 0
        ;;

esac

# case ${PACKER_BUILDER_TYPE} in

#     "virtualbox-iso")
#         cat >vagrant.yml<<EOF
# #cloud-config
# ssh_authorized_keys:
#   - ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
# EOF
#         sudo ros install -d /dev/sda -f -c ./vagrant.yml --no-reboot
#         ;;

#         echo "Unknown type" 1>&2
#         exit 1
#         ;;
# esac
