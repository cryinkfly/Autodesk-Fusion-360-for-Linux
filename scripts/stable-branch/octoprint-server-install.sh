#!/bin/bash

##############################################################################
# Name:         OctoPrint (Server) - Installationsskript (Linux)
# Description:  With this file you can install OctoPrint (Server) on your Linux distribution (Debian-based).
# Author:       Steve Zabka
# Author URI:   https://cryinkfly.com
# License:      MIT
# Copyright (c) 2020-2021
# Time/Date:    19:00/16.09.2021
# Version:      1.5
##############################################################################

# DESCRIPTION

# With the help of my script, you get a way to install and use OctoPrint (Server) on your Linux system (Debian-based). 
# Certain packages and programs that are required will be set up on your system.

############################################################################################################################################################
# 1. Step: Open a Terminal and run this command: cd Downloads && chmod +x octoprint-server-install.shh && bash octoprint-server-install.sh
# 2. Step: The installation will now start and set up everything for you automatically.
############################################################################################################################################################

function requirement-check {
echo "Installation of Octoprint (Server)!"
echo -n "Do you wish to install this on your Linux distribution (y/n)?"
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    install-requirement-check
else
    exit;
fi
}


function install-requirement-check {
   sudo apt-get update &&
   sudo apt-get install python3-pip python3-dev python3-setuptools python3-venv git libyaml-dev build-essential &&
   mkdir -p "/$HOME/OctoPrint" &&
   cd "/$HOME/OctoPrint" &&
   python3 -m venv venv &&
   source venv/bin/activate &&
   pip install pip --upgrade &&
   pip install octoprint &&
   
   sudo usermod -a -G tty $USER &&
   sudo usermod -a -G dialout $USER &&
   
   ~/OctoPrint/venv/bin/octoprint serve &&

   wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/octoprint.service && 
   sudo mv octoprint.service /etc/systemd/system/octoprint.service &&
   
   sudo systemctl enable octoprint.service &&

   clear &&

   echo "The installation of OctoPrint (Server) is completed and you can use it for your projects."
   echo "Now you can use this command for manage OctoPrint (Server) on your system: sudo service octoprint {start|stop|restart}"

}

requirement-check
