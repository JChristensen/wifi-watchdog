#!/bin/bash
# Retrieve watchdog journal messages from a given host and display them with less.
# The "ping OK" messages are filtered out unless the -v (--verbose) option is given.
# J.Christensen 12Aug2026

usage()
{
    PROGNAME=$(basename $0)
    echo "Usage: $PROGNAME [-t | --terse] <hostname>" >&2
    return
}

if [[ $# -lt 1 ]]; then
    echo "Expecting command line argument(s)."
    usage
    exit 1
fi

case "$1" in
    -v|--verbose) shift
        ssh $1 "journalctl --grep \"wifi-watchdog:\"" | less
        exit
        ;;
    *) ssh $1 "journalctl --grep \"wifi-watchdog:\"" | grep -v "ping OK" | less
        exit
        ;;
esac
