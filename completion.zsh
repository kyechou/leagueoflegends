#compdef leagueoflegends

_commands=(
    'start:Start LoL'
    'stop:Same as kill'
    'install:Install LoL'
    'uninstall:Uninstall LoL'
    'reinstall:Reinstall LoL'
    'reset-wineprefix:Reset wine prefix'
    'replay:Replay match (.rofl file)'
    'add-dxvk:Install DXVK to the LoL wineprefix'
    'del-dxvk:Remove DXVK from the LoL wineprefix'
    'rm-dxvk-cache:Remove DXVK cache'
    'cleanup-logs:Remove log files'
    'kill:Kill the wine processes of the wineprefix'
    'run:Run shell command with environment variables'
)

_describe_lol_commands() {
	_describe 'command' _commands -o nosort
}

_leagueoflegends() {
	local context state state_descr line
        typeset -A opt_args

	_arguments \
		'(-h --help)'{-h,--help}'[Show help information]' \
		'(-v --verbose)'{-v,--verbose}'[Enable verbose output]' \
		'--pbe[Launch the PBE patchline]' \
		'--locale[Set locale (if different from the region)]:locale:_default' \
		'1: :_describe_lol_commands' \
		'*:: :->args'

	case $line[1] in
		replay)
			_arguments \
				"1:filename:_files -g '*.rofl'"
		;;
		run)
			_arguments \
				"*::command:_normal"
		;;
	esac
}

_leagueoflegends
