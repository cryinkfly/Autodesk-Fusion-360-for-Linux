##############################################################################
# Name:         Autodesk Fusion 360 - Installationsskript (Linux)            #
# Description:  With this file you can install Autodesk Fusion 360 on Linux. #
# Author:       Steve Zabka                                                  #
# Author URI:   https://cryinkfly.com                                        #
# License:      MIT                                                          #
# Copyright (c) 2020-2021                                                    #
# Time/Date:    03:15/11.09.2021                                             #
# Version:      4.2                                                          #
##############################################################################

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
# 1. Step: Open a Terminal and run this command: cd Downloads && chmod +x fusion360-install.sh && bash fusion360-install.sh
# 2. Step: The installation will now start and set up everything for you automatically!
############################################################################################################################################################

##############################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:
##############################################################################

# Here you can select the language for the installation! (Is still in process!)

function select-language {
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8
}

##############################################################################

# The minimum requirements for installing Autodesk Fusion 360 will be installed here!

function check-requirement {
echo "Find your correct package manager and install the package dialog and wmctrl, what you need for the installation of Autodesk Fusion 360!"
echo -n "Do you wish to install this package (y/n)?"
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    install-requirement &&
    wmctrl -r ':ACTIVE:' -b toggle,fullscreen &&
    check-if-fusion360-exists
else
    exit;
fi
}

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
    sudo emerge -av dev-utils/dialog x11-misc/wmctrl
else
   echo "I can't find your package manager!"
   exit;
fi
}

##############################################################################

# It will check whether Autodesk Fusion 360 is already installed on your system or not!

function check-if-fusion360-exists {
FILE=/$HOME/.local/share/fusion360/logfiles/path-log.txt
if [ -f "$FILE" ]; then
    welcome-screen-2
else 
    welcome-screen-1
fi
}

##############################################################################

# Autodesk Fusion 360 will be installed from scratch on this system!

function welcome-screen-1 {

HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=2
BACKTITLE="Installation of Autodesk Fusion360 - Version 4.2"
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
BACKTITLE="Installation of Autodesk Fusion360 - Version 4.2"
TITLE="This Setup has checked your system for a existing Autodesk Fusion 360 components and it was found that Autodesk Fusion 360 already exists on your system!"
MENU="Choose one of the following options:"

OPTIONS=(1 "New installation of some or all components"
         2 "Update existing installation"
         3 "Uninstall all Autodesk Fusion 360 components")

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
BACKTITLE="Installation of Autodesk Fusion360 - Version 4.2"
TITLE="Select preferred driver"
MENU="Choose one of the following options:"

OPTIONS=(1 "OpenGL (default, choose this if you're not sure)"
         2 "DXVK (choose this if you want to use Intel GPU)")

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

# For the installation of Autodesk Fusion 360 one of the supported Linux distributions must be selected! - Part 1

function select-your-os {
HEIGHT=15
WIDTH=200
CHOICE_HEIGHT=10
BACKTITLE="Installation of Autodesk Fusion360 - Version 4.2"
TITLE="Select your Linux distribution"
MENU="Choose one of the following options:"

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
         15 "Void Linux"
         16 "Gentoo Linux")

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
            echo "deb [signed-by=/etc/apt/trusted.gpg.d/opensuse-wine.gpg] https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_21.04/ ./" | sudo tee -a /etc/apt/sources.list.d/opensuse-wine.list
            sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ hirsute main' &&
            debian-based-2
            ;;
            
        15)
        
            void-linux &&
            select-your-path
            ;;

        16)

            gentoo-linux &&
            select-your-path
            ;;

esac
}

##############################################################################

# For the installation of Autodesk Fusion 360 one of the supported Linux distributions must be selected! - Part 2

function archlinux-1 {

HEIGHT=15
WIDTH=60
CHOICE_HEIGHT=2
BACKTITLE="Installation of Autodesk Fusion360 - Version 4.2"
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
            archlinux-2 &&
            select-your-path
            ;;
        2)
            sudo echo "[multilib]" >> /etc/pacman.conf &&
            sudo echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf &&
            archlinux-2 &&
            select-your-path
            ;;
esac
}

