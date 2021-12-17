# League of Legends

League of Legends (www.leagueoflegends.com) helper script for installing and
running on Linux.


## Dependencies

- [wine-lol](https://aur.archlinux.org/packages/wine-lol/) (>= 5.18)
- winetricks
- bash
- curl
- openssl
- samba
- lib32-gnutls
- lib32-libldap
- lib32-openal
- lib32-libpulse
- lib32-alsa-lib
- lib32-unixodbc
- lib32-vkd3d
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

Use the following commands to build and install the `.deb` package.

```sh
./package.sh debian
sudo dpkg -i <package name>.deb
```

### Manual installation from source

You can also install the helper script manually by:

```sh
$ git clone https://github.com/kyechou/leagueoflegends.git
$ cd leagueoflegends
$ sudo make install
```


## Configuration

The configuration file is removed for simplicity. The game is installed at
`~/.local/share/leagueoflegends/` by default. If you want to change the default
location of the wine prefix or other parameters, please feel free to modify the
script.


## Usage

* First install the game: `leagueoflegends install`.
    * (Note) Please do not log in or launch the game during installation.
* Exit the window when the game installation is finished.
* Start the game: `leagueoflegends start`.
    * (Note) It may take a while (1-2 minutes) before the game shows up, due to
      this [issue](https://www.reddit.com/r/leagueoflinux/comments/j07yrg/starting_the_client_script/).
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
        start-garena        Start Garena
        install-garena      Install Garena
        uninstall-garena    Uninstall Garena
        reinstall-garena    Reinstall Garena
        add-dxvk            Install DXVK to the LoL wineprefix
        del-dxvk            Remove DXVK from the LoL wineprefix
        cleanup-logs        Remove log files
        kill                Kill the wine processes of the wineprefix
        kill-garena         Kill the Garena wine processes
        run <cmd>           Run shell command with environment variables
        run-garena <cmd>    Run shell command with environment variables
```

### Setting up Garena (Southeast Asia)

* First install Garena: `leagueoflegends install-garena`
    * Choose the region when prompted.
    * There are two wine prefixes (environments) involved in this setup. Both
      Garena and LoL will be installed in `~/.local/share/garena/`. However,
      the game will be launched from the other prefix,
      `~/.local/share/leagueoflegends/`.
    * It's recommended to not change the default location of Garena, which is
      `C:\Program Files\Garena\Garena\`. If you do want to change the default
      location, remember to also change it in the script.
    * Once Garena is successfully installed, it will be automatically started.
      Please log in and go ahead to install LoL from Garena.
    * LoL will by default be installed at `Z:\Garena\Games\`, which is in most
      cases not desirable. Please change it to `C:\Program Files\Garena\Games\`,
      or any other location you desire as long as it is consistent with the
      script variables.
* Exit the Garena window when the game installation is finished.
* Kill the Garena process to finish installation: `leagueoflegends kill-garena`.
    * Because the process will only be minimized to system tray upon exit.
* Start the game: `leagueoflegends start-garena`.
    * **[Note]** If the Garena client shows a black screen after logging in,
      try removing the `libEGL.dll` files with `find
      ~/.local/share/garena/drive_c/Program\ Files/Garena -type f -name
      '*libEGL.dll' -exec rm {} \;`, and then restart the game.
    * This will start Garena. Navigate to LoL and press "Play" from Garena.
    * The game will not really start, but the script will remember the
      command-line arguments needed to launch the game, and then respawn a new
      game by invoking the Riot client directly with the arguments.
      For more information, please refer to the script and the related Reddit
      threads documented inside.
    * Similarly, it may take a while (1-2 minutes) before the game shows up,
      due to this [issue](https://www.reddit.com/r/leagueoflinux/comments/j07yrg/starting_the_client_script/).
* To remove the game: `leagueoflegends uninstall-garena`.
* To also remove the environment from which the game is launched:
  `leagueoflegends uninstall`.

### Advanced wine configuration

`leagueoflegends kill` would use `wineserver --kill` to try to kill all the wine
processes of the current wine prefix, which might be helpful if some error
happens and the script hangs.

`leagueoflegends run <...>` can be use to run any command with the wine-related
environment variables, such as `WINEARCH`, `WINEDLLOVERRIDES`, and `WINEPREFIX`.
This way, you could easily run wine utilities like `leagueoflegends run
winecfg`, or `leagueoflegends run wineserver --kill`, etc.
