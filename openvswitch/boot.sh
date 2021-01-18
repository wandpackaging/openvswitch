#!/bin/bash

set -euo pipefail

git clone --recurse-submodules https://salsa.debian.org/openstack-team/third-party/openvswitch -b debian/2.15.0_git20210104.def6eb1ea+dfsg1-4 src

# ovs won't build from a git checkout
rm -rf ./src/.git

debhelper_version=$(dpkg-query --showformat='${Version}' --show debhelper)

if dpkg --compare-versions "${debhelper_version}" lt 12; then
    sed -i 's/debhelper-compat (= 12)/debhelper (>= 11)/' src/debian/control
    echo '11' > src/debian/compat
fi

