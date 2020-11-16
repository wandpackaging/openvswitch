#!/bin/bash

set -euo pipefail

git clone --recurse-submodules https://salsa.debian.org/openstack-team/third-party/libisal.git -b debian/2.20.0-1 src
