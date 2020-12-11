git clone --recurse-submodules https://github.com/sudipm-mukherjee/libbpf -b debian/0.2-1 src

if ${BUILD_TARGET} == "ubuntu:xenial"; then
    sed -i 's/DEB_BUILD_MAINT_OPTIONS = hardening=+all/DEB_BUILD_MAINT_OPTIONS =/' src/debian/rules
fi

debhelper_version=$(dpkg-query --showformat='${Version}' --show debhelper)

if dpkg --compare-versions "${debhelper_version}" lt 13; then
    sed -i 's/debhelper-compat (= 13)/debhelper (>= 10)/' src/debian/control
    echo "10" > src/debian/compat
fi
