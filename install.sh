#!/bin/bash
################################################################################
# echo wrappers
INFO(){ echo -n "INFO: "; echo "$@" ;}
WARN(){ echo -n "WARN: "; echo "$@" ;}
ERRO(){ echo -n "ERRO: "; echo -n "$@" ; echo " Abort!"; exit 1;}

PREFIX="/"
case $1 in
    PREFIX=*) PREFIX="${1//PREFIX=/}";;
esac

cd "$(dirname "$0")" || exit 1
if [ "$PREFIX" == "/" ]; then
    if [ "$UID" != "0" ]; then
        command -v sudo &> /dev/null || ERRO "Run by root or install sudo!"
        SUDO=sudo
    else
        unset SUDO
    fi
fi

unix2dos(){ sed $'s/$/\r/'; }

gen_locale_cfg(){
    {
        echo locale = en_gb
    } | unix2dos
}

gen_system_cfg(){
    {
        echo DownloadPath = /releases/live
        echo DownloadURL = l3cdn.riotgames.com
        echo Region = EUW
    } | unix2dos
}

gen_launcher_cfg(){
    {
        echo airConfigProject = lol_air_client_config_euw
        echo airProject = lol_air_client
        echo gameProject = lol_game_client_sln
    } | unix2dos
}

$SUDO install -Dm644 ./leagueoflegends.conf     "$PREFIX/etc/leagueoflegends.conf"
$SUDO install -Dm755 ./leagueoflegends          "$PREFIX/usr/bin/leagueoflegends"
$SUDO install -Dm644 ./leagueoflegends.png      "$PREFIX/usr/share/icons/hicolor/256x256/apps/leagueoflegends.png"
$SUDO install -Dm644 ./leagueoflegends.desktop  "$PREFIX/usr/share/applications/leagueoflegends.desktop"

# Install Tiny Launcher
URL_LAUNCHER="https://github.com/Nefelim4ag/League-Of-Legends/raw/master/Launcher/lol.launcher.exe"
URL_RADS="http://l3cdn.riotgames.com/releases/live/system/rads_user_kernel.exe"

$SUDO mkdir -p "$PREFIX/opt/leagueoflegends/RADS/system/"
$SUDO wget -nv "$URL_LAUNCHER" -O "$PREFIX/opt/leagueoflegends/lol.launcher.exe"
$SUDO wget -nv "$URL_RADS" -O "$PREFIX/opt/leagueoflegends/RADS/system/rads_user_kernel.exe"
gen_locale_cfg   | $SUDO tee "$PREFIX/opt/leagueoflegends/RADS/system/locale.cfg"   > /dev/null
gen_system_cfg   | $SUDO tee "$PREFIX/opt/leagueoflegends/RADS/system/system.cfg"   > /dev/null
gen_launcher_cfg | $SUDO tee "$PREFIX/opt/leagueoflegends/RADS/system/launcher.cfg" > /dev/null
