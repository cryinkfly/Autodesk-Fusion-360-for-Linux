#!/bin/bash

############################################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                                                 #
# Description:  With this file you can install Autodesk Fusion 360 on different Linux distributions.                       #
# Author:       Steve Zabka                                                                                                #
# Author URI:   https://cryinkfly.com                                                                                      #
# License:      MIT                                                                                                        #
# Time/Date:    xx:xx/xx.xx.2023                                                                                           #
# Version:      1.9.0                                                                                                      #
# Requires:     dialog, wget, lsb-release, coreutils                                                                       #
############################################################################################################################

############################################################################################################################
# THE INITIALIZATION OF DEPENDENCIES AND CREATION OF THE STRUCTURES STARTS HERE:                                           #
############################################################################################################################

# Check if "dialog", "wget", ... are installed on the system:
function SP_CHECK_REQUIRED_COMMANDS {
    RED='\033[0;31m' # Set up the text color scheme in the terminal.
    NOCOLOR='\033[0m' # Reset the text color scheme in the terminal.
    SP_REQUIRED_COMMANDS=("dialog" "wget" "lsb-release" "cat")
    for cmd in "${SP_REQUIRED_COMMANDS[@]}"; do
        echo "Testing presence of ${cmd} ..."
        local path="$(command -v "${cmd}")"
        if [ -n "${path}" ]; then
            echo "All the packages needed to continue with the installation are present on the system."
            SP_PATH="$HOME/.fusion360" # Create the base structure for the installation.
            mkdir -p $SP_PATH/{bin,config,locale/{cs-CZ,de-DE,en-US,es-ES,fr-FR,it-IT,ja-JP,ko-KR,zh-CN},logs,cache,wineprefixes,resources/{extensions,graphics,music,downloads}}
            SP_LOG_INSTALLATION && SP_LOAD_LOCALE_INDEX && SP_CONFIG_LOCALE && SP_WELCOME
        else
            clear
            echo -e "${RED}The required packages 'dialog', 'wget', 'lsb-release' and 'coreutils' not installed on your system!${NOCOLOR}"
            read -p "Would you like to install these packages on your system to continue the installation of Autodesk Fusion 360? (y/n)" yn
            case $yn in 
	            y ) SP_INSTALL_REQUIRED_COMMANDS;
	                SP_REQUIRED_COMMANDS;;
	            n ) echo -e "${RED}Exiting ...";
		             exit;;
	            * ) echo -e "${RED}Invalid Response!${NOCOLOR}";
		            exit 1;;
            esac
        fi
    done;
}

############################################################################################################################

# The required packages are installed here:
function SP_INSTALL_REQUIRED_COMMANDS {
    if VERB="$( which apt-get )" 2> /dev/null; then
       echo "Debian-based" && sudo apt-get update && sudo apt-get install dialog wget lsb-release coreutils software-properties-common
    elif VERB="$( which dnf )" 2> /dev/null; then
       echo "RedHat-based" && sudo dnf update && sudo dnf install dialog wget lsb-release coreutils
    elif VERB="$( which pacman )" 2> /dev/null; then
       echo "Arch-based" && sudo pacman -Syu --needed dialog wget lsb-release coreutils
    elif VERB="$( which zypper )" 2> /dev/null; then
       echo "openSUSE-based" && sudo zypper up && sudo zypper in dialog wget lsb-release coreutils
    elif VERB="$( which xbps-install )" 2> /dev/null; then
       echo "Void-based" && sudo xbps-install -Sy dialog wget lsb-release coreutils
    elif VERB="$( which eopkg )" 2> /dev/null; then
       echo "Solus-based" && sudo eopkg install dialog wget lsb-release coreutils
    elif VERB="$( which emerge )" 2> /dev/null; then
       echo "Gentoo-based" && sudo emerge -av dev-util/dialog net-misc/wget sys-apps/lsb-release sys-apps/coreutils
    else
       echo "${RED}I can't find your package manager!${NOCOLOR}"
       exit;
    fi
}

