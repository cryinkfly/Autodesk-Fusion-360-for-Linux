#!/bin/bash

##############################################################################
# Name:         Autodesk Fusion 360 - Installationsskript (Linux)
# Description:  With this file you can install Autodesk Fusion 360 on Linux.
# Author:       Steve Zabka
# Author URI:   https://cryinkfly.com
# License:      MIT
# Copyright (c) 2020-2021
# Time/Date:    14:00/08.08.2021
# Version:      2.8
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

function requirement-check-dialog {
echo "Find your correct package manager and install the package dialog, what you need for the installation of Autodesk Fusion 360!"
echo -n "Do you wish to install this package (y/n)?"
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    install-dialog
else
    exit;
fi
}

function install-dialog {
if VERB="$( which apt-get )" 2> /dev/null; then
   echo "Debian-based"
   sudo apt-get update &&
   sudo apt-get install dialog
elif VERB="$( which dnf )" 2> /dev/null; then
   echo "RedHat-based"
   sudo dnf update &&
   sudo dnf install dialog
elif VERB="$( which pacman )" 2> /dev/null; then
   echo "Arch-based"
   sudo pacman -Sy dialog
elif VERB="$( which zypper )" 2> /dev/null; then
   echo "openSUSE-based"
   su -c 'zypper up && zypper install dialog'
elif VERB="$( which xbps-install )" 2> /dev/null; then
   echo "Void-based"
   sudo xbps-install -Sy dialog
else
   echo "I can't find your package manager!"
   exit;
fi
}

function welcome_screen {

HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=2
BACKTITLE="Installation of Autodesk Fusion360 - Version 2.8"
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
BACKTITLE="Installation of Autodesk Fusion360 - Version 2.8"
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
         11 "Manjaro 19.0 & newer"
         12 "Arch Linux"
         13 "Void Linux")

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
            su -c 'zypper up && zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.2/ wine && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.2/ wine && zypper install p7zip-full curl wget wine cabextract' &&
            select_your_path
            ;;
        2)
            su -c 'zypper up && zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.3/ wine && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.3/ wine && zypper install p7zip-full curl wget wine cabextract' &&
            select_your_path
            ;;
        3)
            su -c 'zypper up && zypper install p7zip-full curl wget wine cabextract' &&
            select_your_path
            ;;     
        4)
            debian_based_1 &&
            sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ buster main' &&
            debian_based_2 &&
            select_your_path
            ;;   
        5)
            debian_based_1 &&
            sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ bullseye main' &&
            debian_based_2 &&
            select_your_path
            ;;  
        6)    
            debian_based_1 &&
            sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' &&
            debian_based_2 &&
            select_your_path
            ;;   
        7)
            debian_based_1 &&
            sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ groovy main' &&
            debian_based_2 &&
            select_your_path
            ;;    
        8)
            debian_based_1 &&
            sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ hirsute main' &&
            debian_based_2 &&
            select_your_path
            ;;    
        9)
            fedora_based_1 &&
            sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/33/winehq.repo &&
            fedora_based_2 &&
            select_your_path
            ;;
        10)
            fedora_based_1 &&
            sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/34/winehq.repo &&
            fedora_based_2 &&
            select_your_path
            ;;
        11) 
            archlinux_1
            ;;
        12) 
            archlinux_1
            ;;
        13) 
            void-linux &&
            select_your_path
            ;;

esac
}

function select_your_path {

HEIGHT=15
WIDTH=200
CHOICE_HEIGHT=2
CHOICE_WIDTH=200
BACKTITLE="Installation of Autodesk Fusion360 - Version 2.8"
TITLE="Choose setup type"
MENU="Choose the kind of setup that best suits your needs."

OPTIONS=(1 "Standard - Install Autodesk Fusion 360 into your home folder. (/home/YOUR-USERNAME/.wine-prefixes/fusion360)"
         2 "Custom - Install Autodesk Fusion 360 to another place.")

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
            winetricks-standard
            ;;
        2)
            select_your_path_custom
            winetricks-custom
            ;;
esac
}


