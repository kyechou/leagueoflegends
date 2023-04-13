# Completions for leagueoflegends

set locales \
    'de_DE	German' \
    'el_GR	Greek' \
    'en_AU	English (Australia)' \
    'en_GB	English (UK)' \
    'en_US	English (US)' \
    'es_ES	Spanish (Spain)' \
    'es_MX	Spanish (Latin America)' \
    'fr_FR	French' \
    'hu_HU	Hungarian' \
    'it_IT	Italian' \
    'ja_JP	Japanese' \
    'ko_KR	Korean' \
    'pl_PL	Polish' \
    'pt_BR	Portuguese (Brazil)' \
    'ro_RO	Romanian' \
    'ru_RU	Russian' \
    'tr_TR	Turkish' \
    'zh_CN	Chinese' \
    'zh_TW	Taiwanese'

set -l commands (leagueoflegends -h | sed '/Commands:/,$!d' | grep -v 'Commands:' | awk -F ' ' '{print $1}')
set -l commands_w_desc (
    leagueoflegends -h \
        | sed -e '/Commands:/,$!d' -e 's/<[^>]*>//' \
        | grep -v 'Commands:' \
        | awk -F ' ' '{printf $1 "\t"; for (i=2;i<NF;i++) printf $i " "; print $NF}'
)
set single_cmds_w_desc (printf '%s\n' $commands_w_desc | grep -vE '^(replay|run)')
set replay_w_desc      (printf '%s\n' $commands_w_desc | grep -E '^replay')
set run_w_desc         (printf '%s\n' $commands_w_desc | grep -E '^run')

# Remove file auto completion from base leagueoflegends command
complete -c leagueoflegends -f

# Options
complete -c leagueoflegends -n "not __fish_seen_subcommand_from $commands" -s h -l help    -d "Show help message" -f
complete -c leagueoflegends -n "not __fish_seen_subcommand_from $commands" -s v -l verbose -d "Enable verbose output" -f
complete -c leagueoflegends -n "not __fish_seen_subcommand_from $commands" -l pbe          -d "Launch the PBE patchline" -f
complete -c leagueoflegends -n "not __fish_seen_subcommand_from $commands" -l locale       -d "Set locale (if different from the region)" -a "$locales" -f -r

# Main subcommands
complete -c leagueoflegends -n "not __fish_seen_subcommand_from $commands" -a '$single_cmds_w_desc' -f
complete -c leagueoflegends -n "not __fish_seen_subcommand_from $commands" -a '$replay_w_desc' -f -r
complete -c leagueoflegends -n "not __fish_seen_subcommand_from $commands" -a '$run_w_desc' -r

# Enable auto completion for replay and run subcommands
complete -c leagueoflegends -n "__fish_seen_subcommand_from replay" --keep-order -x -a "(__fish_complete_suffix .rofl)"
complete -c leagueoflegends -n "__fish_seen_subcommand_from run" -x -a "(__fish_complete_subcommand --fcs-skip=2)"
