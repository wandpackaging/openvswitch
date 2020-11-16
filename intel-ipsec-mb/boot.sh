#!/bin/bash

set -euo pipefail

curl -fLO https://deb.debian.org/debian/pool/main/i/intel-ipsec-mb/intel-ipsec-mb_0.55-1.dsc
curl -fLO https://deb.debian.org/debian/pool/main/i/intel-ipsec-mb/intel-ipsec-mb_0.55.orig.tar.xz
curl -fLO https://deb.debian.org/debian/pool/main/i/intel-ipsec-mb/intel-ipsec-mb_0.55-1.debian.tar.xz

dpkg-source --require-valid-signature -x intel-ipsec-mb_0.55-1.dsc src

debhelper_version=$(dpkg-query --showformat='${Version}' --show debhelper)

if dpkg --compare-versions "${debhelper_version}" lt 13; then
    sed -i 's/debhelper (>= 13)/debhelper (>= 11)/' src/debian/control
    sed -i '/debhelper-compat (=13),/d' src/debian/control
    echo '11' > src/debian/compat
fi
