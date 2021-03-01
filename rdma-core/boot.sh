#!/bin/bash

set -euo pipefail

git clone --recurse-submodules https://github.com/linux-rdma/rdma-core -b v32.0 src

if [ "${BUILD_TARGET}" == "ubuntu:xenial" ]; then
    sed -zi 's/install(FILES "mlx4.conf" DESTINATION "${CMAKE_INSTALL_SYSCONFDIR}\/modprobe.d\/")\n//' src/providers/mlx4/CMakeLists.txt
    sed -zi 's/etc\/modprobe.d\/mlx4.conf\n//' src/debian/rdma-core.install
fi
