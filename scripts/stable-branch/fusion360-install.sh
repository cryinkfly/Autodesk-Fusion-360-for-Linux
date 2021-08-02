#!/bin/bash

##############################################################################
# Name:         Autodesk Fusion 360 - Installationsskript (Linux)
# Description:  With this file you can install Autodesk Fusion 360 on Linux.
# Author:       Steve Zabka
# Author URI:   https://cryinkfly.com
# License:      MIT
# Copyright (c) 2020-2021
# Time/Date:    18:00/01.08.2021
# Version:      2.1
##############################################################################

# DESCRIPTION

# With the help of my script, You get a way to install the Autodesk Fusion 360 on your Linux system. 
# Certain packages and programs that are required will be set up on your system.
#
# But it's important to know, that my script only helps You to get the program to run and nothing more!
#
# And so, You must to purchase the licenses directly from the manufacturer of the program Autodesk Fusion 360!


############################################################################################################################################################
# 1. Step: Open a Terminal and run this command: cd Downloads && chmod +x fusion360-install.sh && bash fusion360-install.sh
# 2. Step: The installation will now start and set up everything for you automatically.
############################################################################################################################################################

function requirement_check {

if ! command -v dialog &> /dev/null
then
    echo "Requirement check failed!"
    echo "Package "dialog" could not be found. Please install dialog with your favorite package-manager in order to run this script."
    exit
fi
}


function welcome_screen {

HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=2
BACKTITLE="Installation of Autodesk Fusion360 - Version 2.1"
TITLE="Do you wish to install Autodesk Fusion 360?"
MENU="Choose one of the following options:"

OPTIONS=(1 "Yes"
         2 "No")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            select_your_os
            ;;
        2)
            exit
            ;;
esac
}

function select_your_os {
HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=10
BACKTITLE="Installation of Autodesk Fusion360 - Version 2.1"
TITLE="Select your Linux distribution"
MENU="Choose one of the following options:"

OPTIONS=(1 "openSUSE Leap 15.2"
         2 "openSUSE Leap 15.3"
         3 "openSUSE Tumbleweed"
         4 "Debian 10 (Buster)"
         5 "Debian 11 (Bullseye)"
         6 "Ubuntu 20.04"
         7 "Ubuntu 20.10"
         8 "Ubuntu 21.04"
         9 "Fedora 33"
         10 "Fedora 34"
         11 "Manjaro 19.0 & newer")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            su -c 'zypper up && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.2/ wine && zypper install p7zip-full curl wget wine cabextract' &&
            winetricks
            ;;
        2)
            su -c 'zypper up && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.3/ wine && zypper install p7zip-full curl wget wine cabextract' &&
            winetricks
            ;;
        3)
            su -c 'zypper up && zypper install p7zip-full curl wget wine cabextract' &&
            winetricks
            ;;     
        4)
            debian_based_1 &&
            sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ buster main' &&
            debian_based_2 &&
            winetricks
            ;;   
        5)
            debian_based_1 &&
            sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ bullseye main' &&
            debian_based_2 &&
            winetricks
            ;;  
        6)    
            debian_based_1 &&
            sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' &&
            debian_based_2 &&
            winetricks
            ;;   
        7)
            debian_based_1 &&
            sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ groovy main' &&
            debian_based_2 &&
            winetricks
            ;;    
        8)
            debian_based_1 &&
            sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ hirsute main' &&
            debian_based_2 &&
            winetricks
            ;;    
        9)
            fedora_based_1 &&
            sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/33/winehq.repo &&
            fedora_based_2 &&
            winetricks
            ;;
        10)
            fedora_based_1 &&
            sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/34/winehq.repo &&
            fedora_based_2 &&
            winetricks
            ;;
        11)
            sudo pacman -Syu &&
            sudo pacman -S wine wine-mono wine_gecko &&
            winetricks
            ;;
esac
}

function debian_based_1 {
    sudo apt-get update &&
    sudo apt-get upgrade &&
    sudo dpkg --add-architecture i386  &&
    wget -nc https://dl.winehq.org/wine-builds/winehq.key &&
    sudo apt-key add winehq.key
}

function debian_based_2 {
    sudo apt-get update &&
    sudo apt-get upgrade &&
    sudo apt-get install p7zip p7zip-full p7zip-rar curl winbind cabextract wget &&
    sudo apt-get install --install-recommends winehq-staging
}

function fedora_based_1 {
    sudo dnf update &&
    sudo dnf upgrade &&
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}

function fedora_based_2 {
    sudo dnf install p7zip p7zip-plugins curl wget wine cabextract
}

function winetricks {
   clear
   echo "Enter the path for your Fusion 360 (For examlble: /run/media/user/usb-drive/wine/fusion360":
   read filename
   mkdir -p $filename &&
   cd $filename &&
   wget -N https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks &&
   chmod +x winetricks &&
   WINEPREFIX=$filename sh winetricks -q corefonts msxml4 msxml6 vcrun2017 fontsmooth=rgb win8 &&
   mkdir -p fusion360-download &&
   cd fusion360-download &&
   wget -N https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe &&
   WINEPREFIX=$filename wine Fusion\ 360\ Admin\ Install.exe -p deploy -g -f log.txt --quiet &&
   WINEPREFIX=$filename wine Fusion\ 360\ Admin\ Install.exe -p deploy -g -f log.txt --quiet &&
   cd "$filename/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform" &&
   mkdir -p Options &&
   cd Options
   wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml
   echo "The installation of Autodesk Fusion 360 is completed."
   exit
}

# ---------------------------------------------------------------------
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

requirement_check
welcome_screen