function archlinux-2 {
   sudo pacman -Sy --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
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

# Here you can determine how Autodesk Fusion 360 should be instierlert! (Installation location)

function select-your-path {

HEIGHT=15
WIDTH=200
CHOICE_HEIGHT=2
CHOICE_WIDTH=200
BACKTITLE="Installation of Autodesk Fusion360 - Version 4.2"
TITLE="Choose setup type"
MENU="Choose the kind of setup that best suits your needs."

OPTIONS=(1 "Standard - Install Autodesk Fusion 360 into your home folder. (/home/YOUR-USERNAME/.wineprefixes/fusion360)"
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
            select-your-path-custom &&
            winetricks-custom
            ;;
esac
}


function select-your-path-custom {
    dialog --backtitle "Installation of Autodesk Fusion360 - Version 4.2" \
    --title "Description - Configure the installation location" \
    --msgbox 'Now you have to determine where you want to install Fusion 360 and then the .fusion360 folder will be created for you automatically. For examlble you can install it on a external usb-drive: /run/media/user/usb-drive/wine/.fusion360 or you install it into your home folder: /home/YOUR-USERNAME/.wineprefixes/fusion360).' 14 200

    filename=$(dialog --stdout --title "Enter the installation path for Fusion 360:" --backtitle "Installation of Autodesk Fusion360 - Version 4.2" --fselect $HOME/ 14 100)
}

##############################################################################

# Autodesk Fusion 360 will now be installed using Wine and Winetricks!

function winetricks-standard {
   clear
   mkdir -p /home/$USER/.wineprefixes/fusion360 &&
   cd /home/$USER/.wineprefixes/fusion360 &&
   wget -N https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks &&
   chmod +x winetricks &&
   WINEPREFIX=/home/$USER/.wineprefixes/fusion360 sh winetricks -q corefonts cjkfonts msxml4 msxml6 vcrun2017 fontsmooth=rgb win8 &&
   # We must install cjkfonts again then sometimes it doesn't work the first time!
   WINEPREFIX=/home/$USER/.wineprefixes/fusion360 sh winetricks -q cjkfonts &&
   configure-dxvk-or-opengl-standard-1 &&
   mkdir -p fusion360download &&
   cd fusion360download &&
   wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360installer.exe &&
   WINEPREFIX=/home/$USER/.wineprefixes/fusion360 wine Fusion360installer.exe -p deploy -g -f log.txt --quiet &&
   WINEPREFIX=/home/$USER/.wineprefixes/fusion360 wine Fusion360installer.exe -p deploy -g -f log.txt --quiet &&
   mkdir -p "/home/$USER/.wineprefixes/fusion360/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform" &&
   cd "/home/$USER/.wineprefixes/fusion360/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform" &&
   mkdir -p Options &&
   cd Options &&
   configure-dxvk-or-opengl-standard-2 &&
   # Because the location varies depending on the Linux distro!
   mkdir -p "/home/$USER/.wineprefixes/fusion360/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform" &&
   cd "/home/$USER/.wineprefixes/fusion360/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform" &&
   mkdir -p Options &&
   cd Options &&
   configure-dxvk-or-opengl-standard-3 &&
   #Set up the program launcher for you!
   cd "/$HOME/.local/share/applications" &&
   wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/Autodesk%20Fusion%20360.desktop &&
   logfile-installation-standard &&
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
   program-exit
}

##############################################################################

# Update/Repair existing installation of Autodesk Fusion 360 on your system!

function change-fusion360-1 {
    dialog --title "Make a note of the path to your Autodesk Fusion 360 installation so that you can use it in the next step!" --textbox "/$HOME/.local/share/fusion360log/log.txt" 14 180
}

function change-fusion360-2 {
    filename=$(dialog --stdout --title "Enter the installation path for Fusion 360:" --backtitle "Installation of Autodesk Fusion360 - Version 4.2" --fselect $HOME/ 14 100)
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

# The uninstallation is complete and will be terminated.

function program-exit-uninstall {
    dialog --backtitle "Installation of Autodesk Fusion360 - Version 4.2" \
    --title "Uninstalling Autodesk Fusion 360!" \
    --msgbox 'Autodesk Fusion 360 uninstallation is complete!' 14 200
    
    clear
    exit
}

##############################################################################

# The installation is complete and will be terminated.

function program-exit {
    dialog --backtitle "Installation of Autodesk Fusion360 - Version 4.2" \
    --title "Autodesk Fusion 360 is completed." \
    --msgbox 'The installation of Autodesk Fusion 360 is completed and you can use it for your projects.' 14 200
    
    clear
    exit
}

##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

logfile-installation &&
clear &&
select-language &&
check-requirement

############################################################################################################################################################
