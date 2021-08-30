# League of Legends

League of Legends (www.leagueoflegends.com) helper script for installing and
running on Linux.


## Dependencies

- [wine-lol](https://aur.archlinux.org/packages/wine-lol/) (>= 5.18)
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
- zenity (optional for loading screen indication, see [#9](https://github.com/kyechou/leagueoflegends/pull/9))


## Installation

### Arch Linux

Install the package from AUR: [leagueoflegends-git](https://aur.archlinux.org/packages/leagueoflegends-git).

### Debian/Ubuntu

You could use `make deb` to create the `.deb` package, and then install it with
the following command.

```sh
sudo dpkg -i <package name>.deb
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
$ sudo make DESTDIR="..." install
```


## Configuration

The configuration file is removed for simplicity. If you would like to change
the default location of wine prefix or other parameters, please feel free to
modify the script.


## Usage

* First install the game: `leagueoflegends install`.
    * (Note) Please do not log in or launch the game during installation.
* Exit the window when the game installation is finished.
* Start the game: `leagueoflegends start`.
    * (Note) It may take a while before the game shows up, due to this [issue](https://www.reddit.com/r/leagueoflinux/comments/j07yrg/starting_the_client_script/).
* To remove the game: `leagueoflegends uninstall`.

`leagueoflegends -h` can be used to view the full list of options and commands.

```
[!] Usage: leagueoflegends [options] <command>

    League of Legends - helper program

    Options:
        -h, --help          Print this message and exit
        -v, --verbose       Enable verbose output

    Commands:
        start               Start LoL
        install             Install LoL
        uninstall           Uninstall LoL
        reinstall           Reinstall LoL
        add-dxvk            Install DXVK to the LoL wineprefix
        del-dxvk            Remove DXVK from the LoL wineprefix
        cleanup_logs        Remove log files
        kill                Kill the wine processes of the wineprefix
        run <shell comamnd> Run shell command with environment variables
                            (useful for wine utilities)
```

### Advanced wine configuration

`leagueoflegends kill` would use `wineserver --kill` to try to kill all the wine
processes of the current wine prefix, which might be helpful if some error
happens and the script hangs.

`leagueoflegends run <...>` can be use to run any command with the wine-related
environment variables, such as `WINEARCH`, `WINEDLLOVERRIDES`, and `WINEPREFIX`.
This way, you could easily run wine utilities like `leagueoflegends run
winecfg`, or `leagueoflegends run wineserver --kill`, etc.
