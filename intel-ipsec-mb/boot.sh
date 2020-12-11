#!/bin/bash

set -euo pipefail

curl -L -O http://deb.debian.org/debian/pool/main/i/intel-ipsec-mb/intel-ipsec-mb_0.55-1.dsc
curl -L -O http://deb.debian.org/debian/pool/main/i/intel-ipsec-mb/intel-ipsec-mb_0.55.orig.tar.xz
curl -L -O http://deb.debian.org/debian/pool/main/i/intel-ipsec-mb/intel-ipsec-mb_0.55-1.debian.tar.xz

dpkg-source --require-valid-signature -x intel-ipsec-mb_0.55-1.dsc src

debhelper_version=$(dpkg-query --showformat='${Version}' --show debhelper)

if dpkg --compare-versions "${debhelper_version}" lt 13; then
    sed -i 's/debhelper (>= 13)/debhelper (>= 10)/' src/debian/control
    sed -i '/debhelper-compat (=13),/d' src/debian/control
    echo "10" > src/debian/compat
fi
