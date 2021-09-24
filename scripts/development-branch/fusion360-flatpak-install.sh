#!/bin/bash

########################################################################################
# Name:         Autodesk Fusion 360 - Installationsskript - Flatpak (Linux)            #
# Description:  With this file you can install Autodesk Fusion 360 on Linux.           #
# Author:       Steve Zabka                                                            #
# Author URI:   https://cryinkfly.com                                                  #
# License:      MIT                                                                    #
# Copyright (c) 2020-2021                                                              #
# Time/Date:    11:30/24.09.2021                                                       #
# Version:      1.0                                                                    #
########################################################################################

##############################################################################
# DESCRIPTION
##############################################################################

# With the help of my script, You get a way to install the Autodesk Fusion 360 on your Linux system. 
# Certain packages and programs that are required will be set up on your system.
#
# But it's important to know, that my script only helps You to get the program to run and nothing more!
#
# And so, You must to purchase the licenses directly from the manufacturer of the program Autodesk Fusion 360!

##############################################################################

############################################################################################################################################################
# 1. Step: Install Flatpak on your system: https://flatpak.org/setup/ (More information about FLatpak: https://youtu.be/SavmR9ZtHg0)
# 2. Step: Open a Terminal and run this command: cd Downloads && chmod +x fusion360-flatpak-install.sh && bash fusion360-flatpak-install.sh
# 3. Step: The installation will now start and set up everything for you automatically.
# 4. Step: Now you can use my other file "fusion360-flatpak-start.sh" for running Autodesk Fusion 360 on your system.
############################################################################################################################################################

############################################################################################################################################################
# The next two steps are also very important for you, because on some Linux Distrubition you dosn't get to work Flatpak without these steps!!!
############################################################################################################################################################

# 1. Step: Open a Terminal and run this command sudo nano /etc/hosts (Change this file wihtout # !)

#     127.0.0.1     localhost
#     127.0.1.1     EXAMPLE-NAME
     
#     ::1 ip6-localhost ip6-loopback
#     fe00::0 ip6-localnet
#     ff00::0 ip6-mcastprefix
#     ff02::1 ip6-allnodes
#     ff02::2 ip6-allrouters
#     ff02::3 ip6-allhosts

# 2. Step: Run this command: sudo nano /etc/hostname (Change this file wihtout # !)

#    EXAMPLE-NAME

# 3. Step: Reboot your system!

############################################################################################################################################################

##############################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:
##############################################################################

# Here all languages are called up via an extra language file for the installation!

function languages {
    wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/scripts/development-branch/languages-flatpak.sh &&
    chmod +x languages-flatpak.sh &&
    clear &&
    . languages-flatpak.sh
}

##############################################################################

# The minimum requirements for installing Autodesk Fusion 360 will be installed here!
# Prompt user to consent to required packages: dialog, wmctrl
function check-requirement {
echo "$text_1" # State packages to be installed
echo -n "$text_1_1" # Prompt yes/no
read answer
if [ "$answer" != "${answer#[YyJj]}" ] ;then
    install-requirement && # Call function to install packages
    wmctrl -r ':ACTIVE:' -b toggle,fullscreen && # Maximize the window of the terminal
    echo "No Error!" # This is in place to allow the script to continue (Workaround for a bug)
    flathub # Next stage in the process
else
    exit;
fi
}

# Decide which package manager is in use, and install the packages
function install-requirement {
if VERB="$( which apt-get )" 2> /dev/null; then
   echo "Debian-based"
   sudo apt-get update &&
   sudo apt-get install dialog wmctrl software-properties-common
elif VERB="$( which dnf )" 2> /dev/null; then
   echo "RedHat-based"
   sudo dnf update &&
   sudo dnf install dialog wmctrl
elif VERB="$( which pacman )" 2> /dev/null; then
   echo "Arch-based"
   sudo pacman -Sy --needed dialog wmctrl
elif VERB="$( which zypper )" 2> /dev/null; then
   echo "openSUSE-based"
   su -c 'zypper up && zypper install dialog wmctrl'
elif VERB="$( which xbps-install )" 2> /dev/null; then
   echo "Void-based"
   sudo xbps-install -Sy dialog wmctrl
elif VERB="$( which eopkg )" 2> /dev/null; then
   echo "Solus-based"
   sudo eopkg install dialog wmctrl
elif VERB="$( which emerge )" 2> /dev/null; then
    echo "Gentoo-based"
    sudo emerge -av dev-util/dialog x11-misc/wmctrl
else
   echo "I can't find your package manager!"
   exit;
fi
}

##############################################################################

function flathub {
    # Add the Flathub repository for your current user!!!
    echo "Add the Flathub repository"
    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo &&
    flatpak -y --user install flathub                          \
        org.freedesktop.Platform/x86_64/20.08                  \
        org.freedesktop.Platform.Compat.i386/x86_64/20.08      \
        org.freedesktop.Platform.GL32.default/x86_64/20.08     \
        org.freedesktop.Platform.GL.default/x86_64/20.08       \
        org.freedesktop.Platform.VAAPI.Intel.i386/x86_64/20.08 \
        org.freedesktop.Platform.VAAPI.Intel/x86_64/20.08      \
        org.freedesktop.Platform.ffmpeg_full.i386/x86_64/20.08 \
        org.freedesktop.Platform.ffmpeg-full/x86_64/20.08

#Install some packages for Nvidia users
if [ -f /proc/driver/nvidia/version ]; then
echo "Install some packages for your Nvidia graphics card!"
    ver=$(nvidia-settings -q all |grep OpenGLVersion|grep NVIDIA|sed 's/.*NVIDIA \(.*\) /nvidia-\1/g'|sed 's/\./-/g')
    flatpak -y --user install flathub                 \
        org.freedesktop.Platform.GL.$ver   \
        org.freedesktop.Platform.GL32.$ver
fi
echo "Installation of some packages for your graphics card is completed!"

#Install a special Wine-Version (org.winehq.flatpak-proton-68-ge-1)
echo "Install a special Wine-Version!"
wget -N https://github.com/fastrizwaan/flatpak-wine-releases/releases/download/6.8-20210510/org.winehq.flatpak-proton-68-ge-1-6.8-20210510.flatpak &&
flatpak -y --user install flathub org.winehq.flatpak-proton-68-ge-1 &&
welcome-screen-1
}

