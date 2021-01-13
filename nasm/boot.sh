#!/bin/bash

set -euo pipefail

git clone --recurse-submodules https://salsa.debian.org/debian/nasm -b debian/2.14.02-1 src

apt-get install -y asciidoc

sed -i 's/$(MAKE) doc/$(MAKE) doc manpages/' src/debian/rules

if ! dpkg-query -W fonts-liberation2; then
    sed -i 's/fonts-liberation2/fonts-liberation/' src/debian/control
fi
