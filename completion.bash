#!/usr/bin/env bash

IFS=$'\n' read -r -d '' -a commands < <(
    leagueoflegends -h \
        | sed '/Commands:/,$!d' \
        | grep -v 'Commands:' \
        | awk -F ' ' '{print $1}' \
    && printf '\0'
)

complete -W "${commands[*]}" leagueoflegends
