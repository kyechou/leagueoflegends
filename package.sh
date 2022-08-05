#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

msg() {
    echo -e "[+] ${1-}" >&2
}

die() {
    echo -e "[!] ${1-}" >&2
    exit 1
}

arch_pkg() {
    cd "$SCRIPT_DIR"
    git clone https://aur.archlinux.org/leagueoflegends-git.git aur
    pushd aur
    makepkg -srcf   # This should build both packages
    mv leagueoflegends-*.pkg.tar.* ../
    popd
}

debian_pkg() {
    cd "$SCRIPT_DIR"

    # Build the one with wine-lol
    pkgname="leagueoflegends"
    pkgver="$(git describe --tags --long 2>/dev/null | awk -F- '{print $1}' | sed -e 's/^v//')"
    [ -z "$pkgver" ] && die "Version not found"
    debname="${pkgname}_${pkgver}_any"
    mkdir -p "$debname/DEBIAN"

    make DESTDIR="$debname" install
    pushd "$debname"
    find ./* -type f ! -path 'DEBIAN/*' -exec md5sum '{}' \; > "DEBIAN/md5sums"
    popd
    SIZE="$(du "$debname" --exclude '*/DEBIAN/*' -s | cut -f 1)"
    cat >"$debname/DEBIAN/control" <<EOF
Package: $pkgname
Version: $pkgver
Architecture: all
Maintainer: Kuan-Yen Chou <kuanyenchou@gmail.com>
Installed-Size: $SIZE
Depends: wine-lol:i386, winetricks, bash, curl, openssl, winbind, mesa-utils, libgnutls30, libldap-2.4-2, libopenal1, libpulse0, libasound2, libmpg123-0, libodbc1, libvkd3d1, libvulkan1, mesa-vulkan-drivers
Suggests: zenity
Priority: optional
Homepage: https://github.com/kyechou/leagueoflegends
Description: League of Legends helper script
EOF
    dpkg-deb --root-owner-group --build "$debname"
}

usage() {
    cat <<EOF
[!] Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] <distro>
    Distro: all arch debian
EOF
}

main() {
    while :; do
        case "${1-}" in
        -h | --help) usage; exit ;;
        -v | --verbose) set -x ;;
        --) shift; break ;;
        -?*) die "Unknown option: ${1-}\n$(usage)" ;;
        *) break ;;
        esac
        shift
    done

    case "${1-}" in
        all) arch_pkg; debian_pkg ;;
        arch) arch_pkg ;;
        debian) debian_pkg ;;
        *) die "Unknown distro: ${1-}\n$(usage)" ;;
    esac
}


main "$@"

# vim: set ts=4 sw=4 et:
