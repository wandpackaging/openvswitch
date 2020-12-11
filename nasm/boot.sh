#!/bin/bash

set -euo pipefail

git clone --recurse-submodules https://salsa.debian.org/debian/nasm -b 2.15.05-1 src

debhelper_version=$(dpkg-query --showformat='${Version}' --show debhelper)

if dpkg --compare-versions "${debhelper_version}" lt 13; then
    sed -i 's/debhelper-compat (= 13)/debhelper (>= 10)/' src/debian/control
    echo "10" > src/debian/compat
fi
