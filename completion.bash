#!/usr/bin/env bash

COMMANDS=(
    start
    install
    uninstall
    reinstall
    reset-wineprefix
    replay
    add-dxvk
    del-dxvk
    rm-dxvk-cache
    cleanup-logs
    kill
    run
)

complete -W "${COMMANDS[*]}" leagueoflegends
