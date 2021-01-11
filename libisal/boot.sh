#!/bin/bash

set -euo pipefail

git clone --recurse-submodules https://salsa.debian.org/openstack-team/third-party/libisal.git -b debian/2.29.0-2 src

debhelper_version=$(dpkg-query --showformat='${Version}' --show debhelper)

if dpkg --compare-versions "${debhelper_version}" lt 12; then
    sed -i 's/debhelper-compat (= 12)/debhelper (>= 10)/' src/debian/control
    echo "10" > src/debian/compat
fi
