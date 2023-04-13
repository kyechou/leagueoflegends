#compdef leagueoflegends

_commands=("${(@f)$(
    leagueoflegends -h \
        | sed -e '/Commands:/,$!d' -e 's/<[^>]*>//' \
        | grep -v 'Commands:' \
        | awk -F ' ' '{printf $1 ":"; for (i=2;i<NF;i++) printf $i " "; print $NF}'
)}")

_describe_lol_commands() {
	_describe 'command' _commands -o nosort
}

_leagueoflegends() {
	local context state state_descr line
        typeset -A opt_args

	_arguments \
		'(-h --help)'{-h,--help}'[Show help message]' \
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
