#!/bin/bash

set -euo pipefail

git clone --recurse-submodules https://salsa.debian.org/debian/nasm -b debian/2.14.02-1 src

apt-get install -y asciidoc

sed -i 's/$(MAKE) doc/$(MAKE) doc manpages/' src/debian/rules

debhelper_version=$(dpkg-query --showformat='${Version}' --show debhelper)

if dpkg --compare-versions "${debhelper_version}" lt 12; then
    sed -i 's/fonts-liberation2/fonts-liberation/' src/debian/control
    sed -i 's/debhelper (>= 12)/debhelper (>= 10)/' src/debian/control
    echo "10" > src/debian/compat
fi

if ! dpkg-query -W fonts-liberation2; then
    sed -i 's/fonts-liberation2/fonts-liberation/' src/debian/control
fi