##############################################################################

# Here you have to decide whether you want to use Autodesk Fusion 360 with DXVK (DirectX 9) or OpenGL! - Part 2

function configure-dxvk-or-opengl-standard-1 {
  if [ $driver_used -eq 2 ]; then
      WINEPREFIX=/home/$USER/.wineprefixes/fusion360 sh winetricks -q dxvk &&
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/DXVK.reg &&
      WINEPREFIX=/home/$USER/.wineprefixes/fusion360 wine regedit.exe DXVK.reg
   fi
}

function configure-dxvk-or-opengl-standard-2 {
if [ $driver_used -eq 2 ]; then
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/DXVK.xml &&
      mv DXVK.xml NMachineSpecificOptions.xml
   else
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml
   fi
}

function configure-dxvk-or-opengl-standard-3 {
if [ $driver_used -eq 2 ]; then
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/DXVK.xml &&
      mv DXVK.xml NMachineSpecificOptions.xml
   else
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml
   fi
}

##############################################################################

function winetricks-standard {
    echo "Winetricks isntall some packages for you!"
    clear &&
    flatpak run org.winehq.flatpak-proton-68-ge-1 winetricks -q corefonts cjkfonts msxml4 msxml6 vcrun2017 fontsmooth=rgb win8 &&
    # We must install cjkfonts again then sometimes it doesn't work the first time!
    flatpak run org.winehq.flatpak-proton-68-ge-1 winetricks -q cjkfonts &&
    configure-dxvk-or-opengl-standard-1 &&
    flatpak run org.winehq.flatpak-proton-68-ge-1 bash &&
    cd $HOME/Downloads &&
    mkdir -p fusion360download &&
    cd fusion360download &&
    wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360installer.exe &&
    wine Fusion360installer.exe -p deploy -g -f log.txt --quiet &&
    wine Fusion360installer.exe -p deploy -g -f log.txt --quiet &&
    mkdir -p "$HOME/.local/share/flatpak-proton-68-ge-1/default/drive_c/users/steamuser/AppData/Roaming/Autodesk/Neutron Platform" &&
    cd "$HOME/.local/share/flatpak-proton-68-ge-1/default/drive_c/users/steamuser/AppData/Roaming/Autodesk/Neutron Platform" &&
    mkdir -p Options &&
    cd Options &&
    configure-dxvk-or-opengl-standard-2 &&
    # Because the location varies depending on the Linux distro!
    mkdir -p "$HOME/.local/share/flatpak-proton-68-ge-1/default/drive_c/users/steamuser/Application Data/Autodesk/Neutron Platform" &&
    cd "$HOME/.local/share/flatpak-proton-68-ge-1/default/drive_c/users/steamuser/Application Data/Autodesk/Neutron Platform" &&
    mkdir -p Options &&
    cd Options &&
    configure-dxvk-or-opengl-standard-3 &&
    program-exit
}

##############################################################################

function logfile-installation {
   mkdir -p "/$HOME/.local/share/flatpakfusion360/logfiles" && 
   exec 5> /$HOME/.local/share/flatpakfusion360/logfiles/install-log.txt
   BASH_XTRACEFD="5"
   set -x
}

##############################################################################
# ALL DIALOGS ARE ARRANGED HERE:
##############################################################################

# Autodesk Fusion 360 will be installed from scratch on this system!

function welcome-screen-1 {

HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=2
BACKTITLE="$text_2"
TITLE="$text_2_1"
MENU="$text_2_2"

OPTIONS=(1 "$text_2_3"
         2 "$text_2_4")

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
            
            driver_used=0 &&
            select-dxvk-or-opengl
            ;;
        2)
            exit
            ;;
esac
}

##############################################################################

# Here you have to decide whether you want to use Autodesk Fusion 360 with DXVK (DirectX 9) or OpenGL! - Part 1

function select-dxvk-or-opengl {
HEIGHT=15
WIDTH=200
CHOICE_HEIGHT=10
BACKTITLE="$text_4"
TITLE="$text_4_1"
MENU="$text_4_2"

OPTIONS=(1 "$text_4_3"
         2 "$text_4_4")

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

            driver_used=1 &&
            winetricks-standard
            ;;
            
        2)
        
            driver_used=2 &&
            winetricks-standard
            ;;  
esac     
}

##############################################################################

# The installation is complete and will be terminated.

function program-exit {
    dialog --backtitle "$text_11" \
    --title "$text_11_1" \
    --msgbox "$text_11_2" 14 200
    
    clear
    exit
}

##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

logfile-installation &&
clear &&
languages &&
check-requirement

############################################################################################################################################################
