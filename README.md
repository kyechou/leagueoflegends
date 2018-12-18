# League of Legends

League of Legends (www.leagueoflegends.com) helper script for installing and
running the game on Linux.

This tool is based on both [this
guide](https://www.reddit.com/r/leagueoflinux/comments/5ukgur/a_revised_guide_for_installing_league_of_legends)
and the [Lutris script](https://lutris.net/games/install/3552/view), and tested
with wine-3.21 and wine-3.21-staging.

## Installation

You can install the helper script manually by:

```
$ git clone https://github.com/Nefelim4ag/League-Of-Legends.git
$ cd League-Of-Legends
# make install
```

Otherwise, you can install the script as a package. Pull requests for other
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

