#!/bin/bash

############################################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                                                 #
# Description:  With this file you can install Autodesk Fusion 360 on different Linux distributions.                       #
# Author:       Steve Zabka                                                                                                #
# Author URI:   https://cryinkfly.com                                                                                      #
# License:      MIT                                                                                                        #
# Time/Date:    xx:xx/xx.xx.2023                                                                                           #
# Version:      1.9.0                                                                                                      #
# Requires:     dialog, wget, lsb-release, coreutils, pkexec                                                               #
############################################################################################################################

###############################################################################################################################################################
# THE LOG-FUNCTION OF THE INSTALLATION IS ARRANGED HERE:                                                                                                      #
###############################################################################################################################################################

# Collects information in order to be able to carry out an error analysis later if necessary.
function SP_LOG_INSTALLATION {
    exec 5> "$SP_PATH/logs/setupact.log"
    BASH_XTRACEFD="5"
    set -x
}

############################################################################################################################
# THE INITIALIZATION OF DEPENDENCIES STARTS HERE:                                                                          #
############################################################################################################################

function SP_CHECK_REQUIRED_COMMANDS {
    SP_REQUIRED_COMMANDS=("dialog" "wget" "lsb-release" "cat")
    for cmd in "${SP_REQUIRED_COMMANDS[@]}"; do
        echo "Testing presence of ${cmd} ..."
        local path="$(command -v "${cmd}")"
        if [ -n "${path}" ]; then 
            clear
            SP_PATH="$HOME/.fusion360" # Create the base structure for the installation.
            mkdir -p $SP_PATH/{bin,config,locale/{cs-CZ,de-DE,en-US,es-ES,fr-FR,it-IT,ja-JP,ko-KR,zh-CN},logs,cache,wineprefixes,resources/{extensions,graphics,music,downloads}}
            SP_LOAD_LOCALE_INDEX && SP_CONFIG_LOCALE && SP_WELCOME
        else
            RED='\033[0;31m' && NOCOLOR='\033[0m' # Set up the text color scheme in the terminal!
            clear
            echo -e "${RED}The required packages 'dialog', 'wget', 'lsb-release' and 'coreutils' not installed on your system!${NOCOLOR}"
            read -p "Would you like to install these packages on your system to continue the installation of Autodesk Fusion 360? (y/n)" yn
            case $yn in 
	            y ) SP_INSTALL_REQUIRED_COMMANDS && SP_REQUIRED_COMMANDS;;
	            n ) echo -e "${RED}Exiting ...${NOCOLOR}";
		            exit;;
	            * ) echo -e "${RED}Invalid Response!${NOCOLOR}";
		            exit 1;;
            esac
        fi
    done;
}

############################################################################################################################

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
# ALL LOCALE-FUNCTIONS ARE ARRANGED HERE:                                                                                                                     #
###############################################################################################################################################################

function SP_DOWNLOAD_LOCALE_INDEX {
    SP_DOWNLOAD_FILE_URL="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/locale.sh"
    SP_DOWNLOAD_FILE_TEXT="Downloading the locale index file ..."
    SP_DOWNLOAD_FILE_DIRECTORY="$SP_PATH/locale"
    SP_DOWNLOAD_FILE
    chmod +x "$SP_PATH/locale/locale.sh"
    source "$SP_PATH/locale/locale.sh" # shellcheck
    clear
}

############################################################################################################################

