#!/bin/bash

set -euo pipefail

git clone --recurse-submodules https://salsa.debian.org/debian/dpdk.git -b debian/20.11-2 src

if [ "${BUILD_TARGET}" == "ubuntu:xenial" ]; then
    sed -i 's/DEB_BUILD_MAINT_OPTIONS = hardening=+all/DEB_BUILD_MAINT_OPTIONS =/' src/debian/rules
fi
