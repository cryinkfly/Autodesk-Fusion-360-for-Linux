#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you can install Autodesk Fusion 360 on various Linux distributions. #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2021                                                                          #
# Time/Date:    18:00/28.09.2021                                                                   #
# Version:      5.1                                                                                #
####################################################################################################

##############################################################################
# DESCRIPTION IN DETAIL
##############################################################################

# With the help of my setup wizard, you will be given a way to install Autodesk Fusion 360 with some extensions on 
# Linux so that you don't have to use Windows or macOS for this program in the future!
#
# Also, my setup wizard will guides you through the installation step by step and will install some required packages.
#
# The next one is you have the option of installing the program directly on your system or you can install it on an external storage medium.
#
# But it's important to know, you must to purchase the licenses directly from the manufacturer of Autodesk Fusion 360, when
# you will work with them on Linux!

############################################################################################################################################################
# 1. Step: Open a Terminal and run this command: cd Downloads && chmod +x fusion360-install.sh && bash fusion360-install.sh
# 2. Step: The installation will now start and set up everything for you automatically!
############################################################################################################################################################

##############################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:
##############################################################################

# Here all languages are called up via an extra language file for the installation!

function languages {
    wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/scripts/stable-branch/languages.sh &&
    chmod +x languages.sh &&
    clear &&
    . languages.sh
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
    check-if-fusion360-exists # Next stage in the process
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

# It will check whether Autodesk Fusion 360 is already installed on your system or not!

function check-if-fusion360-exists {
FILE=/$HOME/.local/share/fusion360/logfiles/path-log.txt # Search for log files indicting install
if [ -f "$FILE" ]; then
    welcome-screen-2 # Exists - Modify install
else 
    welcome-screen-1 # New install
fi
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

function configure-dxvk-or-opengl-custom-1 {
   if [ $driver_used -eq 2 ]; then
      WINEPREFIX=$filename sh winetricks -q dxvk &&
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/DXVK.reg &&
      WINEPREFIX=$filename wine regedit.exe DXVK.reg
   else
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml
   fi
}

function configure-dxvk-or-opengl-custom-2 {
if [ $driver_used -eq 2 ]; then
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/DXVK.xml &&
      mv DXVK.xml NMachineSpecificOptions.xml
   else
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml
   fi
}

function configure-dxvk-or-opengl-custom-3 {
if [ $driver_used -eq 2 ]; then
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/DXVK.xml &&
      mv DXVK.xml NMachineSpecificOptions.xml
   else
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml
   fi
}

##############################################################################

# For the installation of Autodesk Fusion 360 one of the supported Linux distributions must be selected! - Part 2

function archlinux-1 {
    echo "Checking for multilib..."
    if archlinux-verify-multilib ; then
        echo "multilib found. Continuing..."
        archlinux-2 &&
        select-your-path
    else
        echo "Enabling multilib..."
        echo "[multilib]" | sudo tee -a /etc/pacman.conf &&
        echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf &&
        archlinux-2 &&
        select-your-path
    fi
}

function archlinux-2 {
   sudo pacman -Sy --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
}

function archlinux-verify-multilib {
    if cat /etc/pacman.conf | grep -q '^\[multilib\]$' ; then
        true
    else
        false
    fi
}
   
function debian-based-1 {
    sudo apt-get update &&
    sudo apt-get upgrade &&
    sudo dpkg --add-architecture i386  &&
    wget -nc https://dl.winehq.org/wine-builds/winehq.key &&
    sudo apt-key add winehq.key
}

function debian-based-2 {
    sudo apt-get update &&
    sudo apt-get upgrade &&
    sudo apt-get install p7zip p7zip-full p7zip-rar curl winbind cabextract wget &&
    sudo apt-get install --install-recommends winehq-staging &&
    select-your-path
}

function fedora-based-1 {
    sudo dnf update &&
    sudo dnf upgrade &&
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}

function fedora-based-2 {
    sudo dnf install p7zip p7zip-plugins curl wget wine cabextract &&
    select-your-path
}

function redhat-linux {
   sudo subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms &&
   sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm &&
   sudo dnf upgrade &&
   sudo dnf install wine
}

function solus-linux {
   sudo eopkg install wine winetricks p7zip curl cabextract samba ppp
}

function void-linux {
   sudo xbps-install -Sy wine wine-mono wine-gecko winetricks p7zip curl cabextract samba ppp
}

function gentoo-linux {
    sudo emerge -av virtual/wine app-emulation/winetricks app-emulation/wine-mono app-emulation/wine-gecko app-arch/p7zip app-arch/cabextract net-misc/curl net-fs/samba net-dialup/ppp
}

##############################################################################

# Autodesk Fusion 360 will now be installed using Wine and Winetricks!

function winetricks-standard {
   clear
   mkdir -p $HOME/.wineprefixes/fusion360 &&
   cd $HOME/.wineprefixes/fusion360 &&
   wget -N https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks &&
   chmod +x winetricks &&
   WINEPREFIX=$HOME/.wineprefixes/fusion360 sh winetricks -q corefonts cjkfonts msxml4 msxml6 vcrun2017 fontsmooth=rgb win8 &&
   # We must install cjkfonts again then sometimes it doesn't work the first time!
   WINEPREFIX=$HOME/.wineprefixes/fusion360 sh winetricks -q cjkfonts &&
   configure-dxvk-or-opengl-standard-1 &&
   mkdir -p fusion360download &&
   cd fusion360download &&
   wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360installer.exe &&
   WINEPREFIX=$HOME/.wineprefixes/fusion360 wine Fusion360installer.exe -p deploy -g -f log.txt --quiet &&
   WINEPREFIX=$HOME/.wineprefixes/fusion360 wine Fusion360installer.exe -p deploy -g -f log.txt --quiet &&
   mkdir -p "$HOME/.wineprefixes/fusion360/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform" &&
   cd "$HOME/.wineprefixes/fusion360/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform" &&
   mkdir -p Options &&
   cd Options &&
   configure-dxvk-or-opengl-standard-2 &&
   # Because the location varies depending on the Linux distro!
   mkdir -p "$HOME/.wineprefixes/fusion360/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform" &&
   cd "$HOME/.wineprefixes/fusion360/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform" &&
   mkdir -p Options &&
   cd Options &&
   configure-dxvk-or-opengl-standard-3 &&
   #Set up the program launcher for you!
   cd "$HOME/.local/share/applications" &&
   wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/Autodesk%20Fusion%20360.desktop &&
   logfile-installation-standard &&
   install-extensions-standard &&
   program-exit
}

function winetricks-custom {
   clear
   mkdir -p $filename &&
   cd $filename &&
   wget -N https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks &&
   chmod +x winetricks &&
   WINEPREFIX=$filename sh winetricks -q corefonts cjkfonts msxml4 msxml6 vcrun2017 fontsmooth=rgb win8 &&
   # We must install cjkfonts again then sometimes it doesn't work the first time!
   WINEPREFIX=$filename sh winetricks -q cjkfonts &&
   configure-dxvk-or-opengl-custom-1 &&
   mkdir -p fusion360download &&
   cd fusion360download &&
   wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360installer.exe &&
   WINEPREFIX=$filename wine Fusion360installer.exe -p deploy -g -f log.txt --quiet &&
   WINEPREFIX=$filename wine Fusion360installer.exe -p deploy -g -f log.txt --quiet &&
   mkdir -p "$filename/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform" &&
   cd "$filename/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform" &&
   mkdir -p Options &&
   cd Options &&
   configure-dxvk-or-opengl-custom-2 &&
   # Because the location varies depending on the Linux distro!
   mkdir -p "$filename/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform" &&
   cd "$filename/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform" &&
   mkdir -p Options &&
   cd Options &&
   configure-dxvk-or-opengl-custom-3 &&
   logfile-installation-custom &&
   install-extensions-custom &&
   program-exit
}

##############################################################################

# A log file will now be created here so that it can be checked in the future whether an installation of Autodesk Fusion 360 already exists on your system.

function logfile-installation {
   mkdir -p "/$HOME/.local/share/fusion360/logfiles" && 
   exec 5> /$HOME/.local/share/fusion360/logfiles/install-log.txt
   BASH_XTRACEFD="5"
   set -x
}

function logfile-installation-standard {
   mkdir -p "/$HOME/.local/share/fusion360/logfiles" &&
   cd "/$HOME/.local/share/fusion360/logfiles" &&
   echo "/home/$USER/.wineprefixes/fusion360/logfiles" >> path-log.txt
}

function logfile-installation-custom {
   mkdir -p "/$HOME/.local/share/fusion360/logfiles" &&
   cd "/$HOME/.local/share/fusion360/logfiles" &&
   echo "$filename" >> path-log.txt
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

# Autodesk Fusion 360 has already been installed on your system and you will now be given various options to choose from!

function welcome-screen-2 {

HEIGHT=15
WIDTH=180
CHOICE_HEIGHT=3
BACKTITLE="$text_3"
TITLE="$text_3_1"
MENU="$text_3_2"

OPTIONS=(1 "$text_3_3"
         2 "$text_3_4"
         3 "$text_3_5")

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
            change-fusion360-1 &&
            change-fusion360-2 &&
            cd $filename/fusion360download &&
            WINEPREFIX=$filename wine Fusion360installer.exe -p deploy -g -f log.txt --quiet &&
            WINEPREFIX=$filename wine Fusion360installer.exe -p deploy -g -f log.txt --quiet &&
            install-extensions &&
            program-exit
            ;;
        3)
            change-fusion360-1 &&
            change-fusion360-2 &&
            rmdir "$filename" &&
            # Remove this path into the log file is still in process! 
            program-exit-uninstall
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
            select-your-os
            ;;
            
        2)
        
            driver_used=2 &&
            select-your-os
            ;;  
esac     
}

##############################################################################

# For the installation of Autodesk Fusion 360 one of the supported Linux distributions must be selected! - Part 1

function select-your-os {
HEIGHT=15
WIDTH=200
CHOICE_HEIGHT=10
BACKTITLE="$text_5"
TITLE="$text_5_1"
MENU="$text_5_2"

OPTIONS=(1 "Arch Linux, Manjaro Linux, EndeavourOS, ..."
         2 "Debian 10, MX Linux 19.4, Raspberry Pi Desktop, ..."
         3 "Debian 11"
         4 "Fedora 33"
         5 "Fedora 34"
         6 "openSUSE Leap 15.2"
         7 "openSUSE Leap 15.3"
         8 "openSUSE Tumbleweed"
         9 "Red Hat Enterprise Linux 8.x"
         10 "Solus"
         11 "Ubuntu 18.04, Linux Mint 19.x, ..."
         12 "Ubuntu 20.04, Linux Mint 20.x, Pop!_OS 20.04, ..."
         13 "Ubuntu 20.10"
         14 "Ubuntu 21.04, Pop!_OS 21.04, ..."
         15 "Ubuntu 21.10"
         16 "Void Linux"
         17 "Gentoo Linux")

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
            
            archlinux-1
            ;;
            
        2)
        
            debian-based-1 &&
            sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ buster main' &&
            debian-based-2
            ;;  
            
        3)
        
            debian-based-1 &&
            sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ bullseye main' &&
            debian-based-2
            ;;  
            
        4)
            
            fedora-based-1 &&
            sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/33/winehq.repo &&
            fedora-based-2
            ;;  
            
        5) 
        
            fedora-based-1 &&
            sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/34/winehq.repo &&
            fedora-based-2
            ;;  
        
        6)
        
            su -c 'zypper up && zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.2/ wine && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.2/ wine && zypper install p7zip-full curl wget wine cabextract' &&
            select-your-path
            ;;
            
        7)
            
            su -c 'zypper up && zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.3/ wine && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.3/ wine && zypper install p7zip-full curl wget wine cabextract' &&
            select-your-path
            ;;  
            
        8)
            
            su -c 'zypper up && zypper install p7zip-full curl wget wine cabextract' &&
            select-your-path
            ;;    
            
        9)
        
            redhat-linux &&
            select-your-path
            ;;
            
        10)
        
            solus-linux &&
            select-your-path
            ;;
            
        11) 
        
            debian-based-1 &&
            sudo apt-add-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main' &&
            wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/Release.key -O Release.key -O- | sudo apt-key add - &&
            sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/ ./' &&
            debian-based-2
            ;;
            
        12) 
            
            debian-based-1 &&
            sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' &&
            wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_20.04/Release.key -O Release.key -O- | sudo apt-key add - &&
            sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_20.04/ ./' &&
            debian-based-2
            ;;
            
        13) 
        
            debian-based-1 &&
            sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ groovy main' &&
            wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_20.10/Release.key -O Release.key -O- | sudo apt-key add - &&
            sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_20.10/ ./' &&
            debian-based-2
            ;;
            
        14)

            # Note: This installs the public key to trusted.gpg.d - While this is "acceptable" behaviour it is not best practice.
            # It is infinitely better than using apt-key add though.
            # For more information and for instructions to utalise best practices, see:
            # https://askubuntu.com/questions/1286545/what-commands-exactly-should-replace-the-deprecated-apt-key
            
            sudo apt update &&
            sudo apt upgrade &&
            sudo dpkg --add-architecture i386  &&
            mkdir -p /tmp/360 && cd /tmp/360 &&
            wget https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_21.04/Release.key &&
            wget https://dl.winehq.org/wine-builds/winehq.key &&
            gpg --no-default-keyring --keyring ./temp-keyring.gpg --import Release.key &&
            gpg --no-default-keyring --keyring ./temp-keyring.gpg --export --output opensuse-wine.gpg && rm temp-keyring.gpg &&
            gpg --no-default-keyring --keyring ./temp-keyring.gpg --import winehq.key &&
            gpg --no-default-keyring --keyring ./temp-keyring.gpg --export --output winehq.gpg && rm temp-keyring.gpg &&
            sudo mv *.gpg /etc/apt/trusted.gpg.d/ && cd /tmp && sudo rm -rf 360 &&
            echo "deb [signed-by=/etc/apt/trusted.gpg.d/opensuse-wine.gpg] https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_21.04/ ./" | sudo tee -a /etc/apt/sources.list.d/opensuse-wine.list &&
            sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ hirsute main' &&
            debian-based-2
            ;;

        15)

            # Note: This installs the public key to trusted.gpg.d - While this is "acceptable" behaviour it is not best practice.
            # It is infinitely better than using apt-key add though.
            # For more information and for instructions to utalise best practices, see:
            # https://askubuntu.com/questions/1286545/what-commands-exactly-should-replace-the-deprecated-apt-key
            
            sudo apt update &&
            sudo apt upgrade &&
            sudo dpkg --add-architecture i386  &&
            mkdir -p /tmp/360 && cd /tmp/360 &&
            wget https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_21.04/Release.key &&
            wget https://dl.winehq.org/wine-builds/winehq.key &&
            gpg --no-default-keyring --keyring ./temp-keyring.gpg --import Release.key &&
            gpg --no-default-keyring --keyring ./temp-keyring.gpg --export --output opensuse-wine.gpg && rm temp-keyring.gpg &&
            gpg --no-default-keyring --keyring ./temp-keyring.gpg --import winehq.key &&
            gpg --no-default-keyring --keyring ./temp-keyring.gpg --export --output winehq.gpg && rm temp-keyring.gpg &&
            sudo mv *.gpg /etc/apt/trusted.gpg.d/ && cd /tmp && sudo rm -rf 360 &&

            # Use 21.04 software prior to 21.10 release. Replace this with the below block after release.
            echo "deb [signed-by=/etc/apt/trusted.gpg.d/opensuse-wine.gpg] https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_21.04/ ./" | sudo tee -a /etc/apt/sources.list.d/opensuse-wine.list &&
            sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ hirsute main' &&
            
            # Verify the below repos exist and uncomment this block to replace the above after 21.10 release
            # echo "deb [signed-by=/etc/apt/trusted.gpg.d/opensuse-wine.gpg] https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_21.10/ ./" | sudo tee -a /etc/apt/sources.list.d/opensuse-wine.list &&
            # sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ impish main' &&

            debian-based-2
            ;;

            
        16)
        
            void-linux &&
            select-your-path
            ;;

        17)

            gentoo-linux &&
            select-your-path
            ;;