###############################################################################################################################################################
# THE LOG-FUNCTION OF THE INSTALLATION IS ARRANGED HERE:                                                                                                      #
###############################################################################################################################################################

# Collects information in order to be able to carry out an error analysis later if necessary.
function SP_LOG_INSTALLATION {
    exec 5> "$SP_PATH/logs/setupact.log"
    BASH_XTRACEFD="5"
    set -x
}

###############################################################################################################################################################
# ALL LOG- & CHECK-FUNCTIONS OF WINE & WINEPREFIXES ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

# Checks if "Wine" exists in a specific version:
function SP_CHECK_REQUIRED_WINE_VERSION {
    SP_REQUIRED_WINE_VERSION=$(wine --version)
    if [[ $SP_REQUIRED_WINE_VERSION == *"wine-6.23"* ]] || [[ $SP_REQUIRED_WINE_VERSION == *"wine-7"* ]] || [[ $SP_REQUIRED_WINE_VERSION == *"wine-8"* ]]; then
        # OK
    else
        # Install packages ...
    fi
}

###############################################################################################################################################################

# Check if already exists a Autodesk Fusion 360 installation on your system.
function SP_LOGFILE_WINEPREFIX_CHECK {
    SP_FUSION360_WINEPREFIX_CHECK="$SP_PATH/logs/wineprefixes.log" # Search for wineprefixes.log
    if [ -f "$SP_FUSION360_WINEPREFIX_CHECK" ]; then
        cp "$SP_FUSION360_WINEPREFIX_CHECK" "$SP_PATH/cache"
        SP_LOGFILE_WINEPREFIX_INFO # Add/Modify or Delete a exists Wineprefix of Autodesk Fusion 360.
    else
        SP_INSTALLDIR # Add a new Wineprefix of Autodesk Fusion 360.
    fi
}

###############################################################################################################################################################

# Create a WP-TYPE for the .desktop-files:
function SP_GET_WINEPREFIX_TYPE {
    if [[ $WP_DIRECTORY = "$SP_PATH/wineprefixes/default" ]]; then
        WP_TYPE="default"
    else
        SP_ADD_CUSTOM_WINEPREFIX_TYPE # Create the directory (custom, custom-1, custom-2, ...)
    fi
}

###############################################################################################################################################################

# Create a new customized Wineprefix:
function SP_ADD_CUSTOM_WINEPREFIX_TYPE {
    WP_TYPE="custom"
    if [[ -e $WP_TYPE || -L $WP_TYPE ]] ; then
        i=0
        while [[ -e $WP_TYPE-$i || -L $WP_TYPE-$i ]] ; do
            (( i++ ))
        done
        WP_TYPE=$WP_TYPE-$i
    fi
}

###############################################################################################################################################################

# Saves the most important parameters from the past Wineprefix installation.
function SP_LOGFILE_WINEPREFIX {
    if [ $SP_FUSION360_CHANGE -eq 1 ]; then
        echo "FALSE" >> "$SP_PATH/logs/wineprefixes.log"
        echo "$WP_TYPE" >> "$SP_PATH/logs/wineprefixes.log"
        echo "$WP_DRIVER" >> "$SP_PATH/logs/wineprefixes.log"
        echo "$WP_DIRECTORY" >> "$SP_PATH/logs/wineprefixes.log"
    fi
}

###############################################################################################################################################################

# Check if this wineprefix already exist or not!
function SP_INSTALLDIR_CHECK {
    WP_PATH_CHECK="$WP_DIRECTORY/box-run.sh"
    if [[ -f "$WP_PATH_CHECK" ]]; then
        echo "FALSE"
        SP_INSTALLDIR_INFO
    else
        echo "TRUE"
        SP_FUSION360_CHANGE=1
        SP_WINE_SETTINGS
    fi
}

###############################################################################################################################################################
# ALL LOCALE-FUNCTIONS ARE ARRANGED HERE:                                                                                                                     #
###############################################################################################################################################################

