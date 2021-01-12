#!/bin/bash

set -euo pipefail

git clone --recurse-submodules https://salsa.debian.org/debian/dpdk.git -b debian/19.11.6-1 src

sed -i 's/debhelper (>= 10.3~)/debhelper (>= 10)/' src/debian/control