function SP_CONFIG_LOCALE { 
    if [[ $SP_LOCALE = "01" ]] || [[ $SP_LOCALE == *"zh"*"CN"* ]]; then
        source "$SP_PATH/locale/zh-CN/locale-zh.sh" # shellcheck
        SP_LICENSE_FILE="$SP_PATH/locale/zh-CN/license-zh.txt"
    elif [[ $SP_LOCALE = "02" ]] || [[ $SP_LOCALE == *"cs"*"CZ"* ]]; then
        source "$SP_PATH/locale/cs-CZ/locale-cs.sh" # shellcheck
        SP_LICENSE_FILE="$SP_PATH/locale/cs-CZ/license-cs.txt"
    elif [[ $SP_LOCALE = "04" ]] || [[ $SP_LOCALE == *"fr"*"FR"* ]]; then
        source "$SP_PATH/locale/fr-FR/locale-fr.sh" # shellcheck
        SP_LICENSE_FILE="$SP_PATH/locale/fr-FR/license-fr.txt"
    elif [[ $SP_LOCALE = "05" ]] || [[ $SP_LOCALE == *"de"*"DE"* ]]; then
        source "$SP_PATH/locale/de-DE/locale-de.sh" # shellcheck
        SP_LICENSE_FILE="$SP_PATH/locale/de-DE/license-de.txt"
    elif [[ $SP_LOCALE = "06" ]] || [[ $SP_LOCALE == *"it"*"IT"* ]]; then
        source "$SP_PATH/locale/it-IT/locale-it.sh" # shellcheck
        SP_LICENSE_FILE="$SP_PATH/locale/it-IT/license-it.txt"
    elif [[ $SP_LOCALE = "07" ]] || [[ $SP_LOCALE == *"ja"*"JP"* ]]; then
        source "$SP_PATH/locale/ja-JP/locale-ja.sh" # shellcheck
        SP_LICENSE_FILE="$SP_PATH/locale/ja-JP/license-ja.txt"
    elif [[ $SP_LOCALE = "08" ]] || [[ $SP_LOCALE == *"ko"*"KR"* ]]; then
        source "$SP_PATH/locale/ko-KR/locale-ko.sh" # shellcheck
        SP_LICENSE_FILE="$SP_PATH/locale/ko-KR/license-ko.txt"
    elif [[ $SP_LOCALE = "09" ]] || [[ $SP_LOCALE == *"es"*"ES"* ]]; then
        source "$SP_PATH/locale/es-ES/locale-es.sh" # shellcheck
        SP_LICENSE_FILE="$SP_PATH/locale/es-ES/license-es.txt"
    else
        source "$SP_PATH/locale/en-US/locale-en.sh" # shellcheck
        SP_LICENSE_FILE="$SP_PATH/locale/en-US/license-en.txt"
    fi
}

###############################################################################################################################################################
# ALL LICENSE-CHECK-FUNCTIONS ARE ARRANGED HERE:                                                                                                              #
###############################################################################################################################################################

function SP_LICENSE_CHECK_STATUS {
    if [[ $SP_LICENSE_CHECK = "$SP_LICENSE_SHOW_TEXT_1" ]]; then
        SP_SELECT_OS_VERSION
    else
        SP_SHOW_LICENSE_WARNING
    fi
}

###############################################################################################################################################################
# ALL OS-FUNCTIONS ARE ARRANGED HERE:                                                                                                                         #
###############################################################################################################################################################

function SP_LOAD_OS_PACKAGES {
    SP_OS_VERSION=$(lsb_release -ds)
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
        echo "No Linux distribution was selected!" # <-- Replace with a GUI!
    fi
}

###############################################################################################################################################################