# Downloading all language files ...
function SP_LOAD_LOCALE_INDEX {   
    wget -N -P "$SP_PATH/locale" --progress=dot "https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/locale.sh" 2>&1 |\
    grep "%" |\
    sed -u -e "s,\.,,g" | awk '{print $2}' | sed -u -e "s,\%,,g"  | dialog --backtitle "$SP_TITLE" --gauge "Downloading the language index file ..." 10 100
    chmod +x "$SP_PATH/locale/locale.sh"
    sleep 1
    source "$SP_PATH/locale/locale.sh" # shellcheck source=../locale/locale.sh
    clear
}

############################################################################################################################

function SP_CONFIG_LOCALE { 
    if [[ $SP_LOCALE = "01" ]] || [[ $SP_LOCALE == *"zh"*"CN"* ]]; then
        source "$SP_PATH/locale/zh-CN/locale-zh.sh" # shellcheck source=../locale/zh-CN/locale-zh.sh
        SP_LICENSE_FILE="$SP_PATH/locale/zh-CN/license-zh.txt"
    elif [[ $SP_LOCALE = "02" ]] || [[ $SP_LOCALE == *"cs"*"CZ"* ]]; then
        source "$SP_PATH/locale/cs-CZ/locale-cs.sh" # shellcheck source=../locale/cs-CZ/locale-cs.sh
        SP_LICENSE_FILE="$SP_PATH/locale/cs-CZ/license-cs.txt"
    elif [[ $SP_LOCALE = "04" ]] || [[ $SP_LOCALE == *"fr"*"FR"* ]]; then
        source "$SP_PATH/locale/fr-FR/locale-fr.sh" # shellcheck source=../locale/fr-FR/locale-fr.sh
        SP_LICENSE_FILE="$SP_PATH/locale/fr-FR/license-fr.txt"
    elif [[ $SP_LOCALE = "05" ]] || [[ $SP_LOCALE == *"de"*"DE"* ]]; then
        source "$SP_PATH/locale/de-DE/locale-de.sh" # shellcheck source=../locale/de-DE/locale-de.sh
        SP_LICENSE_FILE="$SP_PATH/locale/de-DE/license-de.txt"
    elif [[ $SP_LOCALE = "06" ]] || [[ $SP_LOCALE == *"it"*"IT"* ]]; then
        source "$SP_PATH/locale/it-IT/locale-it.sh" # shellcheck source=../locale/it-IT/locale-it.sh
        SP_LICENSE_FILE="$SP_PATH/locale/it-IT/license-it.txt"
    elif [[ $SP_LOCALE = "07" ]] || [[ $SP_LOCALE == *"ja"*"JP"* ]]; then
        source "$SP_PATH/locale/ja-JP/locale-ja.sh" # shellcheck source=../locale/ja-JP/locale-ja.sh
        SP_LICENSE_FILE="$SP_PATH/locale/ja-JP/license-ja.txt"
    elif [[ $SP_LOCALE = "08" ]] || [[ $SP_LOCALE == *"ko"*"KR"* ]]; then
        source "$SP_PATH/locale/ko-KR/locale-ko.sh" # shellcheck source=../locale/ko-KR/locale-ko.sh
        SP_LICENSE_FILE="$SP_PATH/locale/ko-KR/license-ko.txt"
    elif [[ $SP_LOCALE = "09" ]] || [[ $SP_LOCALE == *"es"*"ES"* ]]; then
        source "$SP_PATH/locale/es-ES/locale-es.sh" # shellcheck source=../locale/es-ES/locale-es.sh
        SP_LICENSE_FILE="$SP_PATH/locale/es-ES/license-es.txt"
    else
        source "$SP_PATH/locale/en-US/locale-en.sh" # shellcheck source=../locale/en-US/locale-en.sh
        SP_LICENSE_FILE="$SP_PATH/locale/en-US/license-en.txt"
    fi
}

###############################################################################################################################################################
# ALL OS-FUNCTIONS ARE ARRANGED HERE:                                                                                                                         #
###############################################################################################################################################################

