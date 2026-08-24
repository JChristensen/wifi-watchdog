#!/bin/bash
# WiFi watchdog script for Raspberry Pi Zero W/W2.
# From https://www.digikey.com/en/maker/tutorials/2026/how-to-keep-a-raspberry-pi-zero-w-or-zero-2-w-reliably-connected-to-wifi
# Couple minor mods by J.Christensen 12Aug2026

PING_COUNT=3
FAIL_THRESHOLD=3
FAIL_FILE="/tmp/wifi-watchdog-fails"
TARGET_FILE="/usr/local/bin/wifi-watchdog-target"

if [ ! -f "$FAIL_FILE" ]; then
    echo 0 > "$FAIL_FILE"
fi

if [ ! -f "$TARGET_FILE" ]; then
    echo "192.168.1.1" > "$TARGET_FILE"
fi

FAILS=$(cat "$FAIL_FILE")
PING_TARGET=$(cat "$TARGET_FILE")

if ping -c "$PING_COUNT" -W 3 "$PING_TARGET" > /dev/null 2>&1; then
    echo 0 > "$FAIL_FILE"
    logger "wifi-watchdog: ping OK"
else
    FAILS=$((FAILS + 1))
    echo "$FAILS" > "$FAIL_FILE"
    logger "wifi-watchdog: ping failed, consecutive failures: $FAILS"

    if [ "$FAILS" -ge "$FAIL_THRESHOLD" ]; then
        conn_name=$(nmcli --terse conn show --active|head -1|awk -F":" '!/^lo:/ {print $1}')
        if ! (( ${#conn_name} )); then
            logger "wifi-watchdog: no active connection found, rebooting"
            echo 0 > "$FAIL_FILE"
            /usr/sbin/reboot
        fi
        logger "wifi-watchdog: threshold reached, attempting to restart connection: $conn_name"
        nmcli connection down "$conn_name"
        sleep 5
        nmcli connection up "$conn_name"
        sleep 15

        if ping -c 3 -W 3 "$PING_TARGET" > /dev/null 2>&1; then
            logger "wifi-watchdog: wifi restart successful"
            echo 0 > "$FAIL_FILE"
        else
            logger "wifi-watchdog: wifi restart failed, rebooting"
            echo 0 > "$FAIL_FILE"
            /usr/sbin/reboot
        fi
    fi
fi
