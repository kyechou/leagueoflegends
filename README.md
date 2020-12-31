# League of Legends

League of Legends (www.leagueoflegends.com) helper script for installing and
running on Linux.


## Dependencies

- wine-lol (please see **Note**)
- winetricks
- bash
- curl
- lib32-gnutls
- lib32-libldap
- lib32-openal
- lib32-libpulse
- vulkan-icd-loader, lib32-vulkan-icd-loader
- [Vulkan drivers](https://wiki.archlinux.org/index.php/Vulkan) for your graphic
  cards. For example:
    - lib32-vulkan-intel
    - lib32-nvidia-utils
    - lib32-vulkan-radeon
    - lib32-amdvlk

**Note**

The current version of WINE does not support the game because of some anticheat
mechanism. Game crashes while entering the main game after champion selection
([bug 47198](https://bugs.winehq.org/show_bug.cgi?id=47198)).
To circumvent the issue, some patches are needed for WINE to successfully run
the game. Please use [wine-lol](https://aur.archlinux.org/packages/wine-lol/)
instead of wine or wine-staging.


## Installation

### Arch Linux

Install the package from AUR: [leagueoflegends-git](https://aur.archlinux.org/packages/leagueoflegends-git).

### Debian/Ubuntu

You could use `make deb` to create the `.deb` package, and then install it with
the following command.

```sh
sudo dpkg -i leagueoflegends.deb
```

Note that the generated debian package does not have the dependency information,
so please first install the required packages.

### Manual installation from source

You can install the helper script manually by:

```sh
$ git clone https://github.com/kyechou/leagueoflegends.git
$ cd leagueoflegends
$ sudo make install
```

The files are installed to `/usr` by default, or you can optionally set
`DESTDIR` to install the files to `$(DESTDIR)/usr`.

```sh
$ sudo make DESTDIR="<preferred root>" install
```


## Configuration

The configuration file is removed for simplicity. If you would like to change
the default location of wine prefix or other parameters, feel free to modify the
script.


## Usage

```
[!] Usage: leagueoflegends <command>

League of Legends - helper program

Commands:
    start               - Start LoL
    install             - Install LoL
    uninstall           - Uninstall LoL
    reinstall           - Reinstall LoL
    cleanup_logs        - Remove log files
    kill                - Kill the wine processes of the wineprefix
    run <shell comamnd> - Run shell command with environment variables
                          (useful for wine utilities)
```

The usage should be intuitive. You firstly would need `leagueoflegends
install` to construct the wine environment and install the client. **Note** that
while the client is being installed, please do *NOT* log in or launch the game.
After the client is installed successfully, you could use `leagueoflegends
start` to launch the game. It may take a little while before the splash screen
shows up, due to this
[issue](https://www.reddit.com/r/leagueoflinux/comments/j07yrg/starting_the_client_script/).

### Advanced wine configuration

`leagueoflegends kill` would use `wineserver --kill` to try to kill all the wine
processes of the current wine prefix, which might be helpful if some error
happens and the script hangs.

`leagueoflegends run <...>` can be use to run any command with the wine-related
environment variables, such as `WINEARCH`, `WINEDLLOVERRIDES`, and `WINEPREFIX`.
This way, you could easily run wine utilities like `leagueoflegends run
winecfg`, or `leagueoflegends run wineserver --kill`, etc.
