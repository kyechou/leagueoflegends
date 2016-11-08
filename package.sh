#!/bin/bash -e
################################################################################
# echo wrappers
INFO(){ echo -n "INFO: "; echo "$@" ;}
WARN(){ echo -n "WARN: "; echo "$@" ;}
ERRO(){ echo -n "ERRO: "; echo -n "$@" ; echo " Abort!"; exit 1;}

debian_package(){
    cd "$(dirname "$0")"
    VERSION=$(git tag | tail -n 1)
    [ -z "$VERSION" ] && ERRO "Can't get git tag, VERSION are empty!"

    DEB_NAME="leagueoflegends-${VERSION}_any"
    mkdir -p "$DEB_NAME"

    ./install.sh PREFIX="$DEB_NAME/"

    mkdir -p "$DEB_NAME/DEBIAN/"
    {
        echo "Package: leagueoflegends"
        echo "Version: $VERSION"
        echo "Section: custom"
        echo "Priority: optional"
        echo "Architecture: all"
        echo "Essential: no"
        echo "Installed-Size: 16"
        echo "Maintainer: nefelim4ag@gmail.com"
        echo "Description: Linux: League Of Legends www.leagueoflegends.com install/run wrapper"
    } > "$DEB_NAME/DEBIAN/control"
    dpkg-deb --build "$DEB_NAME"
}

archlinux_package(){
    INFO "Use yaourt -S leagueoflegends-git"
}

case $1 in
    debian) debian_package ;;
    archlinux) archlinux_package ;;
    *) echo "$0 <debian|archlinux>" ;;
esac
