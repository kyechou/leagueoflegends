#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(dirname $(realpath ${BASH_SOURCE[0]}))"

msg() {
    echo -e "[+] ${1-}" >&2
}

die() {
    echo -e "[!] ${1-}" >&2
    exit 1
}

debian_package(){
    cd "$SCRIPT_DIR"

    pkgname="leagueoflegends"
    pkgver="$(git describe --tags --long 2>/dev/null | awk -F- '{print $1}' \
              | sed -e 's/^v//')"
    [ -z "$pkgver" ] && die "Version not found"

    debname="${pkgname}-${pkgver}_any"
    mkdir -p "$debname/DEBIAN"

    make DESTDIR="$debname/" install

    cat >"$debname/DEBIAN/control" <<EOF
Package: $pkgname
Version: $pkgver
Section: custom
Priority: optional
Architecture: all
Essential: no
Installed-Size: 200
Maintainer: kuanyenchou@gmail.com
Description: League of Legends helper script
EOF

    dpkg-deb --build "$debname"
}

archlinux_package(){
    cd "$SCRIPT_DIR"
    git clone https://aur.archlinux.org/leagueoflegends-git.git aurpkg
    cd aurpkg
    makepkg -srcf
}

case $1 in
    debian) debian_package ;;
    archlinux) archlinux_package ;;
    *) die "Usage: $(basename "${BASH_SOURCE[0]}") (debian|archlinux)" ;;
esac
