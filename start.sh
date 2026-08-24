#!/bin/bash
# Enable and start the wifi-watchdog, then print status. Must run as root.
# J.Christensen 12Aug2026

# ensure we're root (sudo)
ROOT_UID=0
if [[ $UID != $ROOT_UID ]]; then
    echo "This script must be run with sudo."
    exit 1
fi

version=$(cat /usr/local/bin/wifi-watchdog.version)
echo "Enabling and starting the wifi-watchdog version $version..."
logger "wifi-watchdog: enabling and starting $version"
systemctl daemon-reload
systemctl enable wifi-watchdog.timer wifi-watchdog.service
systemctl start wifi-watchdog.timer wifi-watchdog.service
systemctl status wifi-watchdog.timer wifi-watchdog.service
