#!/bin/bash
# Just print wifi-watchdog status.
# J.Christensen 12Aug2026

systemctl status wifi-watchdog.timer wifi-watchdog.service
