# League of Legends

[League of Legends](https://www.leagueoflegends.com) helper script for
installing and running on Linux.

> **Note** <br/>
> "Starting April 4, 2023, League will no longer be supported by 32-bit
> operating systems." ([dev
> news](https://www.leagueoflegends.com/en-gb/news/dev/tl-dw-skarner-skins-quick-play-dev-update/))
> However, currently Riot still ships 32-bit binaries, so both 32-bit and 64-bit
> dependencies will be needed until all 32-bit binaries are safely rolled out
> and no longer shipped.


## Installation

Please choose an installation method suitable for your distribution. Remember to
check all dependencies are installed properly if it's installed manually.

| Distribution  | Installation method                                                                |
|---------------|------------------------------------------------------------------------------------|
| Arch Linux    | AUR: [leagueoflegends-git](https://aur.archlinux.org/packages/leagueoflegends-git) |
| Debian/Ubuntu | `./package.sh debian` <br/> `sudo dpkg -i <deb_file>`                              |
| Others        | Manual installation: `sudo make install`                                           |

> **Note** <br/>
> With package installation methods, packages specific to individual GPUs are
> not included in the dependencies, even though we do include the virtual
> packages `vulkan-driver` and `lib32-vulkan-driver` in the AUR package. So
> please be sure to install the packages required by your specific GPUs. For
> example, Debian testing requires libnvidia-glvkspirv and libglx-nvidia0 for
> Nvidia GPUs (see [#41](https://github.com/kyechou/leagueoflegends/issues/41)).


## Dependencies

The following dependencies are included in the AUR package and the generated
`.deb` package. If there's anything incorrect or missing, pull requests are
appreciated.

> **Note** <br/>
> For non-Arch distributions, wine-lol is **not** included in the package
> dependencies because they don't have those packages for now. So please be sure
> to manually install wine-lol by either downloading from [a release of
> wine-ge-custom](https://github.com/GloriousEggroll/wine-ge-custom/releases?q=LoL&expanded=true)
> (which is the same as wine-lol-bin), or from [a release of
> lol-for-linux-installer](https://github.com/polkaulfield/lol-for-linux-installer/releases).
> After downloading the binary release, extract the content to `/opt/wine-lol` or
> `/opt/wine-lol-staging`.

- wine-lol (please refer to the associated links for their differences)
  - Provider: [wine-lol (AUR)](https://aur.archlinux.org/packages/wine-lol)
  - Provider: [wine-lol-bin (AUR)](https://aur.archlinux.org/packages/wine-lol-bin)
  - Provider: [wine-lol-staging (AUR)](https://aur.archlinux.org/packages/wine-lol-staging)
  - Provider: [wine-lol-staging (pre-built)](https://github.com/polkaulfield/lol-for-linux-installer/releases)
- winetricks
- bash
- curl
- openssl
- samba
- mesa-utils
- gnutls, lib32-gnutls
- libldap, lib32-libldap
- openal, lib32-openal
- libpulse, lib32-libpulse
- alsa-lib, lib32-alsa-lib
- mpg123, lib32-mpg123
- unixodbc, lib32-unixodbc
- vkd3d, lib32-vkd3d
- vulkan-icd-loader, lib32-vulkan-icd-loader
- [Vulkan drivers](https://wiki.archlinux.org/title/Vulkan) **for your graphic
  cards**, both 64-bit and 32-bit packages are required at the moment until Riot
  ships only the 64-bit binaries. For example:
    - vulkan-intel, lib32-vulkan-intel
    - nvidia-utils, lib32-nvidia-utils
    - vulkan-radeon, lib32-vulkan-radeon
    - amdvlk, lib32-amdvlk

> **Note** <br/>
> The above package names are based on Arch Linux. For other distributions, the
> package names will be different. Please refer to the documentation of the
> distribution for installing the correct Vulkan drivers and other dependencies.


## Configuration

There is no need for configuration. You may feel free to skip this part, unless
you want to change the install path of the game or where the cache is placed.

The helper script looks for configuration files located at
`$XDG_CONFIG_HOME/league.sh` or `~/.config/league.sh`, in that order. The
configuration file is a shell script and will be sourced before starting the
game. You may define any environment variables or run any commands you want,
which might be helpful in special situations.

These are the variables that will be explicitly referenced and used:
- `DATA_HOME`: The path where the game is, or will be, installed. (Default:
    `$XDG_DATA_HOME` or `~/.local/share`)
- `CACHE_HOME`: The path for the cache files. (Default: `$XDG_CACHE_HOME` or
    `~/.cache`)

For example, if the configuration file doesn't exist or if the `DATA_HOME`
variable is not defined, the game would then be installed at
`~/.local/share/leagueoflegends/` by default.


## Usage

### Pre-client-installation checks (Important!)

* Please make sure you have installed the correct Vulkan driver for your
  graphics card that you will be using. You can check what is installed with
  ```
  ls /usr/share/vulkan/icd.d/
  ```

### Install the Riot and League client

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

> **Warning** <br/>
> If you've run wine-lol-staging or other flavors of wine 8.0+ before and now
> have issues with launching the client (especially if you're coming from
> version 8 to 7), and it says something about `unimplemented function
> winegstreamer.dll.winegstreamer_create_video_decoder`. It's because of the
> difference in wine versions. You need to recreate the wine prefix for it to
> work, by running `leagueoflegends reset-wineprefix`.

> **Note** <br/>
> If you use Nvidia graphics card and have trouble launching the League client
> or start the game (after champion selection), please check out [the
> troubleshooting section](#blank-screen-with-nvidia-graphics-card).

`leagueoflegends -h` can be used to view the full list of options and commands.

```
[!] Usage: leagueoflegends [options] <command>

    League of Legends - helper program

    Options:
        -h, --help          Print this message and exit
        -v, --verbose       Enable verbose output
        --pbe               Launch the PBE patchline
        --locale <locale>   Set locale (if different from the region)

    Commands:
        start               Start LoL
        install             Install LoL
        uninstall           Uninstall LoL
        reinstall           Reinstall LoL
        reset-wineprefix    Reset wine prefix
        replay <path>       Replay match (.rofl file)
        add-dxvk            Install DXVK to the LoL wineprefix
        del-dxvk            Remove DXVK from the LoL wineprefix
        rm-dxvk-cache       Remove DXVK cache
        cleanup-logs        Remove log files
        kill                Kill the wine processes of the wineprefix
        run <cmd>           Run shell command with environment variables
```

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
`leagueoflegends kill`) and then try `leagueoflegends rm-dxvk-cache` before
restarting it. This should only need to be done once to clean up the old cache,
since DXVK caching is currently disabled.
([Reference](https://www.reddit.com/r/leagueoflinux/comments/skyg70/fixing_the_nvidia_495_black_screen_crash_problem/))

If the issue still remains, you may want to purge and reinstall the Nvidia
related packages as described
[here](https://www.reddit.com/r/leagueoflinux/comments/r0oo0p/i_got_league_working_again_on_my_nvidia_drivers/).

Alternatively, as a quick (and dirty) workaround, remove the `nvidia` package
and install `nvidia-dkms` instead. Remember to also install the kernel headers
packages according to your kernel (e.g., `linux-headers`). Then reboot and
reinstall LoL.