esac
}

##############################################################################

# Here you can determine how Autodesk Fusion 360 should be instierlert! (Installation location)

function select-your-path {

HEIGHT=15
WIDTH=200
CHOICE_HEIGHT=2
CHOICE_WIDTH=200
BACKTITLE="$text_7"
TITLE="$text_7_1"
MENU="$text_7_2"

OPTIONS=(1 "$text_7_3"
         2 "$text_7_4")

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
            select-your-path-custom &&
            winetricks-custom
            ;;
esac
}


function select-your-path-custom {
    dialog --backtitle "$text_8" \
    --title "$text_8_1" \
    --msgbox "$text_8_2" 14 200

    filename=$(dialog --stdout --title "$text_8_3" --backtitle "$text_8_4" --fselect $HOME/ 14 100)
}

##############################################################################

# Update/Repair existing installation of Autodesk Fusion 360 on your system!

function change-fusion360-1 {
    dialog --title "$text_9" --backtitle "$text_9_1" --textbox "$HOME/.local/share/fusion360log/log.txt" 14 180
}

function change-fusion360-2 {
    filename=$(dialog --stdout --title "$text_9_2" --backtitle "$text_9_3" --fselect $HOME/ 14 100)
}

##############################################################################

# The uninstallation is complete and will be terminated.