function SP_LOAD_OS_PACKAGES {
    if [[ $SP_OS_VERSION = "01" ]]; then
        echo "Arch Linux" && OS_ARCHLINUX
    elif [[ $SP_OS_VERSION = "02" ]]; then
        echo "Debian" && OS_DEBIAN
    elif [[ $SP_OS_VERSION = "03" ]]; then
        echo "EndeavourOS" && OS_ARCHLINUX
    elif [[ $SP_OS_VERSION = "04" ]]; then
        echo "Fedora" && OS_FEDORA
    elif [[ $SP_OS_VERSION = "05" ]]; then
        echo "Linux Mint" && OS_UBUNTU
    elif [[ $SP_OS_VERSION = "06" ]]; then
        echo "Manjaro Linux" && OS_ARCHLINUX
    elif [[ $SP_OS_VERSION = "07" ]]; then
        echo "openSUSE Leap & TW" && OS_OPENSUSE
    elif [[ $SP_OS_VERSION = "08" ]]; then
        echo "Red Hat Enterprise Linux" && OS_REDHAT_LINUX
    elif [[ $SP_OS_VERSION = "9" ]]; then
        echo "Solus" && OS_SOLUS_LINUX
    elif [[ $SP_OS_VERSION = "10" ]]; then
        echo "Ubuntu" && OS_UBUNTU
    elif [[ $SP_OS_VERSION = "11" ]]; then
        echo "Void Linux" && OS_VOID_LINUX
    elif [[ $SP_OS_VERSION = "12" ]]; then
        echo "Gentoo Linux" && OS_GENTOO_LINUX
    else
        echo "No Linux distribution was selected!" # Replace with a dialogue!
    fi
}

###############################################################################################################################################################

function OS_ARCHLINUX {
    echo "Checking for multilib..."
    if ARCHLINUX_VERIFY_MULTILIB ; then
        echo "multilib found. Continuing..."
        pkexec sudo pacman -Sy --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
    else
        echo "Enabling multilib..."
        echo "[multilib]" | sudo tee -a /etc/pacman.conf
        echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf
        pkexec sudo pacman -Sy --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
    fi
}

function ARCHLINUX_VERIFY_MULTILIB {
    if grep -q '^\[multilib\]$' /etc/pacman.conf ; then
        true
    else
        false
    fi
}

###############################################################################################################################################################

function OS_DEBIAN {
    # Check which version of Debian is installed on your system!
    OS_DEBIAN_VERSION=$(lsb_release -ds)
    if [[ $OS_DEBIAN_VERSION == *"Debian"*"10"* ]]; then
        DEBIAN_BASED_1
        OS_DEBIAN_10
        DEBIAN_BASED_2
    elif [[ $OS_DEBIAN_VERSION == *"Debian"*"11"* ]]; then
        DEBIAN_BASED_1
        OS_DEBIAN_11
        DEBIAN_BASED_2
    else
        echo "Your Linux distribution is not supported yet!"
    fi
}

function DEBIAN_BASED_1 {
    # Some systems require this command for all repositories to work properly and for the packages to be downloaded for installation!
    pkexec sudo apt-get --allow-releaseinfo-change update
    # Added i386 support for wine!
    sudo dpkg --add-architecture i386
}

function DEBIAN_BASED_2 {
    sudo apt-get update
    sudo apt-get install p7zip p7zip-full p7zip-rar curl winbind cabextract
    sudo apt-get install --install-recommends winehq-staging
}

function OS_DEBIAN_10 {
    sudo apt-add-repository -r 'deb https://dl.winehq.org/wine-builds/debian/ buster main'
    wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10//Release.key -O Release.key -O- | sudo apt-key add -
    sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/ ./'
}

function OS_DEBIAN_11 {
    sudo apt-add-repository -r 'deb https://dl.winehq.org/wine-builds/debian/ bullseye main'
    wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_11//Release.key -O Release.key -O- | sudo apt-key add -
    sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_11/ ./'
}

###############################################################################################################################################################

