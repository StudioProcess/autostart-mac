#!/usr/bin/env zsh

# Log date to file
#echo $(date) >> log.txt

# Launch Chrome in kiosk mode
#open -a "Google Chrome.app" --args https://example.com --kiosk

app="Gravitational Waves.app"

function get_pid() {
    pgrep -f "$1"
}

function wait_for_shutdown() {
    while [[ ! -z $(get_pid "$1") ]]; do
        sleep 1
    done
}

trap "pkill -f \"$app\"; exit" INT TERM # make sure to kill app on script exit
osascript ./tools/launch_chrome_app_fullscreen.applescript "$app"
wait_for_shutdown "$app"
