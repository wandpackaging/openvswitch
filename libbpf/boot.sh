git clone --recurse-submodules https://github.com/sudipm-mukherjee/libbpf -b debian/0.2-1 src
env
sed -i 's/debhelper-compat (= 13)/debhelper (>= 10)/' src/debian/control
echo "10" > src/debian/compat
