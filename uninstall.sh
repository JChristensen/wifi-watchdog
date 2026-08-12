#!/bin/bash
# Un-install script for Raspberry Pi WiFi Watchdog
# J.Christensen 12Aug2026

# ensure we're root (sudo)
ROOT_UID=0
if [[ $UID != $ROOT_UID ]]; then
    echo "This script must be run with sudo."
    exit 1
fi

echo -e "\nStopping the watchdog..."
/home/$SUDO_USER/wifi-watchdog/stop.sh

echo -e "\nRemoving script..."
rm -v /usr/local/bin/wifi-watchdog*

echo -e "\nRemoving systemd unit files..."
rm -v /etc/systemd/system/wifi-watchdog.*
systemctl daemon-reload

echo -e "\nWiFi Watchdog uninstalled."
