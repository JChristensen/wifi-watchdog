#!/bin/bash
# Install script for Raspberry Pi WiFi Watchdog
# J.Christensen 12Aug2026

# ensure we're root (sudo)
ROOT_UID=0
if [[ $UID != $ROOT_UID ]]; then
    echo "This script must be run with sudo."
    exit 1
fi

REPO_DIR="/home/$SUDO_USER/wifi-watchdog"
TARGET_FILE="$REPO_DIR/wifi-watchdog-target"
target="192.168.1.1"
version=$(git -C $REPO_DIR log -1 --format="%h %ai")
echo $version >/usr/local/bin/wifi-watchdog.version

echo; read -p "The default ping target is $target. Do you want to change this? [y/N] "
r=${REPLY,,}    # make lower case
if [[ "$r" =~ ^[[:space:]]*y ]]; then
    read -p $'\nEnter new ping target: '
    target=$REPLY
fi
echo "Using $target as ping target."
echo $target >$TARGET_FILE

echo -e "\nInstalling systemd unit files..."
cp -av $REPO_DIR/wifi-watchdog.timer /etc/systemd/system/
cp -av $REPO_DIR/wifi-watchdog.service /etc/systemd/system/

echo -e "\nInstalling script..."
cp -av $REPO_DIR/wifi-watchdog.sh /usr/local/bin
cp -av $REPO_DIR/wifi-watchdog-target /usr/local/bin

echo; read -p "Do you want to start the watchdog? [Y/n] "
r=${REPLY,,}    # make lower case
if [[ "$r" =~ ^[[:space:]]*n ]]; then
    exit
else
    $REPO_DIR/start.sh
fi

echo -e "\nInstallation complete, version $version"