function OS_UBUNTU {
    # Check which version of Ubuntu or Linux Mint is installed on your system!
    OS_UBUNTU_VERSION=$(lsb_release -ds)
    if [[ $OS_UBUNTU_VERSION == *"Ubuntu"*"18.04"* ]]; then
        DEBIAN_BASED_1
        OS_UBUNTU_18
        DEBIAN_BASED_2
    elif [[ $OS_UBUNTU_VERSION == *"Ubuntu"*"20.04"* ]]; then
        DEBIAN_BASED_1
        OS_UBUNTU_20
        DEBIAN_BASED_2
    elif [[ $OS_UBUNTU_VERSION == *"Ubuntu"*"22.04"* ]]; then
        DEBIAN_BASED_1
        OS_UBUNTU_22
        DEBIAN_BASED_2
    elif [[ $OS_UBUNTU_VERSION == *"Linux Mint"*"19"* ]]; then
        DEBIAN_BASED_1
        OS_UBUNTU_18
        DEBIAN_BASED_2
    elif [[ $OS_UBUNTU_VERSION == *"Linux Mint"*"20"* ]]; then
        DEBIAN_BASED_1
        OS_UBUNTU_20
        DEBIAN_BASED_2
    elif [[ $OS_UBUNTU_VERSION == *"Linux Mint"*"21"* ]]; then
        DEBIAN_BASED_1
        OS_UBUNTU_22
        DEBIAN_BASED_2
    else
        echo "Your Linux distribution is not supported yet!"
    fi
}

function OS_UBUNTU_18 {
    sudo apt-add-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
    wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/Release.key -O Release.key -O- | sudo apt-key add -
    sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/ ./'
}

function OS_UBUNTU_20 {
    sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
    wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_20.04/Release.key -O Release.key -O- | sudo apt-key add -
    sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_20.04/ ./'
}

function OS_UBUNTU_22 {
    sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
    wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_22.04/Release.key -O Release.key -O- | sudo apt-key add -
    sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_22.04/ ./'
}

###############################################################################################################################################################

function OS_FEDORA {
    # Check which version of Fedora is installed on your system!
    OS_FEDORA_VERSION=$(lsb_release -ds)
    if [[ $OS_FEDORA_VERSION == *"Fedora"*"36"* ]]; then
        FEDORA_BASED_1
        OS_FEDORA_36
        FEDORA_BASED_2
    elif [[ $OS_FEDORA_VERSION == *"Fedora"*"37"* ]]; then
        FEDORA_BASED_1
        OS_FEDORA_37
        FEDORA_BASED_2
    elif [[ $OS_FEDORA_VERSION == *"Fedora"*"Rawhide"* ]]; then
        FEDORA_BASED_1
        OS_FEDORA_RAWHIDE
        FEDORA_BASED_2
    else
        echo "Your Linux distribution is not supported yet!"
    fi
}

function FEDORA_BASED_1 {
    pkexec sudo dnf update
    sudo dnf upgrade
    sudo dnf install "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
}

function FEDORA_BASED_2 {
    sudo dnf install p7zip p7zip-plugins curl wine cabextract
}

function OS_FEDORA_36 {
    sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_36/Emulators:Wine:Fedora.repo
}

function OS_FEDORA_37 {
    sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_37/Emulators:Wine:Fedora.repo
}

function OS_FEDORA_RAWHIDE {
    sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_Rawhide/Emulators:Wine:Fedora.repo
}

###############################################################################################################################################################

function OS_OPENSUSE {
    # Check which version of openSUSE is installed on your system!
    OS_OPENSUSE_VERSION=$(lsb_release -ds)
    if [[ $OS_OPENSUSE_VERSION == *"openSUSE"*"15.4"* ]]; then
        OS_OPENSUSE_154
    elif [[ $OS_OPENSUSE_VERSION == *"openSUSE"*"Tumbleweed"* ]]; then
        OS_OPENSUSE_TW
    elif [[ $OS_OPENSUSE_VERSION == *"openSUSE"*"MicroOS"* ]]; then
        OS_OPENSUSE_MICROOS # This option is still in experimental status!
    else
        echo "Your Linux distribution is not supported yet!"
    fi
}