function program-exit-uninstall {
    dialog --backtitle "$text_10" \
    --title "$text_10_1" \
    --msgbox "$text_10_2" 14 200
    
    clear
    exit
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

# Installation of various extensions is offered here. For examble: OctoPrint for Autodesk® Fusion 360™

function install-extensions-standard {

cmd=(dialog --separate-output --backtitle "$text_12" --title "$text_12_1" --checklist "$text_12_2" 22 250 16)
options=(1 "$text_12_3" off    # any option can be set to default to "on"
         2 "$text_12_4" off
         3 "$text_12_5" off
         4 "$text_12_6" off
         5 "$text_12_7" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
            echo "Install Airfoil Tools!"
            airfoil-tools-plugin-standard
            ;;
        2)
            echo "Install Additive Assistant (FFF)!"
            additive-assistant-plugin-standard
            ;;
        3)
            echo "Install HP 3D Printers for Autodesk® Fusion 360™!"
            hp-3dprinter-connector-plugin-standard
            ;;
        4)
            echo "Install OctoPrint for Autodesk® Fusion 360™!"
            octoprint-plugin-standard
            ;;
        5)
            echo "Install RoboDK!"
            robodk-plugin-standard
            ;;
    esac
done
}

function install-extensions-custom {

cmd=(dialog --separate-output --backtitle "$text_12" --title "$text_12_1" --checklist "$text_12_2" 22 250 16)
options=(1 "$text_12_3" off    # any option can be set to default to "on"
         2 "$text_12_4" off
         3 "$text_12_5" off
         4 "$text_12_6" off
         5 "$text_12_7" off)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        1)
            echo "Install Airfoil Tools!"
            airfoil-tools-plugin-standard
            ;;
        2)
            echo "Install Additive Assistant (FFF)!"
            additive-assistant-plugin-standard
            ;;
        3)
            echo "Install HP 3D Printers for Autodesk® Fusion 360™!"
            hp-3dprinter-connector-plugin-standard
            ;;
        4)
            echo "Install OctoPrint for Autodesk® Fusion 360™!"
            octoprint-plugin-standard
            ;;
        5)
            echo "Install RoboDK!"
            robodk-plugin-standard
            ;;
    esac