function OS_ARCHLINUX {
    echo "Checking for multilib..." # <-- Replace with a GUI!
    if ARCHLINUX_VERIFY_MULTILIB ; then
        echo "multilib found. Continuing..." # <-- Replace with a GUI!
        pkexec sudo pacman -Sy --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
    else
        echo "Enabling multilib..." # <-- Replace with a GUI!
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
    if [[ $SP_OS_VERSION == *"Debian"*"10"* ]]; then
        DEBIAN_BASED_1
        OS_DEBIAN_10
        DEBIAN_BASED_2
    elif [[ $SP_OS_VERSION == *"Debian"*"11"* ]]; then
        DEBIAN_BASED_1
        OS_DEBIAN_11
        DEBIAN_BASED_2
    else
        echo "Your Linux distribution is not supported yet!" # <-- Replace with a GUI!
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
    if [[ $SP_OS_VERSION == *"Ubuntu"*"18.04"* ]]; then
        DEBIAN_BASED_1
        OS_UBUNTU_18
        DEBIAN_BASED_2
    elif [[ $SP_OS_VERSION == *"Ubuntu"*"20.04"* ]]; then
        DEBIAN_BASED_1
        OS_UBUNTU_20
        DEBIAN_BASED_2
    elif [[ $SP_OS_VERSION == *"Ubuntu"*"22.04"* ]]; then
        DEBIAN_BASED_1
        OS_UBUNTU_22
        DEBIAN_BASED_2
    elif [[ $SP_OS_VERSION == *"Linux Mint"*"19"* ]]; then
        DEBIAN_BASED_1
        OS_UBUNTU_18
        DEBIAN_BASED_2
    elif [[ $SP_OS_VERSION == *"Linux Mint"*"20"* ]]; then
        DEBIAN_BASED_1
        OS_UBUNTU_20
        DEBIAN_BASED_2
    elif [[ $SP_OS_VERSION == *"Linux Mint"*"21"* ]]; then
        DEBIAN_BASED_1
        OS_UBUNTU_22
        DEBIAN_BASED_2
    else
        echo "Your Linux distribution is not supported yet!" # <-- Replace with a GUI!
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
    if [[ $SP_OS_VERSION == *"Fedora"*"36"* ]]; then
        FEDORA_BASED_1
        OS_FEDORA_36
        FEDORA_BASED_2
    elif [[ $SP_OS_VERSION == *"Fedora"*"37"* ]]; then
        FEDORA_BASED_1
        OS_FEDORA_37
        FEDORA_BASED_2
    elif [[ $SP_OS_VERSION == *"Fedora"*"Rawhide"* ]]; then
        FEDORA_BASED_1
        OS_FEDORA_RAWHIDE
        FEDORA_BASED_2
    else
        echo "Your Linux distribution is not supported yet!" # <-- Replace with a GUI!
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
    if [[ $SP_OS_VERSION == *"openSUSE"*"15.4"* ]]; then
        OS_OPENSUSE_154
    elif [[ $SP_OS_VERSION == *"openSUSE"*"Tumbleweed"* ]]; then
        OS_OPENSUSE_TW
    elif [[ $SP_OS_VERSION == *"openSUSE"*"MicroOS"* ]]; then
        OS_OPENSUSE_MICROOS # This option is still in experimental status and is for using Fusion 360 into a Distrobox-Container!
    else
        echo "Your Linux distribution is not supported yet!" # <-- Replace with a GUI!
    fi
}

function OS_OPENSUSE_154 {
    pkexec sudo zypper up && sudo zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.4/ wine && sudo zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.4/ wine && sudo zypper install p7zip-full curl wine cabextract
}

# Has not been published yet!
function OS_OPENSUSE_155 {
    pkexec sudo zypper up && sudo zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.5/ wine && sudo zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.5/ wine && sudo zypper install p7zip-full curl wine cabextract
}

function OS_OPENSUSE_TW {
    pkexec sudo zypper up && sudo zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/ wine && sudo zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/ wine && sudo zypper install p7zip-full curl wine cabextract
}

function OS_OPENSUSE_MICROOS {
    sudo zypper up && sudo zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/ wine && sudo zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/ wine && sudo zypper install p7zip-full curl wine cabextract
}

###############################################################################################################################################################

function OS_REDHAT_LINUX {
    # Check which version of openSUSE is installed on your system!
    if [[ $SP_OS_VERSION == *"Red Hat Enterprise Linux"*"8"* ]]; then
        OS_REDHAT_LINUX_8
    elif [[ $SP_OS_VERSION == *"Red Hat Enterprise Linux"*"9"* ]]; then
        OS_REDHAT_LINUX_9
    else
        echo "Your Linux distribution is not supported yet!" # <-- Replace with a GUI!
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
       echo "${RED}I can't find your package manager!${NOCOLOR}" # <-- Replace with a GUI!
       exit;
    fi
}

###############################################################################################################################################################
# ALL LOG- & CHECK-FUNCTIONS OF WINE & WINEPREFIXES ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

# Checks if "Wine" exists in a specific version:
function SP_CHECK_REQUIRED_WINE_VERSION {
    SP_REQUIRED_WINE_VERSION=$(wine --version)
    if [[ $SP_REQUIRED_WINE_VERSION == *"wine-6.23"* ]] || [[ $SP_REQUIRED_WINE_VERSION == *"wine-7"* ]] || [[ $SP_REQUIRED_WINE_VERSION == *"wine-8"* ]]; then
        SP_INSTALL_SPACENAVD && SP_SELECT_WINE_GPU_DRIVER
    else
        SP_INSTALL_OS_PACKAGES && SP_INSTALL_SPACENAVD && SP_SELECT_WINE_GPU_DRIVER
    fi
}

