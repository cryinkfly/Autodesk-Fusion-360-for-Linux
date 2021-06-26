#!/bin/bash

# Name:         Autodesk Fusion 360 - Installationsskript with DXVK (Linux)
# Description:  With this file you can install Autodesk Fusion 360 on Linux.
# Author:       Steve Zabka
# Author URI:   https://cryinkfly.de
# Time/Date:    12:30/26.06.2021
# Version:      0.7

# 1. Step: Open a Terminal and run this command: cd Downloads && chmod +x fusion360-dxvk-install.sh && bash fusion360-dxvk-install.sh
# 2. Step: The installation will now start and set up everything for you automatically.
# 3. Step: Now you can use my other file "fusion360-start.sh" for running Autodesk Fusion 360 on your system.
# 4. Step: When you have opened Fusion 360 -> Go to preferences and in General under Graphics driver, select DirectX 9.


# Find your correct package manager and install some packages (the minimum requirements), what you need for the installation of Autodesk Fusion 360!


# Debian versions
if VERB="$( which apt-get )" 2> /dev/null; then
   echo "Debian-based"
   sudo apt-get update &&
   sudo apt-get upgrade &&
   sudo dpkg --add-architecture i386  &&
   wget -nc https://dl.winehq.org/wine-builds/winehq.key &&
   sudo apt-key add winehq.key
elif [[ $(lsb_release -rs) == "10" ]]; then
    echo "Debian 10 based system"
    sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ buster main'
elif [[ $(lsb_release -rs) == "11" ]]; then
    echo "Debian 11 based system"
    sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ bullseye main'


# Ubuntu, Linux Mint, ... versions
elif [[ $(lsb_release -rs) == "20.04" ]]; then
   echo "Ubuntu 20.04 based system"
   sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
elif [[ $(lsb_release -rs) == "20.10" ]]; then
   echo "Ubuntu 20.10 based system"
   sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ groovy main'
elif [[ $(lsb_release -rs) == "21.04" ]]; then
   echo "Ubuntu 21.04 based system"
   sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ hirsute main'
elif VERB="$( which apt-get )" 2> /dev/null; then
  sudo apt-get update &&
  sudo apt-get upgrade &&
  sudo apt-get install p7zip p7zip-full p7zip-rar curl winbind cabextract &&
# sudo apt-get install xdotool (experimental)
  sudo apt-get install --install-recommends winehq-staging


# Fedora versions
elif VERB="$( which dnf )" 2> /dev/null; then
   echo "RedHat-based"
   sudo dnf update &&
   sudo dnf upgrade &&
   sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm &&
   sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/34/winehq.repo &&
   sudo dnf install p7zip p7zip-plugins curl wine cabextract
# sudo dnf install xdotool (experimental)


# Arch Linux, Manjaro, ... versions
elif VERB="$( which pacman )" 2> /dev/null; then
   echo "Arch-based"
   sudo pacman -Syu &&
   sudo pacman -S wine wine-mono wine_gecko
# sudo pacman -S xdotool (experimental)


# openSUSE Leap & Tumbleweed, SUSE Linux, ... versions
elif VERB="$( which zypper )" 2> /dev/null; then
   echo "openSUSE-based"
   su -c 'zypper up && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.2/ wine && zypper install p7zip-full curl wine cabextract'
# su -c 'zypper install xdotool' (experimental)
else
   echo "Non-compatible Linux distribution version was found!" >&2
   exit 1
fi

if [[ 1 -ne $# ]]; then
   echo "Minimum requirements have been installed and set up for your system! "

# Installation of Autodesk Fusion 360:

   echo "The latest version of wintricks will be downloaded and executed."
   wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks &&
   chmod +x winetricks &&
   WINEPREFIX=~/.fusion360 sh winetricks -q corefonts msxml4 vcrun2017 dxvk fontsmooth=rgb win10 &&

   echo "Autodesk Fusion 360 will be installed and set up."
   mkdir -p fusion360 &&
   cd fusion360 &&
   wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe &&

   WINEPREFIX=~/.fusion360 wine Fusion\ 360\ Admin\ Install.exe -p deploy -g -f log.txt --quiet &&
   WINEPREFIX=~/.fusion360 wine Fusion\ 360\ Admin\ Install.exe -p deploy -g -f log.txt --quiet &&

   echo "Change the DLL's"
   echo "---------------------------------"
   echo "d3d10core = disabled"
   echo "d3d11 = builtin"
   echo "d3d9 = builtin"
   echo "dxgi = builtin"
   cd .. &&
   WINEPREFIX=~/.fusion360 sh winetricks d3d10core=disabled d3d11=builtin d3d9=builtin dxgi=builtin


# Autodesk Fusion 360 works also, when you skip the next step!!!

   echo "Now we open wine regedit and go to HKEY_CURRENT_USER\Software\Wine\Direct3D"
   echo "And here we can change this option (Experimental): renderer to vulkan"
   WINEPREFIX=~/.fusion360 wine regedit

   echo "The installation of Autodesk Fusion 360 is completed."
   exit 1
fi
$VERB "$1"
exit $?
