# League of Legends

[League of Legends](https://www.leagueoflegends.com) helper script for installing and
running on Linux.


## Dependencies

The following dependencies are included in the AUR package and the generated
`.deb` package. If there's anything incorrect or missing, pull requests are
appreciated.

- [wine-lol](https://github.com/M-Reimer/wine-lol)
    ([AUR](https://aur.archlinux.org/packages/wine-lol))
- winetricks
- bash
- curl
- openssl
- samba
- mesa-utils
- lib32-gnutls
- lib32-libldap
- lib32-openal
- lib32-libpulse
- lib32-alsa-lib
- lib32-mpg123
- lib32-unixodbc
- lib32-vkd3d
- vulkan-icd-loader, lib32-vulkan-icd-loader
- [Vulkan drivers](https://wiki.archlinux.org/title/Vulkan) **for your graphic
  cards**. For example:
    - lib32-vulkan-intel
    - lib32-nvidia-utils (Debian/Ubuntu: libnvidia-glvkspirv:i386 libglx-nvidia0:i386)
    - lib32-vulkan-radeon
    - lib32-amdvlk
- zenity (optional for loading screen indication, see
    [#9](https://github.com/kyechou/leagueoflegends/pull/9))

Note that the above package names are based on Arch Linux. For other
distributions that are not Arch-based, the names will most likely differ.
Please refer to the documentation of your distribution for installing the
correct Vulkan drivers and other dependencies.


## Configuration

There is no configuration file. The game is installed at
`~/.local/share/leagueoflegends/` by default. If you want to change the default
location of the wine prefix or other parameters, please feel free to modify the
script.


## Usage

### Install the LoL helper script

| Distribution  | Installation method                                                                |
|---------------|------------------------------------------------------------------------------------|
| Arch Linux    | AUR: [leagueoflegends-git](https://aur.archlinux.org/packages/leagueoflegends-git) |
| Debian/Ubuntu | `./package.sh debian` <br/> `sudo dpkg -i <deb_file>`                              |
| Others        | Manual installation: `sudo make install`                                           |

### Pre-client-installation checks (Important!)

* Please make sure you have installed the correct Vulkan driver for your
  graphics card that you will be using. You can check what is installed with
  ```
  ls /usr/share/vulkan/icd.d/
  ```

### Install the League client

* First install the game: `leagueoflegends install`.
    * Please do not log in or launch the game during installation.
    * If the installation progress stucks at 100%, close the window, and run
    `leagueoflegends install` again.
        * For more detail, check out [this thread](https://www.reddit.com/r/leagueoflinux/comments/qavc89/install_stuck_on_downloading_100/).
* Exit the window when the game installation is finished. (The progress circle
  disappears.)
* Start the game: `leagueoflegends start`.
* Log in with your Riot credentials and start LoL as usual.
* Once the League client shows up, please try a practice match to make sure
  everything works.
* To remove the game: `leagueoflegends uninstall`.

Note that if you use Nvidia graphics card and have trouble launching the League
client or start the game (after champion selection), please check out [the
troubleshooting section](#blank-screen-with-nvidia-graphics-card).

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
        rm-dxvk-cache       Remove DXVK cache
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
    * This will start Garena. Navigate to LoL and press "Play" from Garena.
* To remove the game: `leagueoflegends uninstall-garena`.
* To also remove the environment from which the game is launched:
  `leagueoflegends uninstall`.


## Advanced wine configuration

`leagueoflegends kill` would use `wineserver --kill` to try to kill all the wine
processes of the current wine prefix, which can be helpful if some error
happens and the script hangs.

`leagueoflegends run <...>` can be use to run any command with the wine-related
environment variables, such as `WINEARCH`, `WINEDLLOVERRIDES`, and `WINEPREFIX`.
This way, you could easily run wine utilities like `leagueoflegends run
winecfg`, or `leagueoflegends run winetricks`, etc.


## Troubleshooting

### Blank screen with Nvidia graphics card

If you use Nvidia graphics card and have trouble launching the League client or
start the game (after champion selection), please exit the game (with
`leagueoflegends kill` or `leagueoflegends kill-garena` if you are running the
Garena version) and then try `leagueoflegends rm-dxvk-cache` before restarting
it. This should only need to be done once to clean up the old cache, since DXVK
caching is currently disabled.
([Reference](https://www.reddit.com/r/leagueoflinux/comments/skyg70/fixing_the_nvidia_495_black_screen_crash_problem/))

If the issue still remains, you may want to purge and reinstall the Nvidia
related packages as described
[here](https://www.reddit.com/r/leagueoflinux/comments/r0oo0p/i_got_league_working_again_on_my_nvidia_drivers/).

Alternatively, as a quick (and dirty) workaround, remove the `nvidia` package
and install `nvidia-dkms` instead. Remember to also install the kernel headers
packages according to your kernel (e.g., `linux-headers`). Then reboot and
reinstall LoL.