###############################################################################################################################################################

# Check if already exists a Autodesk Fusion 360 installation on your system.
function SP_WINEPREFIX_CHECK_LOG {
    SP_WINEPREFIX_CHECK="$SP_PATH/logs/wineprefixes.log" # Search for wineprefixes.log
    if [ -f "$SP_WINEPREFIX_CHECK" ]; then
        cp "$SP_WINEPREFIX_CHECK" "$SP_PATH/cache"
        SP_WINEPREFIX_LOG_INFO # Add/Modify or Delete a exists Wineprefix of Autodesk Fusion 360.
    else
        SP_NEW_WINEPREFIX # Add a new Wineprefix of Autodesk Fusion 360.
    fi
}

###############################################################################################################################################################

# Create a WP-TYPE for the .desktop-files:
function SP_GET_WINEPREFIX_TYPE {
    if [[ $SP_WINEPREFIX_DIRECTORY = "$SP_PATH/wineprefixes/default" ]]; then
        SP_WINEPREFIX_TYPE="default"
    else
        SP_ADD_CUSTOM_WINEPREFIX_TYPE # Create the directory (custom, custom-1, custom-2, ...)
    fi
}

###############################################################################################################################################################

# Create a new customized Wineprefix:
function SP_ADD_CUSTOM_WINEPREFIX_TYPE {
    SP_WINEPREFIX_TYPE="custom"
    if [[ -e $SP_WINEPREFIX_TYPE || -L $SP_WINEPREFIX_TYPE ]] ; then
        i=0
        while [[ -e $SP_WINEPREFIX_TYPE-$i || -L $SP_WINEPREFIX_TYPE-$i ]] ; do
            (( i++ ))
        done
        SP_WINEPREFIX_TYPE=$SP_WINEPREFIX_TYPE-$i
    fi
}

###############################################################################################################################################################

# Saves the most important parameters from the past Wineprefix installation.
function SP_WINEPREFIX_LOG {
    if [ $SP_FUSION360_CHANGE -eq 1 ]; then
        echo "FALSE" >> "$SP_PATH/logs/wineprefixes.log"
        echo "$SP_WINEPREFIX_TYPE" >> "$SP_PATH/logs/wineprefixes.log"
        echo "$SP_WINEPREFIX_GPU_DRIVER" >> "$SP_PATH/logs/wineprefixes.log"
        echo "$SP_WINEPREFIX_DIRECTORY" >> "$SP_PATH/logs/wineprefixes.log"
    fi
}

###############################################################################################################################################################

# Check if this wineprefix already exist or not!
function SP_INSTALLDIR_CHECK {
    SP_WINEPREFIX_CHECK_PATH="$WP_DIRECTORY/box-run.sh"
    if [[ -f "$SP_WINEPREFIX_CHECK_PATH" ]]; then
        echo "FALSE"
        SP_INSTALLDIR_INFO
    else
        echo "TRUE"
        SP_FUSION360_CHANGE=1
        SP_WINE_SETTINGS
    fi
}

###############################################################################################################################################################
# ALL GRAPHICAL DIALOGUES ARE ARRANGED HERE:                                                                                                                  #
###############################################################################################################################################################

# Default function to show download progress:
function SP_DOWNLOAD_FILE {
    wget -N -P "$SP_DOWNLOAD_FILE_DIRECTORY" --progress=dot "$SP_DOWNLOAD_FILE_URL" 2>&1 |\
    grep "%" |\
    sed -u -e "s,\.,,g" | awk '{print $2}' | sed -u -e "s,\%,,g"  | dialog --backtitle "$SP_TITLE" --gauge "$SP_DOWNLOAD_FILE_TEXT" 10 100
    sleep 1 
}

###############################################################################################################################################################

