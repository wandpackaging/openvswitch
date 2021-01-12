#!/bin/bash

set -euo pipefail

git clone --recurse-submodules https://github.com/sudipm-mukherjee/libbpf -b debian/0.2-1 src

if [ "${BUILD_TARGET}" == "ubuntu:xenial" ]; then
    sed -i 's/DEB_BUILD_MAINT_OPTIONS = hardening=+all/DEB_BUILD_MAINT_OPTIONS =/' src/debian/rules
fi

if [ "${BUILD_TARGET}" == "ubuntu:xenial" ] || [ "${BUILD_TARGET}" == "debian:stretch" ]; then
    apt-get -y install zlib1g-dev
fi

debhelper_version=$(dpkg-query --showformat='${Version}' --show debhelper)

if dpkg --compare-versions "${debhelper_version}" lt 13; then
    sed -i 's/debhelper-compat (= 13)/debhelper-compat (= 12)/' src/debian/control
fi
