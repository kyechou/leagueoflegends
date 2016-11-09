# League-Of-Legends
Linux: League Of Legends www.leagueoflegends.com install/run wrapper

Tested: Archlinux 08.11.2016 wine-staging 1.9.21

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
- Do steps above for "Fresh LoL install"
- Close running launcher
- Copy/Move your LoL client dir to WINEPREFIX (see conf)
```
# If  WINEPREFIX="$HOME/.local/share/leagueoflegends"
# And LOL_INSTALL_PATH="$WINEPREFIX/drive_c/LoL/"
# Then do:
$ rm -rf $HOME/.local/share/leagueoflegends/drive_c/LoL/
$ mv dir_with_LoL_client/ $HOME/.local/share/leagueoflegends/drive_c/$RANDOM/
$ leagueoflegends
```

# Know problems

### Black Login Screen:
- Workaround - Not found
- Try change random winecfg settings until it's fixed (example try run with virtualdesktop), after return settings to default, all must works good , if someone know simple solution let me know.

### Network lags:
- Connections issue - try set sysctl net.ipv4.tcp_timestamps=0

# P.S.
Under "Launcher" dir, git store binary blobs ~1.5Mb from [LoL SingleFileInstall](http://l3cdn.riotgames.com/Installer/SingleFileInstall/LeagueOfLegendsBaseEUW.exe)
It's needed for fast/easy setup fresh LoL client.