function OS_OPENSUSE_154 {
    sudo zypper up && sudo zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.4/ wine && sudo zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.4/ wine && sudo zypper install p7zip-full curl wine cabextract
}

# Has not been published yet!
function OS_OPENSUSE_155 {
    sudo zypper up && sudo zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.5/ wine && sudo zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.5/ wine && sudo zypper install p7zip-full curl wine cabextract
}

function OS_OPENSUSE_TW {
    sudo zypper up && sudo zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/ wine && sudo zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/ wine && sudo zypper install p7zip-full curl wine cabextract
}

function OS_OPENSUSE_MICROOS {
    sudo zypper up && sudo zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/ wine && sudo zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/ wine && sudo zypper install p7zip-full curl wine cabextract
}

###############################################################################################################################################################

function OS_REDHAT_LINUX {
    # Check which version of openSUSE is installed on your system!
    OS_REDHAT_LINUX_VERSION=$(lsb_release -ds)
    if [[ $OS_REDHAT_LINUX_VERSION == *"Red Hat Enterprise Linux"*"8"* ]]; then
        OS_REDHAT_LINUX_8
    elif [[ $OS_REDHAT_LINUX_VERSION == *"Red Hat Enterprise Linux"*"9"* ]]; then
        OS_REDHAT_LINUX_9
    else
        echo "Your Linux distribution is not supported yet!"
    fi
}

function OS_REDHAT_LINUX_8 {
    pkexec sudo subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms
    sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
    sudo dnf upgrade
    sudo dnf install wine
}

function OS_REDHAT_LINUX_9 {
    pkexec sudo subscription-manager repos --enable codeready-builder-for-rhel-9-x86_64-rpms
    sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
    sudo dnf upgrade
    sudo dnf install wine
}

###############################################################################################################################################################

function OS_SOLUS_LINUX {
    pkexec sudo eopkg install -y wine winetricks p7zip curl cabextract samba ppp
}

###############################################################################################################################################################

function OS_VOID_LINUX {
    pkexec sudo xbps-install -Sy wine wine-mono wine-gecko winetricks p7zip curl cabextract samba ppp
}

###############################################################################################################################################################

function OS_GENTOO_LINUX {
    pkexec sudo emerge -nav virtual/wine app-emulation/winetricks app-emulation/wine-mono app-emulation/wine-gecko app-arch/p7zip app-arch/cabextract net-misc/curl net-fs/samba net-dialup/ppp
}

###############################################################################################################################################################
# ALL SPACENAVD-FUNCTIONS ARE ARRANGED HERE:                                                                                                                  #
###############################################################################################################################################################

# Install Spacenavd on the system:
function SP_INSTALL_SPACENAVD {
    if VERB="$( which apt-get )" 2> /dev/null; then
       echo "Debian-based" && sudo apt-get update && sudo apt-get install spacenavd
    elif VERB="$( which dnf )" 2> /dev/null; then
       echo "RedHat-based" && sudo dnf update && sudo dnf install spacenavd
    elif VERB="$( which pacman )" 2> /dev/null; then
       echo "Arch-based" && sudo pacman -Syu --needed spacenavd
    elif VERB="$( which zypper )" 2> /dev/null; then
       echo "openSUSE-based" && sudo zypper up && sudo zypper in spacenavd
    elif VERB="$( which xbps-install )" 2> /dev/null; then
       echo "Void-based" && sudo xbps-install -Sy spacenavd
    elif VERB="$( which eopkg )" 2> /dev/null; then
       echo "Solus-based" && sudo eopkg install spacenavd
    elif VERB="$( which emerge )" 2> /dev/null; then
       echo "Gentoo-based" && sudo emerge -av app-misc/spacenavd
    else
       echo "${RED}I can't find your package manager!${NOCOLOR}"
       exit;
    fi
}
