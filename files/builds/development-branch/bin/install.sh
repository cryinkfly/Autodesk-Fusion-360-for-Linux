#!/bin/bash

############################################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                                                 #
# Description:  With this file you can install Autodesk Fusion 360 on different Linux distributions.                       #
# Author:       Steve Zabka                                                                                                #
# Author URI:   https://cryinkfly.com                                                                                      #
# License:      MIT                                                                                                        #
# Time/Date:    xx:xx/xx.xx.2023                                                                                           #
# Version:      1.9.0                                                                                                      #
# Requires:     dialog, wget, lsb-release, coreutils, glxinfo, software-properties-common (Debian)                         #
############################################################################################################################

###############################################################################################################################################################
# THE INITIALIZATION OF DEPENDENCIES STARTS HERE:                                                                                                             #
###############################################################################################################################################################

# Set up the text color scheme:
function SET_UP_COLOR_SHEME {
    RED='\033[0;31m'
    BROWN='\033[0;33m'
    NOCOLOR='\033[0m'
} 

# Create the base structure for the installation:
function CREATE_STRUCTURE {
    SP_PATH="$HOME/.fusion360" 
    mkdir -p $SP_PATH/{bin,config,locale/{cs-CZ,de-DE,en-US,es-ES,fr-FR,it-IT,ja-JP,ko-KR,zh-CN},logs,cache,wineprefixes,resources/{extensions,graphics,music,downloads}}
}

# Collects information in order to be able to carry out an error analysis later if necessary:
function LOG_INSTALLATION {
    exec 5> "$SP_PATH/logs/setupact.log"
    BASH_XTRACEFD="5"
    set -x
}

# Check if "dialog", "wget", ... are installed on the system:
function CHECK_REQUIRED_COMMANDS {
    REQUIRED_COMMANDS=("dialog" "wget" "lsb-release" "coreutils" "glxinfo" "pkexec")
    for cmd in "${SP_REQUIRED_COMMANDS[@]}"; do
        echo "Testing presence of ${cmd} ..."
        local path="$(command -v "${cmd}")"
        if [ -n "${path}" ]; then
            echo "All the packages needed to continue with the installation are present on the system."
            SP_LOG_INSTALLATION && SP_LOAD_LOCALE_INDEX && SP_CONFIG_LOCALE && SP_WELCOME
        else
            clear
            echo -e "${RED}The required packages 'dialog', 'wget', 'lsb-release' and 'coreutils' not installed on your system!${NOCOLOR}"
            read -p "Would you like to install these packages on your system to continue the installation of Autodesk Fusion 360? (y/n)" yn
            case $yn in 
	            y ) CHECK_INSTALL_REQUIRED_PACKAGES="1";
	                CHECK_INSTALL_PACKAGES;
                    LOG_INSTALLATION;
                    LOAD_LOCALE_INDEX;
                    CONFIG_LOCALE;
                    WELCOME;;
	            n ) echo -e "${RED}Exiting ...";
		             exit;;
	            * ) echo -e "${RED}Invalid Response!${NOCOLOR}";
		            exit 1;;
            esac
        fi
    done;
}

