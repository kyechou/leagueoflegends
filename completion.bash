#!/usr/bin/env bash

COMMANDS=(
    start
    install
    uninstall
    reinstall
    start-garena
    install-garena
    uninstall-garena
    reinstall-garena
    add-dxvk
    del-dxvk
    rm-dxvk-cache
    cleanup-logs
    kill
    kill-garena
    run
    run-garena
)

complete -W "${COMMANDS[*]}" leagueoflegends
