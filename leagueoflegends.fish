# Completions for leagueoflegends

# Define the locales and their description
set locales 'ja_jp	Japanese' \
 'ko_kr	Korean' \
 'zh_cn	Chinese' \
 'zh_tw	Taiwanese' \
 'es_es	Spanish (Spain)' \
 'es_mx	Spanish (Latin America)' \
 'en_us	English (US)' \
 'en_au	English (Australia)' \
 'en_gb	English (UK)' \
 'fr_fr	French' \
 'de_de	German' \
 'it_it	Italian' \
 'pl_pl	Polish' \
 'ro_ro	Romanian' \
 'el_gr	Greek' \
 'pt_br	Portuguese (Brazil)' \
 'hu_hu	Hungarian' \
 'ru_ru	Russian' \
 'tr_tr	Turkish'

# Define command list
set -l command_list start stop install uninstall reinstall reset-wineprefix replay add-dxvk del-dxvk rm-dxvk-cache cleanup-logs kill run

# Define command description (name and description separated by one tab)
set commands \
  'start	Start LoL' \
  'stop	Same as kill' \
  'install	Installs LoL' \
  'uninstall	Uninstall LoL' \
  'reinstall	Reinstall LoL' \
  'reset-wineprefix	Reset wine prefix' \
  'add-dxvk	Install DXVK to the LoL wineprefix' \
  'del-dxvk	Remove DXVK from the LoL wineprefix' \
  'rm-dxvk-cache	Remove DXVK cache' \
  'cleanup-logs	Remove log files' \
  'kill	Kill the wine processes of the wineprefix'

# Remove file auto completion from base leagueoflegends command
complete -c leagueoflegends -f

# Add launch options 
complete -c leagueoflegends -n "not __fish_seen_subcommand_from run" -s h -l help -d "Print help information and exit" -f
complete -c leagueoflegends -n "not __fish_seen_subcommand_from run" -s v -l verbose -d "Enable verbose output" -f
complete -c leagueoflegends -n "not __fish_seen_subcommand_from run" -l pbe -d "Launch the PBE patchline" -f

# Complete the --locale option with the list of locales
complete -c leagueoflegends -n "not __fish_seen_subcommand_from run" -s l -l locale -d 'Set locale (if different from the region)' -a '$locales' -f -r

# Add main subcommands
complete -c leagueoflegends -n "not __fish_seen_subcommand_from $command_list" -a '$commands' -f

# Add replay and run subcommands
complete -c leagueoflegends -n "not __fish_seen_subcommand_from $command_list" -a "replay" -d "Replay match (.rofl file)" -r -f
complete -c leagueoflegends -n "not __fish_seen_subcommand_from $command_list"  -a "run" -d "Run shell command with environment variables" -r 

# Enable completion for replay and run subcommands
complete -c leagueoflegends -n "__fish_seen_subcommand_from replay" --keep-order -x -a '(__fish_complete_suffix .rofl)'
complete -c leagueoflegends -n "__fish_seen_subcommand_from run" -a "(__fish_complete_subcommand --fcs-skip=2)" -x