function select_your_path_custom {
    dialog --backtitle "Installation of Autodesk Fusion360 - Version 2.8" \
    --title "Description - Configure the installation location" \
    --msgbox 'Now you have to determine where you want to install Fusion 360 and then the .fusion360 folder will be created for you automatically. For examlble you can install it on a external usb-drive: /run/media/user/usb-drive/wine/.fusion360 or you install it into your home folder: /home/YOUR-USERNAME/.wine-prefixes/fusion360).' 14 200

    filename=$(dialog --stdout --title "Enter the installation path for Fusion 360:" --backtitle "Installation of Autodesk Fusion360 - Version 2.8" --fselect $HOME/ 14 100)
}

function program_exit {
    dialog --backtitle "Installation of Autodesk Fusion360 - Version 2.8" \
    --title "TAutodesk Fusion 360 is completed." \
    --msgbox 'The installation of Autodesk Fusion 360 is completed and you can use it for your projects.' 14 200
    
    exit
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

function archlinux_1 {

HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=2
BACKTITLE="Installation of Autodesk Fusion360 - Version 2.8"
TITLE="If you have enabled multilib repository?"
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
            archlinux_2 &&
            select_your_path
            ;;
        2)
            sudo echo "[multilib]" >> /etc/pacman.conf &&
            sudo echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf &&
            archlinux_2 &&
            select_your_path
            ;;
esac
}

function archlinux_2 {
   sudo pacman -Sy wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
}
   
function void-linux {
   sudo xbps-install -Sy wine wine-mono wine-gecko winetricks p7zip curl cabextract samba ppp
}

function winetricks-standard {
   clear
   mkdir -p /home/$USER/.wine-prefixes/fusion360 &&
   cd /home/$USER/.wine-prefixes/fusion360 &&
   wget -N https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks &&
   chmod +x winetricks &&
   WINEPREFIX=/home/$USER/.wine-prefixes/fusion360 sh winetricks -q corefonts msxml4 msxml6 vcrun2017 fontsmooth=rgb win8 &&
   mkdir -p fusion360-download &&
   cd fusion360-download &&
   wget -N https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360.exe &&
   WINEPREFIX=/home/$USER/.wine-prefixes/fusion360 wine Fusion360.exe -p deploy -g -f log.txt --quiet &&
   WINEPREFIX=/home/$USER/.wine-prefixes/fusion360 wine Fusion360.exe -p deploy -g -f log.txt --quiet &&
   mkdir -p "/home/$USER/.wine-prefixes/fusion360/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform" &&
   cd "/home/$USER/.wine-prefixes/fusion360/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform" &&
   mkdir -p Options &&
   cd Options &&
   wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml &&
   # # Because the location varies depending on the Linux distro!
   mkdir -p "/home/$USER/.wine-prefixes/fusion360/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform" &&
   cd "/home/$USER/.wine-prefixes/fusion360/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform" &&
   mkdir -p Options &&
   cd Options &&
   wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml &&
   program_exit
}

function winetricks-custom {
   clear
   mkdir -p $filename &&
   cd $filename &&
   wget -N https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks &&
   chmod +x winetricks &&
   WINEPREFIX=$filename sh winetricks -q corefonts msxml4 msxml6 vcrun2017 fontsmooth=rgb win8 &&
   mkdir -p fusion360-download &&
   cd fusion360-download &&
   wget -N https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360.exe &&
   WINEPREFIX=$filename wine Fusion360.exe -p deploy -g -f log.txt --quiet &&
   WINEPREFIX=$filename wine Fusion360.exe -p deploy -g -f log.txt --quiet &&
   mkdir -p "$filename/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform" &&
   cd "$filename/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform" &&
   mkdir -p Options &&
   cd Options &&
   wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml &&
   # # Because the location varies depending on the Linux distro!
   mkdir -p "$filename/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform" &&
   cd "$filename/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform" &&
   mkdir -p Options &&
   cd Options &&
   wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml &&
   program_exit
}

# ---------------------------------------------------------------------
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

clear
requirement-check-dialog
welcome_screen
