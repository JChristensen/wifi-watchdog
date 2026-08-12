#!/bin/bash
# Stop and disable the wifi-watchdog, then print status. Must run as root.
# J.Christensen 12Aug2026

# ensure we're root (sudo)
ROOT_UID=0
if [[ $UID != $ROOT_UID ]]; then
    echo "This script must be run with sudo."
    exit 1
fi

echo "Stopping and disabling the wifi-watchdog..."
logger "wifi-watchdog: stopping and disabling."
systemctl stop wifi-watchdog.timer wifi-watchdog.service
systemctl disable wifi-watchdog.timer wifi-watchdog.service
systemctl status wifi-watchdog.timer wifi-watchdog.service
