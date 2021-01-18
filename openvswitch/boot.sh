#!/bin/bash

set -euo pipefail

git clone --recurse-submodules https://github.com/openvswitch/ovs -b v2.14.1 src

# ovs won't build from a git checkout
rm -rf ./src/.git

# use debian packaging from debian
git clone --recurse-submodules https://salsa.debian.org/openstack-team/third-party/openvswitch -b debian/2.13.0+dfsg1-16 debian_openvswitch_2.13
git clone --recurse-submodules https://salsa.debian.org/openstack-team/third-party/openvswitch -b debian/2.15.0_git20210104.def6eb1ea+dfsg1-4 debian_openvswitch_2.15
rm -rf ./src/debian
mv ./debian_openvswitch_2.13/debian/ ./src/

# need to backport patches from 2.15
mv ./debian_openvswitch_2.15/debian/patches/py3-compat.patch ./src/debian/patches/
mv ./debian_openvswitch_2.15/debian/patches/remove-include-debian-automake.mk.patch ./src/debian/patches/

# cleanup
rm -rf ./debian_openvswitch*/

# update changelog
(cd src || exit ; debchange --newversion 2.14.1 -b "New upstream release")