done
}

##############################################################################
# ALL EXTENSIONS ARE HERE:
##############################################################################

# Airfoil Tools

function airfoil-tools-plugin-standard {
    mkdir -p "$HOME/.wineprefixes/fusion360/fusion360download/extensions"
    cd "$HOME/.wineprefixes/fusion360/fusion360download/extensions"
    wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/files/extensions/AirfoilTools_win64.msi &&
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine AirfoilTools_win64.msi
}

function airfoil-tools-plugin-custom {
    mkdir -p "$filename/fusion360download/extensions"
    cd "$filename/fusion360download/extensions"
    wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/files/extensions/AirfoilTools_win64.msi &&
    WINEPREFIX=$filename wine AirfoilTools_win64.msi
}

##############################################################################

# Additive Assistant (FFF)

function additive-assistant-plugin-standard {
    mkdir -p "$HOME/.wineprefixes/fusion360/fusion360download/extensions"
    cd "$HOME/.wineprefixes/fusion360/fusion360download/extensions"
    wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/files/extensions/AdditiveAssistant.bundle-win64.msi &&
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine AdditiveAssistant.bundle-win64.msi
}

function additive-assistant-plugin-custom {
    mkdir -p "$filename/fusion360download/extensions"
    cd "$filename/fusion360download/extensions"
    wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/files/extensions/AdditiveAssistant.bundle-win64.msi &&
    WINEPREFIX=$filename wine AdditiveAssistant.bundle-win64.msi
}

