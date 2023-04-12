#!/usr/bin/env bash

# Disable SSH password authentication (public key only)
# Tested on macOS 13

[[ $(uname) != 'Darwin' ]] && { echo 'This script requires macOS'; exit 1; }

_do() {
    echo '# Disable SSH password authentication (public key only)\nPasswordAuthentication no\nPubkeyAuthentication yes' | sudo tee /etc/ssh/sshd_config.d/150-nopwauth.conf > /dev/null
    sudo launchctl stop com.openssh.sshd
    sudo launchctl start com.openssh.sshd
}

_undo() {
    sudo rm /etc/ssh/sshd_config.d/150-nopwauth.conf
}

if [[ "$1" == "-u" ]]; then
    echo -n 'Undo disabling SSH password authentication? (y/n) ? '
    read -n 1 key; echo ''
    if [[ "$key" == 'y' ]]; then
        _undo
        echo "Done"; exit 0
    else
        echo "Aborting"; exit 2
    fi
else
    echo -n 'Disable SSH password authentication (public key only)? (y/n) ? '
    read -n 1 key; echo ''
    if [[ "$key" == 'y' ]]; then
        _do
        echo "Done"
        echo "Undo with: $0 -u"; exit 0
    else
        echo "Aborting"; exit 2
    fi
fi