function CHECK_INSTALL_PACKAGES {
    # Check which Linux Distro is used:
    DISTRO_VERSION=$(lsb_release -ds)
        # Check if all required packages are installed:
        if [[ $DISTRO_VERSION == *"Arch"*"Linux"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo pacman -S dialog wget lsb-release coreutils mesa-demos
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    if pacman -Qs vulkan-radeon >/dev/null; then
                        echo "Latest open-source driver for AMD graphics card already installed."
                    else
                        echo "Installing latest open-source driver for AMD graphics card."
                        sudo pacman -S mesa lib32-mesa mesa-vdpau lib32-mesa-vdpau lib32-vulkan-radeon vulkan-radeon glu lib32-glu vulkan-icd-loader lib32-vulkan-icd-loader
                        sudo pacman -Syu
                        echo "Installed latest driver for AMD graphics card."
                    fi
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    if pacman -Qs vulkan-intel >/dev/null; then
                        echo "Latest open-source driver for Intel graphics card already installed."
                    else
                        echo "Installing latest open-source driver for Intel graphics card."
                        sudo pacman -S --needed lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader
                        echo "Installed latest driver for Intel graphics card."
                    fi
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    if pacman -Qs nvidia >/dev/null; then
                        echo "Latest closed driver for Nvidia graphics card already installed."
                    else
                        echo "Installing latest closed driver for Nvidia graphics card."
                        sudo pacman -S nvidia nvidia-settings nvidia-utils lib32-nvidia-utils lib32-opencl-nvidia opencl-nvidia libvdpau libxnvctrl vulkan-icd-loader lib32-vulkan-icd-loader
                        echo "Installed latest driver for Nvidia graphics card."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                echo "Checking for multilib..."
                if [[ $(grep -q '^\[multilib\]$' /etc/pacman.conf) ]]; then
                    echo "multilib found. Continuing..."
                    sudo pacman -Sy --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
                else
                    echo "Enabling multilib..."
                    echo "[multilib]" | sudo tee -a /etc/pacman.conf
                    echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf
                    sudo pacman -Sy --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
                fi
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"Debian"*"10"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo apt-get update && sudo apt-get install -y dialog wget lsb-release coreutils mesa-utils pkexec
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    if [[$(grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*) == *"contrib"*]] && [[$(grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*) == *"non-free"*]]; then
                        echo "Latest driver for AMD graphics card already installed."
                    else
                        sudo apt-get update && sudo apt-get install -y software-properties-common
                        sudo apt-add-repository contrib && sudo apt-add-repository non-free # The package "software-properties-common" must be installed before!
                        sudo apt install -y firmware-linux firmware-linux-nonfree libdrm-amdgpu1 xserver-xorg-video-amdgpu
                        sudo apt install -y mesa-vulkan-drivers libvulkan1 vulkan-tools vulkan-utils vulkan-validationlayers
                        sudo apt install -y mesa-opencl-icd
                        echo "Installed latest driver for AMD graphics card."
                    fi
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    echo "Intel graphics driver is already installed."
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if [[$(grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*) == *"contrib"*]] && [[$(grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*) == *"non-free"*]]; then
                        echo "Latest closed driver for Nvidia graphics card already installed."
                    else
                        sudo apt-get update && sudo apt-get install -y software-properties-common
                        sudo apt-add-repository contrib && sudo apt-add-repository non-free # The package "software-properties-common" must be installed before!
                        sudo apt update && sudo apt install nvidia-driver
                        echo "Installed latest driver for Nvidia graphics card."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # Some systems require this command for all repositories to work properly and for the packages to be downloaded for installation!
                sudo apt-get --allow-releaseinfo-change update
                # Added i386 support for wine!
                sudo dpkg --add-architecture i386
                sudo apt-add-repository -r 'deb https://dl.winehq.org/wine-builds/debian/ buster main'
                wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10//Release.key -O Release.key -O- | sudo apt-key add -
                sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/ ./'
                sudo apt-get update
                sudo apt-get install p7zip p7zip-full p7zip-rar curl winbind cabextract
                sudo apt-get install --install-recommends winehq-staging
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"Debian"*"11"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo apt-get update && sudo apt-get install -y dialog wget lsb-release coreutils mesa-utils pkexec
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    if [[$(grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*) == *"contrib"*]] && [[$(grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*) == *"non-free"*]]; then
                        echo "Latest driver for AMD graphics card already installed."
                    else
                        sudo apt-get update && sudo apt-get install -y software-properties-common
                        sudo apt-add-repository contrib && sudo apt-add-repository non-free # The package "software-properties-common" must be installed before!
                        sudo apt install -y firmware-linux firmware-linux-nonfree libdrm-amdgpu1 xserver-xorg-video-amdgpu
                        sudo apt install -y mesa-vulkan-drivers libvulkan1 vulkan-tools vulkan-utils vulkan-validationlayers
                        sudo apt install -y mesa-opencl-icd
                        echo "Installed latest driver for AMD graphics card."
                    fi
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    echo "Intel graphics driver is already installed."
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if [[$(grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*) == *"contrib"*]] && [[$(grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*) == *"non-free"*]]; then
                        echo "Latest closed driver for Nvidia graphics card already installed."
                    else
                        sudo apt-get update && sudo apt-get install -y software-properties-common
                        sudo apt-add-repository contrib && sudo apt-add-repository non-free # The package "software-properties-common" must be installed before!
                        sudo apt update && sudo apt install nvidia-driver
                        echo "Installed latest driver for Nvidia graphics card."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # Some systems require this command for all repositories to work properly and for the packages to be downloaded for installation!
                sudo apt-get --allow-releaseinfo-change update
                # Added i386 support for wine!
                sudo dpkg --add-architecture i386
                sudo apt-add-repository -r 'deb https://dl.winehq.org/wine-builds/debian/ bullseye main'
                wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_11//Release.key -O Release.key -O- | sudo apt-key add -
                sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_11/ ./'
                sudo apt-get update
                sudo apt-get install p7zip p7zip-full p7zip-rar curl winbind cabextract
                sudo apt-get install --install-recommends winehq-staging
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"Debian"*"Sid"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo apt-get update && sudo apt-get install -y dialog wget lsb-release coreutils mesa-utils pkexec
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    if [[$(grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*) == *"contrib"*]] && [[$(grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*) == *"non-free"*]]; then
                        echo "Latest driver for AMD graphics card already installed."
                    else
                        sudo apt-get update && sudo apt-get install -y software-properties-common
                        sudo apt-add-repository contrib && sudo apt-add-repository non-free # The package "software-properties-common" must be installed before!
                        sudo apt install -y firmware-linux firmware-linux-nonfree libdrm-amdgpu1 xserver-xorg-video-amdgpu
                        sudo apt install -y mesa-vulkan-drivers libvulkan1 vulkan-tools vulkan-utils vulkan-validationlayers
                        sudo apt install -y mesa-opencl-icd
                        echo "Installed latest driver for AMD graphics card."
                    fi
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    echo "Intel graphics driver is already installed."
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if [[$(grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*) == *"contrib"*]] && [[$(grep ^[^#] /etc/apt/sources.list /etc/apt/sources.list.d/*) == *"non-free"*]]; then
                        echo "Latest closed driver for Nvidia graphics card already installed."
                    else
                        sudo apt-get update && sudo apt-get install -y software-properties-common
                        sudo apt-add-repository contrib && sudo apt-add-repository non-free # The package "software-properties-common" must be installed before!
                        sudo apt update && sudo apt install nvidia-driver
                        echo "Installed latest driver for Nvidia graphics card."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # Some systems require this command for all repositories to work properly and for the packages to be downloaded for installation!
                sudo apt-get --allow-releaseinfo-change update
                # Added i386 support for wine!
                sudo dpkg --add-architecture i386
                sudo apt-add-repository -r 'deb https://dl.winehq.org/wine-builds/debian/ bullseye main'
                wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_Testing_standard//Release.key -O Release.key -O- | sudo apt-key add -
                sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_Testing_standard/ ./'
                sudo apt-get update
                sudo apt-get install p7zip p7zip-full p7zip-rar curl winbind cabextract
                sudo apt-get install --install-recommends winehq-staging
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"Fedora"*"37"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo dnf install dialog wget lsb-release coreutils mesa-utils policykit-1
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    echo "AMD graphics driver is already installed."
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    echo "Intel graphics driver is already installed."
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if [[$(sudo dnf repolist all) == *"rpmfusion-free-release"*]] && [[$(sudo dnf repolist all) == *"rpmfusion-nonfree-release"*]]; then
                        echo "Nvidia graphics driver is already installed."
                    else
                        sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
                        sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
                        sudo dnf install akmod-nvidia
                        sudo dnf install xorg-x11-drv-nvidia-cuda
                        echo "Installed latest driver for Nvidia graphics card."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                if [[$(sudo dnf repolist all) == *"rpmfusion-free-release"*]] && [[$(sudo dnf repolist all) == *"rpmfusion-nonfree-release"*]] && [[$(sudo dnf repolist all) == *"wine"*]]; then
                    echo "Required Repo allready exists!"
                    sudo dnf install p7zip p7zip-plugins curl wine cabextract
                    echo "Installed latest Wine version."
                else
                    sudo dnf update && sudo dnf upgrade
                    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
                    sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
                    sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_37/Emulators:Wine:Fedora.repo
                    sudo dnf update && sudo dnf upgrade
                    sudo dnf install p7zip p7zip-plugins curl wine cabextract
                    echo "Installed latest Wine version."
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"Fedora"*"38"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo dnf install dialog wget lsb-release coreutils mesa-utils policykit-1
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    echo "AMD graphics driver is already installed."
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    echo "Intel graphics driver is already installed."
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if [[$(sudo dnf repolist all) == *"rpmfusion-free-release"*]] && [[$(sudo dnf repolist all) == *"rpmfusion-nonfree-release"*]]; then
                        echo "Nvidia graphics driver is already installed."
                    else
                        sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
                        sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
                        sudo dnf install akmod-nvidia
                        sudo dnf install xorg-x11-drv-nvidia-cuda
                        echo "Installed latest driver for Nvidia graphics card."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                if [[$(sudo dnf repolist all) == *"rpmfusion-free-release"*]] && [[$(sudo dnf repolist all) == *"rpmfusion-nonfree-release"*]] && [[$(sudo dnf repolist all) == *"wine"*]]; then
                    echo "Required Repo allready exists!"
                    sudo dnf install p7zip p7zip-plugins curl wine cabextract
                    echo "Installed latest Wine version."
                else
                    sudo dnf update && sudo dnf upgrade
                    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
                    sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
                    sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_38/Emulators:Wine:Fedora.repo
                    sudo dnf update && sudo dnf upgrade
                    sudo dnf install p7zip p7zip-plugins curl wine cabextract
                    echo "Installed latest Wine version."
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"Fedora"*"Rawhide"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo dnf install dialog wget lsb-release coreutils mesa-utils policykit-1
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    echo "AMD graphics driver is already installed."
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    echo "Intel graphics driver is already installed."
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if [[$(sudo dnf repolist all) == *"rpmfusion-free-release"*]] && [[$(sudo dnf repolist all) == *"rpmfusion-nonfree-release"*]]; then
                        echo "Nvidia graphics driver is already installed."
                    else
                        sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
                        sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
                        sudo dnf install akmod-nvidia
                        sudo dnf install xorg-x11-drv-nvidia-cuda
                        echo "Installed latest driver for Nvidia graphics card."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                if [[$(sudo dnf repolist all) == *"rpmfusion-free-release"*]] && [[$(sudo dnf repolist all) == *"rpmfusion-nonfree-release"*]] && [[$(sudo dnf repolist all) == *"wine"*]]; then
                    echo "Required Repo allready exists!"
                    sudo dnf install p7zip p7zip-plugins curl wine cabextract
                    echo "Installed latest Wine version."
                else
                    sudo dnf update && sudo dnf upgrade
                    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
                    sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
                    sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_Rawhide/Emulators:Wine:Fedora.repo
                    sudo dnf update && sudo dnf upgrade
                    sudo dnf install p7zip p7zip-plugins curl wine cabextract
                    echo "Installed latest Wine version."
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"Gentoo"*"Linux"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo emerge -q dialog wget lsb-release coreutils media-libs/mesa polkit
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    if ! glxinfo | grep -i "AMD" > /dev/null; then
                        echo "Installing AMD graphics driver."
                        sudo emerge --ask --quiet x11-drivers/xf86-video-amdgpu
                        echo "Installed latest driver for AMD graphics card."
                    else
                        echo "AMD graphics driver is already installed."
                    fi
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    if ! glxinfo | grep -i "Intel" > /dev/null; then
                        echo "Installing Intel graphics driver."
                        sudo emerge --ask --quiet x11-drivers/xf86-video-intel
                        echo "Installed latest driver for Intel graphics card."
                    else
                        echo "Intel graphics driver is already installed."
                    fi
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if ! glxinfo | grep -i "NVIDIA" > /dev/null; then
                        echo "Installing Nvidia graphics driver."
                        sudo emerge --ask --quiet x11-drivers/nvidia-drivers
                        echo "Installed latest driver for Nvidia graphics card."
                    else
                        echo "Nvidia graphics driver is already installed."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # ...
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"nixos"* ]] || [[ $DISTRO_VERSION == *"NixOS"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo nix-env -iA nixos.dialog nixos.wget nixos.lsb_release nixos.coreutils nixos.mesa-utils nixos.polkit
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    if ! nix-env -q amdgpu; then
                        echo "Installing latest AMD graphics driver."
                        sudo nix-env -iA nixos.amdgpu
                        echo "Installed latest driver for AMD graphics card."
                    else
                        echo "AMD graphics driver is already installed."
                    fi
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    if ! nix-env -q intel-video-acc; then
                        echo "Installing latest Intel graphics driver."
                        sudo nix-env -iA nixos.intel-video-acc
                        echo "Installed latest driver for Intel graphics card."
                    else
                        echo "Latest Intel graphics driver already installed."
                    fi
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if ! nix-env -q nvidia; then
                        echo "Installing latest Nvidia graphics driver."
                        sudo nix-env -iA nixos.nvidia
                        echo "Installed latest driver for Nvidia graphics card."
                    else
                        echo "Nvidia graphics driver is already installed."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # ...
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"openSUSE"*"15.4"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo zypper install dialog wget lsb-release coreutils polkit Mesa-demo-x
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    if [[ $(zypper search -i kernel-firmware-amdgpu | grep -c "Version") -eq 0 ]]; then
                        echo "Installing the newest AMD graphics card driver."
                        sudo zypper install kernel-firmware-amdgpu
                        echo "Installed latest driver for AMD graphics card."
                    else
                        echo "The newest AMD graphics card driver is already installed."
                    fi
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    if [[ $(zypper search -i xf86-video-intel | grep -c "Version") -eq 0 ]]; then
                        echo "Installing the newest Intel graphics card driver."
                        sudo zypper install xf86-video-intel
                        echo "Installed latest driver for Intel graphics card."
                    else
                        echo "The newest Intel graphics card driver is already installed."
                    fi
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if [[$(zypper lr -u) == *"https://download.nvidia.com/opensuse/leap/15.4/"*]] || [[$(zypper lr -u) == *"https://developer.download.nvidia.com/compute/cuda/repos/opensuse15/x86_64/cuda-opensuse15.repo"*]]; then
                        if [[ $(zypper search -i x11-video-nvidiaG05 | grep -c "Version") -eq 0 ]]; then
                            echo "Installing the newest Nvidia graphics card driver."
                            sudo zypper install x11-video-nvidiaG05
                            echo "Installed latest driver for Nvidia graphics card."
                        else
                            echo "The newest Nvidia graphics card driver is already installed."
                        fi
                    else
                        sudo zypper addrepo --refresh 'https://download.nvidia.com/opensuse/leap/$releasever' NVIDIA
                        sudo zypper install x11-video-nvidiaG05
                        echo "The newest Nvidia graphics card driver is already installed."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # ...
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"openSUSE"*"15.5"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
               sudo zypper install dialog wget lsb-release coreutils polkit Mesa-demo-x
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    if [[ $(zypper search -i kernel-firmware-amdgpu | grep -c "Version") -eq 0 ]]; then
                        echo "Installing the newest AMD graphics card driver."
                        sudo zypper install kernel-firmware-amdgpu
                        echo "Installed latest driver for AMD graphics card."
                    else
                        echo "The newest AMD graphics card driver is already installed."
                    fi
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    if [[ $(zypper search -i xf86-video-intel | grep -c "Version") -eq 0 ]]; then
                        echo "Installing the newest Intel graphics card driver."
                        sudo zypper install xf86-video-intel
                        echo "Installed latest driver for Intel graphics card."
                    else
                        echo "The newest Intel graphics card driver is already installed."
                    fi
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if [[$(zypper lr -u) == *"https://download.nvidia.com/opensuse/leap/15.5/"*]] || [[$(zypper lr -u) == *"https://developer.download.nvidia.com/compute/cuda/repos/opensuse15/x86_64/cuda-opensuse15.repo"*]]; then
                        if [[ $(zypper search -i x11-video-nvidiaG05 | grep -c "Version") -eq 0 ]]; then
                            echo "Installing the newest Nvidia graphics card driver."
                            sudo zypper install x11-video-nvidiaG05
                            echo "Installed latest driver for Nvidia graphics card."
                        else
                            echo "The newest Nvidia graphics card driver is already installed."
                        fi
                    else
                        sudo zypper addrepo --refresh 'https://download.nvidia.com/opensuse/leap/$releasever' NVIDIA
                        sudo zypper install x11-video-nvidiaG05
                        echo "The newest Nvidia graphics card driver is already installed."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # ...
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"openSUSE"*"Tumbleweed"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo zypper install dialog wget lsb-release coreutils polkit Mesa-demo-x
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    if [[ $(zypper search -i kernel-firmware-amdgpu | grep -c "Version") -eq 0 ]]; then
                        echo "Installing the newest AMD graphics card driver."
                        sudo zypper install kernel-firmware-amdgpu
                        echo "Installed latest driver for AMD graphics card."
                    else
                        echo "The newest AMD graphics card driver is already installed."
                    fi
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    if [[ $(zypper search -i xf86-video-intel | grep -c "Version") -eq 0 ]]; then
                        echo "Installing the newest Intel graphics card driver."
                        sudo zypper install xf86-video-intel
                        echo "Installed latest driver for Intel graphics card."
                    else
                        echo "The newest Intel graphics card driver is already installed."
                    fi
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if [[$(zypper lr -u) == *"https://download.nvidia.com/opensuse/tumbleweed"*]]; then
                        if [[ $(zypper search -i x11-video-nvidiaG05 | grep -c "Version") -eq 0 ]]; then
                            echo "Installing the newest Nvidia graphics card driver."
                            sudo zypper install x11-video-nvidiaG05
                            echo "Installed latest driver for Nvidia graphics card."
                        else
                            echo "The newest Nvidia graphics card driver is already installed."
                        fi
                    else
                        sudo zypper addrepo --refresh https://download.nvidia.com/opensuse/tumbleweed NVIDIA
                        sudo zypper install x11-video-nvidiaG05
                        echo "The newest Nvidia graphics card driver is already installed."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # ...
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"Red Hat Enterprise Linux"*"8"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo dnf install dialog wget lsb-release coreutils mesa-utils policykit-1
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # ...
            else
                # ...
            fi
         elif [[ $DISTRO_VERSION == *"Red Hat Enterprise Linux"*"9"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo dnf install dialog wget lsb-release coreutils mesa-utils policykit-1
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # ...
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"Solus"*"Linux"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo eopkg -y install dialog wget lsb-release coreutils mesa-utils pkexec
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    sudo eopkg up -y && sudo eopkg it -y mesa-dri-drivers
                    echo "Latest driver for AMD graphics card already installed."
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    sudo eopkg up -y && sudo eopkg it -y libva-intel-driver
                    echo "Latest driver for Intel graphics card already installed."
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    sudo eopkg up -y && sudo eopkg it -y nvidia-glx-driver-current
                    echo "Latest driver for Nvidia graphics card already installed."
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # ...
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"Ubuntu"*"18.04"* ]] || [[ $DISTRO_VERSION == *"Linux Mint"*"19"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo apt-get update && sudo apt-get install -y dialog wget lsb-release coreutils mesa-utils pkexec
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    if [[$(sudo grep -rhE ^deb /etc/apt/sources.list*) == *"https://ppa.launchpadcontent.net/oibaf/graphics-drivers/ubuntu"*]]; then
                        sudo apt-get update && sudo apt-get upgrade -y
                        echo "Latest driver for AMD graphics card already installed."
                    else
                        sudo apt-get update && sudo apt-get install -y mesa-utils
                        sudo add-apt-repository ppa:oibaf/graphics-drivers
                        sudo apt-get update && sudo apt-get upgrade -y
                        sudo apt-get install libvulkan1 mesa-vulkan-drivers vulkan-utils
                        echo "Installed latest driver for AMD graphics card."
                    fi
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    if [[$(sudo grep -rhE ^deb /etc/apt/sources.list*) == *"https://ppa.launchpadcontent.net/oibaf/graphics-drivers/ubuntu"*]]; then
                        sudo apt-get update && sudo apt-get upgrade -y
                        echo "Latest driver for Intel graphics card already installed."
                    else
                        sudo apt-get update && sudo apt-get install -y mesa-utils
                        sudo add-apt-repository ppa:oibaf/graphics-drivers
                        sudo apt-get update && sudo apt-get upgrade -y
                        echo "Installed latest driver for Intel graphics card."
                    fi
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if [[$(sudo grep -rhE ^deb /etc/apt/sources.list*) == *"https://ppa.launchpadcontent.net/graphics-drivers/ppa/ubuntu"*]]; then
                        sudo apt-get update && sudo apt-get upgrade -y
                        echo "Latest driver for Nvidia graphics card already installed."
                    else
                        sudo apt-get purge nvidia*
                        sudo add-apt-repository ppa:graphics-drivers/ppa
                        sudo apt-get update && sudo ubuntu-drivers autoinstall
                        echo "Installed latest driver for Nvidia graphics card."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # ...
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"Ubuntu"*"20.04"* ]] || [[ $DISTRO_VERSION == *"Linux Mint"*"20"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo apt-get update && sudo apt-get install -y dialog wget lsb-release coreutils mesa-utils pkexec
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    if [[$(sudo grep -rhE ^deb /etc/apt/sources.list*) == *"https://ppa.launchpadcontent.net/oibaf/graphics-drivers/ubuntu"*]]; then
                        sudo apt-get update && sudo apt-get upgrade -y
                        echo "Latest driver for AMD graphics card already installed."
                    else
                        sudo apt-get update && sudo apt-get install -y mesa-utils
                        sudo add-apt-repository ppa:oibaf/graphics-drivers
                        sudo apt-get update && sudo apt-get upgrade -y
                        sudo apt-get install libvulkan1 mesa-vulkan-drivers vulkan-utils
                        echo "Installed latest driver for AMD graphics card."
                    fi
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    if [[$(sudo grep -rhE ^deb /etc/apt/sources.list*) == *"https://ppa.launchpadcontent.net/oibaf/graphics-drivers/ubuntu"*]]; then
                        sudo apt-get update && sudo apt-get upgrade -y
                        echo "Latest driver for Intel graphics card already installed."
                    else
                        sudo apt-get update && sudo apt-get install -y mesa-utils
                        sudo add-apt-repository ppa:oibaf/graphics-drivers
                        sudo apt-get update && sudo apt-get upgrade -y
                        echo "Installed latest driver for Intel graphics card."
                    fi
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if [[$(sudo grep -rhE ^deb /etc/apt/sources.list*) == *"https://ppa.launchpadcontent.net/graphics-drivers/ppa/ubuntu"*]]; then
                        sudo apt-get update && sudo apt-get upgrade -y
                        echo "Latest driver for Nvidia graphics card already installed."
                    else
                        sudo apt-get purge nvidia*
                        sudo add-apt-repository ppa:graphics-drivers/ppa
                        sudo apt-get update && sudo ubuntu-drivers autoinstall
                        echo "Installed latest driver for Nvidia graphics card."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # ...
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"Ubuntu"*"22.04"* ]] || [[ $DISTRO_VERSION == *"Linux Mint"*"21"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo apt-get update && sudo apt-get install -y dialog wget lsb-release coreutils mesa-utils pkexec
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    if [[$(sudo grep -rhE ^deb /etc/apt/sources.list*) == *"https://ppa.launchpadcontent.net/oibaf/graphics-drivers/ubuntu"*]]; then
                        sudo apt-get update && sudo apt-get upgrade -y
                        echo "Latest driver for AMD graphics card already installed."
                    else
                        sudo apt-get update && sudo apt-get install -y mesa-utils
                        sudo add-apt-repository ppa:oibaf/graphics-drivers
                        sudo apt-get update && sudo apt-get upgrade -y
                        sudo apt-get install libvulkan1 mesa-vulkan-drivers vulkan-utils
                        echo "Installed latest driver for AMD graphics card."
                    fi
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    if [[$(sudo grep -rhE ^deb /etc/apt/sources.list*) == *"https://ppa.launchpadcontent.net/oibaf/graphics-drivers/ubuntu"*]]; then
                        sudo apt-get update && sudo apt-get upgrade -y
                        echo "Latest driver for Intel graphics card already installed."
                    else
                        sudo apt-get update && sudo apt-get install -y mesa-utils
                        sudo add-apt-repository ppa:oibaf/graphics-drivers
                        sudo apt-get update && sudo apt-get upgrade -y
                        echo "Installed latest driver for Intel graphics card."
                    fi
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    echo "Nvidia graphics card detected."
                    if [[$(sudo grep -rhE ^deb /etc/apt/sources.list*) == *"https://ppa.launchpadcontent.net/graphics-drivers/ppa/ubuntu"*]]; then
                        sudo apt-get update && sudo apt-get upgrade -y
                        echo "Latest driver for Nvidia graphics card already installed."
                    else
                        sudo apt-get purge nvidia*
                        sudo add-apt-repository ppa:graphics-drivers/ppa
                        sudo apt-get update && sudo ubuntu-drivers autoinstall
                        echo "Installed latest driver for Nvidia graphics card."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # ...
            else
                # ...
            fi
        elif [[ $DISTRO_VERSION == *"Void"*"Linux"* ]]; then
            if [ $CHECK_INSTALL_REQUIRED_PACKAGES -eq 1 ]; then
                sudo xbps-install -Sy dialog wget lsb-release coreutils mesa-demos polkit
            elif [ $CHECK_INSTALL_GPU_DRIVER -eq 1 ]; then
                # Install the latest driver for AMD graphics card if not installed:
                if [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"AMD"* ]]; then
                    echo "AMD graphics card detected."
                    if ! xbps-query -Rs xf86-video-amdgpu | grep -q "^xf86-video-amdgpu-"; then
                        sudo xbps-install -S xf86-video-amdgpu
                        echo "Installed latest driver for AMD graphics card."
                    else
                        echo "Latest driver for AMD graphics card already installed."
                    fi
                # Install the latest driver for Intel graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"Intel"* ]]; then
                    echo "Intel graphics card detected."
                    if ! xbps-query -Rs intel-video | grep -q "^intel-video-"; then
                        sudo xbps-install -S intel-video
                        echo "Installed latest driver for Intel graphics card."
                    else
                        echo "Latest driver for Intel graphics card already installed."
                    fi
                # Install the latest driver for Nvidia graphics card if not installed:
                elif [[ $(glxinfo | grep -A 10 -B 1 Vendor) == *"NVIDIA"* ]]; then
                    if ! xbps-query -Rs nvidia | grep -q "^nvidia-"; then
                        sudo xbps-install -S nvidia
                        echo "Installed latest driver for Nvidia graphics card."
                    else
                        echo "Latest driver for Nvidia graphics card already installed."
                    fi
                else
                    echo "Unsupported graphics card detected."
                fi
            elif [ $CHECK_INSTALL_WINE_PACKAGES -eq 1 ]; then
                # ...
            else
                # ...
            fi
        fi
}

























###############################################################################################################################################################
# IMPORTANT NOTICE FOR THE USER:                                                                                                                              #
###############################################################################################################################################################
# With the command: "glxinfo | grep -A 10 -B 1 Vendor"                                                                                                        #
# It automatically detects which graphics card (if AMD, INTEL or NVIDIA) is currently being used for image output and calculation of the applications.        #
# This means that if two graphics cards are installed, it will be checked which one is being used!                                                            #
###############################################################################################################################################################






















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

# ...
