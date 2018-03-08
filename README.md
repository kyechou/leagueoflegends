# League-Of-Legends
Linux: League Of Legends www.leagueoflegends.com install/run wrapper

Tested: Archlinux 08.03.2018 wine 3.3

Based on [guide](https://www.reddit.com/r/leagueoflinux/comments/5ukgur/a_revised_guide_for_installing_league_of_legends)

# Instructions
### Script install
You can install stuff manualy by:
```
$ git clone https://github.com/Nefelim4ag/League-Of-Legends.git /tmp/LoL
# /tmp/LoL/install.sh
```
*   ![logo](http://www.monitorix.org/imgs/archlinux.png "arch logo") Arch: [AUR/leagueoflegends-git](https://aur.archlinux.org/packages/leagueoflegends-git).
*   Debian/Ubuntu: use [package.sh](https://raw.githubusercontent.com/Nefelim4ag/League-Of-Legends/master/package.sh) in repo

```
$ git clone https://github.com/Nefelim4ag/League-Of-Legends.git /tmp/LoL
$ /tmp/LoL/package.sh debian
# dpkg -i /tmp/LoL/leagueoflegends-*.deb
```

### Fresh LoL install
-   Install scripts by make or package.sh
-   Change config if you need /etc/leagueoflegends.conf or/and ~/.config/leagueoflegends.conf
-   Run "leagueoflegends" in console or run desktop application "League of Legends"

### Move LoL from another wine
-   Install scripts by make or package.sh
-   Change config if you need /etc/leagueoflegends.conf
-   Then:

In default configuration:
```
$ leagueoflegends make_wineprefix
$ mv <Directory with LeagueClient.exe>/ $HOME/.local/share/leagueoflegends/LOL/CLIENT/
$ leagueoflegends launcher
```
-   Run "leagueoflegends" in console or run desktop application "League of Legends"

# Know problems

### Black Login Screen:
-   Workaround - Not found
-   Try to change random winecfg settings until it's fixed (example try to run with virtualdesktop), then return settings to default, it should work, if someone knows simple solution just let me know.

### Network lags:
-   Connections issue - try set sysctl net.ipv4.tcp_timestamps=0

### Beta Client Don't work!
Works, but:
https://github.com/Nefelim4ag/League-Of-Legends/issues/8

### Bug splat during patching phase
https://github.com/Nefelim4ag/League-Of-Legends/issues/9 try:
```
leagueoflegends regen_wine_prefix
```

# P.S.
I don't use original install.exe, because it sucks. I did own way for fast and easy setup of LoL client.

Tiny installation stuff:
```
RADS/system/locale.cfg     - Launcher localisation
RADS/system/system.cfg   - Path and region for download full launcher
RADS/system/launcher.cfg - Internal launcher configuration
RADS/system/rads_user_kernel.exe - Riot Application Distribution System
```
**All configs hardcoded for Western Europe.**

You don't need change anything,
because launcher will always download
**ALL STUFF FOR ALL REGIONS (~150Mb)**,
so just wait for launcher UI and then change region and language.

-   Tiny install regenerated from configs in script code + client for RADS
-   [RADS](http://l3cdn.riotgames.com/releases/live/system/rads_user_kernel.exe)
