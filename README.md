# League of Legends

League of Legends (www.leagueoflegends.com) helper script for installing and
running on Linux.

## Dependencies

- wine (please see **Note**)
- winetricks
- bash
- lib32-gnutls
- lib32-libldap
- lib32-openal
- lib32-libpulse
- wget

**Note**

The current version of WINE does not support the game. Game crashes while
entering the main game after champion selection
([bug 47198](https://bugs.winehq.org/show_bug.cgi?id=47198)).
Until that is resolved, please use
[wine-lol](https://aur.archlinux.org/packages/wine-lol/) instead of wine or
wine-staging.

## Installation

You can install the helper script manually by:

```
$ git clone https://github.com/kyechou/leagueoflegends.git
$ cd leagueoflegends
# make install
```

Alternatively, you can install the script as a package. Pull requests for other
distributions are welcome.

- ![arch logo](http://www.monitorix.org/imgs/archlinux.png) Arch Linux:
  [AUR/leagueoflegends-git](https://aur.archlinux.org/packages/leagueoflegends-git).
- Debian/Ubuntu: use `make deb` to create the package.

## Configuration

The configuration file is located at `/etc/leagueoflegends.conf`. You can copy
the file to `~/.config/`, which will take precedence over the system-wide
configuration file.

All the commented lines in the file are the default configuration. You can
uncomment and change the values as you desire.

## Usage

```
League of Legends - helper program
Usage: leagueoflegends <command>
Commands:
    launch            - Launch LoL
    install           - Install LoL
    uninstall         - Uninstall LoL
    cleanup_logs      - Remove log files
    winecfg           - Run winecfg with WINEPREFIX
    wineserver [...]  - Run wineserver with WINEPREFIX
    winetricks [...]  - Run winetricks with WINEPREFIX
    make_wineprefix   - Create WINEPREFIX only
    regen_wineprefix  - Backup and recreate WINEPREFIX
```

### Fresh LoL install

```
$ leagueoflegends install
```

### Uninstall LoL

Note that this will remove the game files completely.

```
$ leagueoflegends uninstall
```

### Launch LoL

```
$ leagueoflegends launch
```

or you can launch the game from your application menu.

### Relocate old LoL wine instance

```
$ leagueoflegends make_wineprefix
$ mv <Directory with LeagueClient.exe> ~/.local/share/leagueoflegends/LOL/
```

### Advanced wine configurations

If you need to run winecfg, wineserver, or winetricks toward the wine prefix,
you can prefix the command with this script, which will prepare and export the
environment variables needed.

