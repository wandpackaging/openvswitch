#!/bin/bash

set -euo pipefail

git clone --recurse-submodules https://salsa.debian.org/crosstoolchain-team/device-tree-compiler -b debian/1.4.4-1 src
