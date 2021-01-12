#!/bin/bash

set -euo pipefail

git clone --recurse-submodules git://git.launchpad.net/~ubuntu-server-dev/ubuntu/+source/openvswitch -b debian/2.14.0-0ubuntu2 src
