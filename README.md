# League-Of-Legends
Linux: League Of Legends www.leagueoflegends.com install/run wrapper

Tested: Archlinux 14.11.2016 wine 1.9.23

# Instructions
### Script install
You can install stuff manualy by:
```
$ git clone https://github.com/Nefelim4ag/League-Of-Legends.git /tmp/LoL
# /tmp/LoL/install.sh
```
* ![logo](http://www.monitorix.org/imgs/archlinux.png "arch logo") Arch: [AUR/leagueoflegends-git](https://aur.archlinux.org/packages/leagueoflegends-git).
* Debian/Ubuntu: use [package.sh](https://raw.githubusercontent.com/Nefelim4ag/League-Of-Legends/master/package.sh) in repo

```
$ git clone https://github.com/Nefelim4ag/League-Of-Legends.git /tmp/LoL
$ /tmp/LoL/package.sh debian
# dpkg -i /tmp/LoL/leagueoflegends-*.deb
```

### Fresh LoL install
- Install scripts by install.sh/package.sh
- Change config if you need /etc/leagueoflegends.conf
- Run "leagueoflegends" in console or run desktop application "League of Legends"

### Move LoL from another wine
- Install scripts by install.sh/package.sh
- Change config if you need /etc/leagueoflegends.conf
- Then:

In default configuration:
```
$ leagueoflegends make_wineprefix
$ mv dir_with_lol.launcher.exe/ $HOME/.local/share/leagueoflegends/drive_c/LoL/
$ leagueoflegends launcher
```
- Run "leagueoflegends" in console or run desktop application "League of Legends"

# Know problems

### Black Login Screen:
- Workaround - Not found
- Try to change random winecfg settings until it's fixed (example try to run with virtualdesktop), then return settings to default, it should work, if someone knows simple solution just let me know.

### Network lags:
- Connections issue - try set sysctl net.ipv4.tcp_timestamps=0

### Beta Client Don't work!
Works, but:
https://github.com/Nefelim4ag/League-Of-Legends/issues/8

### Bug splat during patching phase
https://github.com/Nefelim4ag/League-Of-Legends/issues/9 try:
```
leagueoflegends regen_wine_prefix
```

# P.S.
Under "Launcher" dir, git store binary blobs ~1.5Mb from [LoL SingleFileInstall](http://l3cdn.riotgames.com/Installer/SingleFileInstall/LeagueOfLegendsBaseEUW.exe)
It's needed for fast/easy setup fresh LoL client.
