#!/bin/bash

set -euo pipefail

curl -L -O https://deb.debian.org/debian/pool/main/m/meson/meson_0.49.2-1.dsc
curl -L -O https://deb.debian.org/debian/pool/main/m/meson/meson_0.49.2.orig.tar.gz
curl -L -O http://deb.debian.org/debian/pool/main/m/meson/meson_0.49.2-1.debian.tar.xz

dpkg-source --require-valid-signature -x meson_0.49.2-1.dsc src

debhelper_version=$(dpkg-query --showformat='${Version}' --show debhelper)

if dpkg --compare-versions "${debhelper_version}" lt 11; then
    sed -i 's/debhelper (>= 11)/debhelper (>= 10)/' src/debian/control
    echo "10" > src/debian/compat
fi
