# Wi-Fi Watchdog for Raspberry Pi
https://github.com/JChristensen/wifi-watchdog  
README file  
Jack Christensen  
Aug 2026
## Background
After struggling for years with intermittent wifi issues on Raspberry Pi Zero W and 2W machines, I read [this article on DigiKey's web site by Nate Larson](https://www.digikey.com/en/maker/tutorials/2026/how-to-keep-a-raspberry-pi-zero-w-or-zero-2-w-reliably-connected-to-wifi) with great interest. Somehow the fact that there are known issues in the Broadcom wifi firmware had escaped me. I had implemented my own watchdog script similar to Nate's (i.e. ping the router, reboot if it can't be reached), but I liked his better. I did make some small changes to the watchdog script, and also added scripts to install, uninstall, start, stop, and check status of the watchdog.

## Prerequisites
If not already installed, install Git on the Raspberry Pi.
```bash
sudo apt update && sudo apt install git
```

## Installation
```bash
# change to your home directory
cd
# clone the repo
git clone --depth 1 https://github.com/JChristensen/wifi-watchdog
# run the install script
sudo wifi-watchdog/install.sh
```
The install script will ask for an IP address that the watchdog will use to test connectivity, the default is 192.168.1.1.

When complete, the install script will offer to start the watchdog.

## Script summary

* **check.sh** - Retrieve and display watchdog messages from a given host.
* **install.sh** - Installs the watchdog.
* **start.sh** - Enables and starts the watchdog.
* **status.sh** - Prints status of the watchdog timer and service units.
* **stop.sh** - Stops and disables the watchdog.
* **uninstall.sh** - Removes the watchdog script and systemd unit files.
