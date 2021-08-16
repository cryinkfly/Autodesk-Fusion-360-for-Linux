#!/bin/bash

##############################################################################
# Name:         OctoPrint - Installationsskript (Linux)
# Description:  With this file you can install OctoPrint on your Linux distribution (Debian-based).
# Author:       Steve Zabka
# Author URI:   https://cryinkfly.com
# License:      MIT
# Copyright (c) 2020-2021
# Time/Date:    22:00/16.08.2021
# Version:      1.0
##############################################################################

function requirement-check {
echo "Installation of Octoprint!"
echo -n "Do you wish to install this on your Linux distribution (y/n)?"
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    install-requirement-check
else
    exit;
fi
}


function install-requirement-check {
if VERB="$( which apt-get )" 2> /dev/null; then
   echo "Debian-based"
   sudo apt-get update &&
   sudo apt-get install python3-pip python3-dev python3-setuptools python3-venv git libyaml-dev build-essential &&
   mkdir OctoPrint && cd OctoPrint &&
   python3 -m venv venv &&
   source venv/bin/activate &&
   pip install pip --upgrade &&
   pip install octoprint &&

   sudo usermod -a -G tty $USER &&
   sudo usermod -a -G dialout $USER &&

   wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/octoprint.service && 
   sudo mv octoprint.service /etc/systemd/system/octoprint.service &&

   sudo service octoprint start
   echo "Now you can use this command for manage OctoPrint on your system: sudo service octoprint {start|stop|restart}"
   echo "The installation of OctoPrint is completed and you can use it for your projects."
else
   echo "I can't find your package manager!"
   exit;
fi
}