##############################################################################

# HP 3D Printers for Autodesk® Fusion 360™

function hp-3dprinter-connector-plugin-standard {
    mkdir -p "$HOME/.wineprefixes/fusion360/fusion360download/extensions"
    cd "$HOME/.wineprefixes/fusion360/fusion360download/extensions"
    wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/files/extensions/HP_3DPrinters_for_Fusion360-win64.msi &&
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine HP_3DPrinters_for_Fusion360-win64.msi
}

function hp-3dprinter-connector-plugin-custom {
    mkdir -p "$filename/fusion360download/extensions"
    cd "$filename/fusion360download/extensions"
    wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/files/extensions/HP_3DPrinters_for_Fusion360-win64.msi &&
    WINEPREFIX=$filename wine HP_3DPrinters_for_Fusion360-win64.msi
}

##############################################################################

# OctoPrint for Autodesk® Fusion 360™

function octoprint-plugin-standard {
    mkdir -p "$HOME/.wineprefixes/fusion360/fusion360download/extensions"
    cd "$HOME/.wineprefixes/fusion360/fusion360download/extensions"
    wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/files/extensions/OctoPrint_for_Fusion360-win64.msi &&
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine OctoPrint_for_Fusion360-win64.msi
}

function octoprint-plugin-custom {
    mkdir -p "$filename/fusion360download/extensions"
    cd "$filename/fusion360download/extensions"
    wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/files/extensions/OctoPrint_for_Fusion360-win64.msi &&
    WINEPREFIX=$filename wine OctoPrint_for_Fusion360-win64.msi
}

##############################################################################

# RoboDK

function robodk-plugin-standard {
    mkdir -p "$HOME/.wineprefixes/fusion360/fusion360download/extensions"
    cd "$HOME/.wineprefixes/fusion360/fusion360download/extensions"
    wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/files/extensions/RoboDK.bundle-win64.msi &&
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine RoboDK.bundle-win64.msi
}

function robodk-plugin-custom {
    mkdir -p "$filename/fusion360download/extensions"
    cd "$filename/fusion360download/extensions"
    wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/files/extensions/RoboDK.bundle-win64.msi &&
    WINEPREFIX=$filename wine RoboDK.bundle-win64.msi
}

##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

logfile-installation &&
clear &&
languages &&
check-requirement

############################################################################################################################################################
