#!/bin/bash

# Name:         Autodesk Fusion 360 - Installationsskript with DXVK (Linux)
# Description:  With this file you can install Autodesk Fusion 360 on Linux.
# Author:       Steve Zabka
# Author URI:   https://cryinkfly.de
# Time/Date:    14:00/11.05.2021
# Version:      0.1

# 1. Step: Open a Terminal and run this command: cd Downloads && chmod +x fusion360-install.sh && sh fusion360-dxvk.sh
# 2. Step: The installation will now start and set up everything for you automatically.
# 3. Step: Now you can use my other file "fusion360-start.sh" for running Autodesk Fusion 360 on your system.
# 4. Step: When you have opened Fusion 360 -> Go to preferences and in General under Graphics driver, select DirectX 9.


# Find your correct package manager and install some packages (the minimum requirements), what you need for the installation of Autodesk Fusion 360!
if VERB="$( which apt-get )" 2> /dev/null; then
   echo "Debian-based"
   sudo dpkg --add-architecture i386  &&
   wget -nc https://dl.winehq.org/wine-builds/winehq.key &&
   sudo apt-key add winehq.key &&
   sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' &&
   sudo apt-get update &&
   sudo apt-get upgrade &&
   sudo apt-get install p7zip p7zip-full p7zip-rar curl winbind &&
   sudo apt-get install --install-recommends winehq-staging
elif VERB="$( which dnf )" 2> /dev/null; then
   echo "RedHat-based"
   sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm &&
   sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/34/winehq.repo
   sudo dnf update &&
   sudo dnf upgrade &&
   sudo dnf install p7zip p7zip-plugins curl wine
elif VERB="$( which pacman )" 2> /dev/null; then
   echo "Arch-based"
   sudo pacman -Syu &&
   pacman -S wine wine-mono wine_gecko
elif VERB="$( which zypper )" 2> /dev/null; then
   echo "openSUSE-based"
   su -c 'zypper up && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.2/ wine && zypper install p7zip-full curl wine'
else
   echo "I have no idea what I'm doing." >&2
   exit 1
fi
if [[ 1 -ne $# ]]; then
   echo "Minimum requirements have been installed and set up for your system! "

# Installation of Autodesk Fusion 360:

   echo "The latest version of wintricks will be downloaded and executed."
   wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks &&
   chmod +x winetricks &&
   WINEPREFIX=~/.fusion360 sh winetricks -q corefonts vcrun2017 msxml4 dxvk win10 &&

   echo "Autodesk Fusion 360 will be installed and set up."
   mkdir fusion360 &&
   cd fusion360 &&
   wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe &&

   WINEPREFIX=~/.fusion360 wine Fusion\ 360\ Admin\ Install.exe -p deploy -g -f log.txt --quiet &&
   WINEPREFIX=~/.fusion360 wine Fusion\ 360\ Admin\ Install.exe -p deploy -g -f log.txt --quiet &&

   echo "Change the DLL's with winecfg"
   echo "---------------------------------"
   echo "d3d10core = disabled"
   echo "d3d11 = builtin"
   echo "d3d9 = builtin"
   echo "dxgi = builtin"
   WINEPREFIX=~/.fusion360 winecfg &&
   echo "Now we open wine regedit and go to HKEY_CURRENT_USER\Software\Wine\Direct3D"
   echo "And here we must change this option: renderer to vulkan"
   WINEPREFIX=~/.fusion360 wine regedit

   echo "The installation of Autodesk Fusion 360 is completed."
   exit 1
fi
$VERB "$1"
exit $?
