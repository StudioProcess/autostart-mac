#!/usr/bin/env bash

# Allow sudo without password (admins only)
# Tested on macOS 13

[[ $(uname) != 'Darwin' ]] && { echo 'This script requires macOS'; exit 1; }

_do() {
    sudo mkdir -p /private/etc/sudoers.d
    echo '# Allow sudo without password (admins only)\n%admin          ALL = (ALL) NOPASSWD: ALL' | sudo tee /private/etc/sudoers.d/100-nopasswd > /dev/null
}

_undo() {
    sudo rm /private/etc/sudoers.d/100-nopasswd
}

if [[ "$1" == "-u" ]]; then
    echo -n 'Undo allowing sudo without password? (y/n) ? '
    read -n 1 key; echo ''
    if [[ "$key" == 'y' ]]; then
        _undo
        echo "Done"; exit 0
    else
        echo "Aborting"; exit 2
    fi
else
    echo -n 'Allow sudo without password (admins only)? (y/n) ? '
    read -n 1 key; echo ''
    if [[ "$key" == 'y' ]]; then
        _do
        echo "Done"
        echo "Undo with: $0 -u"; exit 0
    else
        echo "Aborting"; exit 2
    fi
fi
