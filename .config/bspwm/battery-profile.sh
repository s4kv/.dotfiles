#!/bin/bash

# Path to the battery capacity and status files
BATTERY_CAPACITY="/sys/class/power_supply/BAT0/capacity"
BATTERY_STATUS="/sys/class/power_supply/BAT0/status"

# Function to get the current battery level
get_battery_level() {
    cat "$BATTERY_CAPACITY"
}

# Function to get the current battery status
get_battery_status() {
    cat "$BATTERY_STATUS"
}

# Function to set the performance profile
set_performance_profile() {
    local profile="$1"
    asusctl profile -P "$profile"
}

# Function to get the current performance profile
get_performance_profile() {
    asusctl profile -p | grep -oP '(?<=Active profile is )\w+'
}

# Function to set the keyboard light
set_keyboard_light() {
    local light="$1"
    asusctl -k "$light"
}

# Infinite loop to monitor the battery level and status every minute
while true; do
    battery_level=$(get_battery_level)
    battery_status=$(get_battery_status)

    if [ "$battery_status" = "Charging" ] || [ "$battery_level" -gt 90 ]; then
        if [ "$(get_performance_profile)" != "Performance" ]; then
            set_keyboard_light "high"
            set_performance_profile "Performance"
        fi
    elif [ "$battery_level" -ge 80 ]; then
        if [ "$(get_performance_profile)" != "Balanced" ]; then
            set_keyboard_light "low"
            set_performance_profile "Balanced"
        fi
    else
        if [ "$(get_performance_profile)" != "Quiet" ]; then
            set_keyboard_light "off"
            set_performance_profile "Quiet"
        fi
    fi

    sleep 60
done

# create a systemd service to run the script on /etc/systemd/system/battery-profile.service

# [Unit]
# Description=Battery Profile Service
# After=multi-user.target
#
# [Service]
# Type=oneshot
# ExecStart=/usr/local/bin/battery-profile.sh

# create systemd path unit /etc/systemd/system/battery-profile.path

# [Unit]
# Description=Monitor Battery Capacity Changes
#
# [Path]
# PathChanged=/sys/class/power_supply/BAT0/capacity
#
# [Install]
# WantedBy=multi-user.target

# reload systemd: sudo systemctl daemon-reload
# sudo systemctl enable battery-profile.path
# sudo systemctl start battery-profile.path
