#!/bin/bash

set -euo pipefail

git clone --recurse-submodules https://salsa.debian.org/debian/dpdk.git -b debian/20.11.5-1_deb11u1 src

if [ "${BUILD_TARGET}" == "ubuntu:xenial" ]; then
    sed -i 's/DEB_BUILD_MAINT_OPTIONS = hardening=+all/DEB_BUILD_MAINT_OPTIONS =/' src/debian/rules
fi

debhelper_version=$(dpkg-query --showformat='${Version}' --show debhelper)

if dpkg --compare-versions "${debhelper_version}" lt 12; then
    sed -i 's/debhelper-compat (= 12)/debhelper (>= 11)/' src/debian/control
    echo '11' > src/debian/compat
fi