# Welcome window for a complete new installation:
function SP_WELCOME {
    SP_LOCALE=$(dialog --backtitle "$SP_TITLE" \
        --title "$SP_WELCOME_SUBTITLE" \
        --radiolist "$SP_WELCOME_TEXT" 0 0 0 \
            01 "中文(简体)" off\
            02 "Čeština" off\
            03 "English" on\
            04 "Français" off\
            05 "Deutsch" off\
            06 "Italiano" off\
            07 "日本語" off\
            08 "한국어" off\
            09 "Española" off 3>&1 1>&2 2>&3 3>&-;)

    if [ $PIPESTATUS -eq 0 ]; then
        SP_CONFIG_LOCALE && SP_LICENSE_SHOW # Shows the user the license agreement.
    elif [ $PIPESTATUS -eq 1 ]; then
        SP_LOCALE=$(echo $LANG) && SP_WELCOME_EXIT # Displays a warning to the user whether the program should really be terminated.
    elif [ $PIPESTATUS -eq 255 ]; then
        echo "[ESC] key pressed." # Program has been terminated manually! <-- Replace with a GUI!
    else
        exit;
    fi
}

###############################################################################################################################################################

function SP_WELCOME_EXIT {
    dialog --backtitle "$SP_TITLE" \
        --yesno "$SP_WELCOME_LABEL_1" 0 0
        response=$?
        case $response in
            0) clear && exit;; # Program has been terminated manually!
            1) SP_WELCOME;; # Go back to the welcome window!
            255) echo "[ESC] key pressed.";; # Program has been terminated manually! <-- Replace with a GUI!
        esac
}

###############################################################################################################################################################

function SP_LICENSE_SHOW {
    SP_LICENSE_CHECK=$(dialog --backtitle "$SP_TITLE" \
        --title "$SP_LICENSE_SHOW_SUBTITLE" \
        --checklist "`cat $SP_LICENSE_FILE`" 0 0 0 \
            "$SP_LICENSE_SHOW_TEXT_1" "$SP_LICENSE_SHOW_TEXT_2" off 3>&1 1>&2 2>&3 3>&-;)
            
    if [ $PIPESTATUS -eq 0 ]; then
        SP_LICENSE_CHECK_STATUS
    elif [ $PIPESTATUS -eq 1 ]; then
        SP_WELCOME
    elif [ $PIPESTATUS -eq 255 ]; then
        echo "[ESC] key pressed." # Program has been terminated manually! <-- Replace with a GUI!
    else
        exit;
    fi
} 

###############################################################################################################################################################

function SP_SHOW_LICENSE_WARNING {
    dialog --backtitle "$SP_TITLE" \
        --yesno "$SP_LICENSE_WARNING_TEXT" 0 0
        response=$?
        case $response in
            0) SP_LICENSE_SHOW;; # Open the next dialog for accept the license.
            1) exit;; # Program has been terminated manually!
            255) echo "[ESC] key pressed.";; # Program has been terminated manually! <-- Replace with a GUI!
        esac
}

###############################################################################################################################################################

function SP_SELECT_OS_VERSION {
    SP_OS_VERSION=$(dialog --backtitle "$SP_TITLE" \
        --title "$SP_SELECT_OS_VERSION_SUBTITLE" \
        --radiolist "$SP_SELECT_OS_VERSION_TEXT" 0 0 0 \
            01 "Arch Linux" off\
            02 "Debian" off\
            03 "EndeavourOS" off\
            04 "Fedora" off\
            05 "Linux Mint" off\
            06 "Manjaro Linux" off\
            07 "openSUSE Leap & TW" off\
            08 "Red Hat Enterprise Linux" off\
            09 "Solus" off\
            10 "Ubuntu" off\
            11 "Void Linux" off\
            12 "Gentoo Linux" off 3>&1 1>&2 2>&3 3>&-)
            
    if [ $PIPESTATUS -eq 0 ]; then
        SP_CHECK_REQUIRED_WINE_VERSION
    elif [ $PIPESTATUS -eq 1 ]; then
        SP_LICENSE_SHOW
    elif [ $PIPESTATUS -eq 255 ]; then
        echo "[ESC] key pressed." # Program has been terminated manually! <-- Replace with a GUI!
    else
        exit;
    fi
}

###############################################################################################################################################################








###############################################################################################################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:                                                                                                                   #
###############################################################################################################################################################

SP_LOG_INSTALLATION
SP_CHECK_REQUIRED_COMMANDS
