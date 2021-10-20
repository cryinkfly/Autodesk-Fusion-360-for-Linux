#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you can install Autodesk Fusion 360 on various Linux distributions. #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2021                                                                          #
# Time/Date:    13:30/20.10.2021                                                                   #
# Version:      6.0                                                                                #
####################################################################################################

###############################################################################################################################################################
# DESCRIPTION IN DETAIL                                                                                                                                       #
###############################################################################################################################################################
# With the help of my setup wizard, you will be given a way to install Autodesk Fusion 360 with some extensions on                                            #
# Linux so that you don't have to use Windows or macOS for this program in the future!                                                                        #
#                                                                                                                                                             #
# Also, my setup wizard will guides you through the installation step by step and will install some required packages.                                        #
#                                                                                                                                                             #
# The next one is you have the option of installing the program directly on your system or you can install it on an external storage medium.                  #
#                                                                                                                                                             #
# But it's important to know, you must to purchase the licenses directly from the manufacturer of Autodesk Fusion 360, when you will work with them on Linux! #
###############################################################################################################################################################

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# Records the installation of Autodesk Fusion 360!
# This log file will later help with error analysis to find out why the installation did not work.

function logfile-installation {
   mkdir -p "/$HOME/.local/share/fusion360/logfiles" &&
   exec 5> /$HOME/.local/share/fusion360/logfiles/logfile-installation
   BASH_XTRACEFD="5"
   set -x
}

##############################################################################

# Load all files for the installation of Autodesk Fusion 360!

function create-structure {

  mkdir -p data/locale
  mkdir -p data/locale/cs-CZ
  mkdir -p data/locale/de-DE
  mkdir -p data/locale/en-US
  mkdir -p data/locale/es-ES
  mkdir -p data/locale/fr-FR
  mkdir -p data/locale/it-IT
  mkdir -p data/locale/ja-JP
  mkdir -p data/locale/ko-KR
  mkdir -p data/locale/zh-CN
  mkdir -p data/logfiles
  mkdir -p data/resources/extensions
  mkdir -p data/resources/fusion360-installer
  mkdir -p data/resources/wine
}

function load-locale {
  wget -N -P data/locale https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/locale.sh
  chmod +x data/locale/locale.sh
  . data/locale/locale.sh
}

function load-locale-cs {
  . data/locale/cs-CZ/locale-cs.sh
}

function load-locale-de {
  . data/locale/de-DE/locale-de.sh
}

function load-locale-en {
  . data/locale/en-US/locale-en.sh
}

function load-locale-es {
  . data/locale/es-ES/locale-es.sh
}

function load-locale-fr {
  . data/locale/fr-FR/locale-fr.sh
}

function load-locale-it {
  . data/locale/it-IT/locale-it.sh
}

function load-locale-ja {
  . data/locale/ja-JP/locale-ja.sh
}

function load-locale-ko {
  . data/locale/ko-KR/locale-ko.sh
}

function load-locale-zh {
  . data/locale/zh-CN/locale-zh.sh
}

function load-extensions {
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/resources/extensions/extensions.sh
  chmod +x data/resources/extensions/extensions.sh
  . data/resources/extensions/extensions.sh
}

function load-wine_winetricks {
  wget -N -P data/resources/wine https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/resources/wine/wine-standard.sh
  chmod +x data/resources/wine/wine-standard.sh
  wget -N -P data/resources/wine https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/resources/wine/wine-custom.sh
  chmod +x data/resources/wine/wine-custom.sh
  wget -N -P data/resources/wine https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
  chmod +x data/resources/wine/winetricks
  }

function load-fusion360-installer {
  wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360installer.exe
  mv Fusion360installer.exe data/resources/fusion360-installer/Fusion360installer.exe
}


##############################################################################

# It will check whether Autodesk Fusion 360 is already installed on your system or not!

function check-if-fusion360-exists {
log_path="$HOME/.local/share/fusion360/logfiles/log-path" # Search for log files indicting install
if [ -f "$log_path" ]; then
    cp "$HOME/.local/share/fusion360/logfiles/log-path" data/logfiles
    new_modify_deinstall # Exists - Modify install
else
    select-opengl_dxvk # New install
fi
}

function logfile-installation-standard {
   echo "$HOME/.wineprefixes/fusion360/logfiles" >> $HOME/.local/share/fusion360/logfiles/log-path
}

function logfile-installation-custom {
   echo "$custom_directory" >> $HOME/.local/share/fusion360/logfiles/log-path
}

##############################################################################

# For the installation of Autodesk Fusion 360 one of the supported Linux distributions must be selected! - Part 2

function archlinux-1 {
    echo "Checking for multilib..."
    if archlinux-verify-multilib ; then
        echo "multilib found. Continuing..."
        archlinux-2
        select-your-path
    else
        echo "Enabling multilib..."
        echo "[multilib]" | sudo tee -a /etc/pacman.conf
        echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf
        archlinux-2
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
    sudo apt-get update
    sudo apt-get upgrade
    sudo dpkg --add-architecture i386
    wget -nc https://dl.winehq.org/wine-builds/winehq.key
    sudo apt-key add winehq.key
}

function debian-based-2 {
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get install p7zip p7zip-full p7zip-rar curl winbind cabextract wget
    sudo apt-get install --install-recommends winehq-staging
    select-your-path
}

function ubuntu18 {
    sudo apt-add-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
    wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/Release.key -O Release.key -O- | sudo apt-key add -
    sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/ ./'
}

function ubuntu20 {
    sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
    wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_20.04/Release.key -O Release.key -O- | sudo apt-key add -
    sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_20.04/ ./'
}

function ubuntu20_10 {
    sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ groovy main'
    wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_20.10/Release.key -O Release.key -O-
    sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_20.10/ ./'
}

function ubuntu21 {
    # Note: This installs the public key to trusted.gpg.d - While this is "acceptable" behaviour it is not best practice.
    # It is infinitely better than using apt-key add though.
    # For more information and for instructions to utalise best practices, see:
    # https://askubuntu.com/questions/1286545/what-commands-exactly-should-replace-the-deprecated-apt-key

    sudo apt update
    sudo apt upgrade
    sudo dpkg --add-architecture i386
    mkdir -p /tmp/360 && cd /tmp/360
    wget https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_21.04/Release.key
    wget https://dl.winehq.org/wine-builds/winehq.key
    gpg --no-default-keyring --keyring ./temp-keyring.gpg --import Release.key
    gpg --no-default-keyring --keyring ./temp-keyring.gpg --export --output opensuse-wine.gpg && rm temp-keyring.gpg
    gpg --no-default-keyring --keyring ./temp-keyring.gpg --import winehq.key
    gpg --no-default-keyring --keyring ./temp-keyring.gpg --export --output winehq.gpg && rm temp-keyring.gpg
    sudo mv *.gpg /etc/apt/trusted.gpg.d/ && cd /tmp && sudo rm -rf 360
    echo "deb [signed-by=/etc/apt/trusted.gpg.d/opensuse-wine.gpg] https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_21.04/ ./" | sudo tee -a /etc/apt/sources.list.d/opensuse-wine.list
    sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ hirsute main'
}

function ubuntu21_10 {
    # Verify the below repos exist and uncomment this block to replace the above after 21.10 release
    # echo "deb [signed-by=/etc/apt/trusted.gpg.d/opensuse-wine.gpg] https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_21.10/ ./" | sudo tee -a /etc/apt/sources.list.d/opensuse-wine.list &&
    # sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ impish main' &&

    ubuntu21
}

function fedora-based-1 {
    sudo dnf update
    sudo dnf upgrade
    sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}

function fedora-based-2 {
    sudo dnf install p7zip p7zip-plugins curl wget wine cabextract
    select-your-path
}

function redhat-linux {
   sudo subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms
   sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
   sudo dnf upgrade
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

# Remove a exist Autodesk Fusion 360 (Wineprefix)!

function deinstall-exist-fusion360 {
    deinstall-select-fusion360
    rm -r "$deinstall_directory"
    program-exit-uninstall
}

##############################################################################

# Here you have to decide whether you want to use Autodesk Fusion 360 with DXVK (DirectX 9) or OpenGL! - Part 2

function configure-dxvk-or-opengl-standard-1 {
  if [ $driver_used -eq 2 ]; then
      WINEPREFIX=$HOME/.wineprefixes/fusion360 sh data/resources/wine/winetricks -q dxvk
      wget -N -P data/resources/wine https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/DXVK.reg
      WINEPREFIX=$HOME/.wineprefixes/fusion360 wine regedit.exe /data/resources/wine/DXVK.reg
   fi
}

function configure-dxvk-or-opengl-standard-2 {
if [ $driver_used -eq 2 ]; then
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/DXVK.xml
      mv DXVK.xml $HOME/.wineprefixes/fusion360/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options/NMachineSpecificOptions.xml
   else
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml
      mv NMachineSpecificOptions.xml $HOME/.wineprefixes/fusion360/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options/NMachineSpecificOptions.xml
   fi
}

function configure-dxvk-or-opengl-standard-3 {
if [ $driver_used -eq 2 ]; then
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/DXVK.xml
      mv DXVK.xml $HOME/.wineprefixes/fusion360/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options/NMachineSpecificOptions.xml
   else
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml
      mv NMachineSpecificOptions.xml $HOME/.wineprefixes/fusion360/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options/NMachineSpecificOptions.xml
   fi
}

function configure-dxvk-or-opengl-custom-1 {
   if [ $driver_used -eq 2 ]; then
      WINEPREFIX=$custom_directory sh data/resources/wine/winetricks -q dxvk
      wget -N -P data/resources/wine https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/DXVK.reg
      WINEPREFIX=$custom_directory wine regedit.exe data/resources/wine/DXVK.reg
   fi
}

function configure-dxvk-or-opengl-custom-2 {
if [ $driver_used -eq 2 ]; then
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/DXVK.xml
      mv DXVK.xml $custom_directory/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options/NMachineSpecificOptions.xml
   else
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml
      mv NMachineSpecificOptions.xml $custom_directory/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options/NMachineSpecificOptions.xml
   fi
}

function configure-dxvk-or-opengl-custom-3 {
if [ $driver_used -eq 2 ]; then
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/DXVK.xml
      mv DXVK.xml $custom_directory/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options/NMachineSpecificOptions.xml
   else
      wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/NMachineSpecificOptions.xml
      mv NMachineSpecificOptions.xml $custom_directory/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options/NMachineSpecificOptions.xml
   fi
}

##############################################################################
# ALL DIALOGS ARE ARRANGED HERE:
##############################################################################

# Progress indicator dialog

function progress-indicator-dialog {
  (
echo "5" ; sleep 1
echo "# The folder structure will be created." ; sleep 1
create-structure
echo "25" ; sleep 1
echo "# The locale files will be loaded." ; sleep 1
load-locale
echo "35" ; sleep 1
echo "# The extensions will be loaded." ; sleep 1
load-extensions
echo "55" ; sleep 1
echo "# The wine- and winetricks Script is loaded." ; sleep 1
load-wine_winetricks
echo "75" ; sleep 1
echo "# The Autodesk Fusion 360 installation file will be downloaded." ; sleep 1
load-fusion360-installer
echo "90" ; sleep 1
echo "# The installation can now be started!" ; sleep 1
echo "100" ; sleep 1
) |
zenity --progress \
  --title="Autodesk Fusion 360 for Linux - Setup Wizard" \
  --text="The Setup Wizard is being configured ..." \
  --width=400 \
  --height=100 \
  --percentage=0

if [ "$?" = 0 ] ; then
        start-launcher
elif [ "$?" = 1 ] ; then
        zenity --question \
                 --title="$program_name" \
                 --text="Are you sure you want to cancel the installation?" \
                 --width=400 \
                 --height=100
        answer=$?

        if [ "$answer" -eq 0 ]; then
              exit;
        elif [ "$answer" -eq 1 ]; then
              progress-indicator-dialog
        fi
elif [ "$?" = -1 ] ; then
        zenity --error \
          --text="An unexpected error occurred!"
        exit;
fi
}

##############################################################################

# Welcome Screen - Setup Wizard of Autodesk Fusion 360 for Linux

function start-launcher {
  zenity --question \
         --title="$program_name" \
         --text="Would you like to install Autodesk Fusion 360 on your system?" \
         --width=400 \
         --height=100
  answer=$?

  if [ "$answer" -eq 0 ]; then
      configure-locale
  elif [ "$answer" -eq 1 ]; then
      exit;
  fi
}

##############################################################################

# Configure the locale of the Setup Wizard

function configure-locale {

  response=$(zenity --list \
                    --radiolist \
                    --title="$program_name" \
                    --width=700 \
                    --height=500 \
                    --column="Select:" --column="Language:" \
                    TRUE "English (Standard)" \
                    FALSE "German" \
                    FALSE "Czech" \
                    FALSE "Spanish" \
                    FALSE "French" \
                    FALSE "Italian" \
                    FALSE "Japanese" \
                    FALSE "Korean" \
                    FALSE "Chinese")

[[ $response = "English (Standard)" ]] && load-locale-en && licenses-en

[[ $response = "German" ]] && load-locale-de && licenses-de

[[ $response = "Czech" ]] && load-locale-cs && licenses-cs

[[ $response = "Spanish" ]] && load-locale-es && licenses-es

[[ $response = "French" ]] && load-locale-fr && licenses-fr

[[ $response = "Italian" ]] && load-locale-it && licenses-it

[[ $response = "Japanese" ]] && load-locale-ja && licenses-ja

[[ $response = "Korean" ]] && load-locale-ko && licenses-ko

[[ $response = "Chinese" ]] && load-locale-zh && licenses-zh

[[ "$response" ]] || start-launcher
}

##############################################################################

# Load & View the LICENSE AGREEMENT of this Setup Wizard - cs-CZ

function licenses-cs {

license_cs=`dirname $0`/data/locale/cs-CZ/license-cs

zenity --text-info \
       --title="$program_name" \
       --width=700 \
       --height=500 \
       --filename=$license_cs \
       --checkbox="$text_license_checkbox"

case $? in
    0)
        echo "Start the installation."
        check-if-fusion360-exists
	      ;;
    1)
        echo "Go back"
        configure-locale
	      ;;
    -1)
        zenity --error \
          --text="$text_error"
        exit;
	      ;;
esac

}

##############################################################################

# Load & View the LICENSE AGREEMENT of this Setup Wizard - de-DE

function licenses-de {

license_de=`dirname $0`/data/locale/de-DE/license-de

zenity --text-info \
       --title="$program_name" \
       --width=700 \
       --height=500 \
       --filename=$license_de \
       --checkbox="$text_license_checkbox"

case $? in
    0)
        echo "Start the installation."
        check-if-fusion360-exists
	      ;;
    1)
        echo "Go back"
        configure-locale
	      ;;
    -1)
        zenity --error \
          --text="$text_error"
        exit;
	      ;;
esac

}

##############################################################################

# Load & View the LICENSE AGREEMENT of this Setup Wizard - en-US

function licenses-en {

license_en=`dirname $0`/data/locale/en-US/license-en

zenity --text-info \
       --title="$program_name" \
       --width=700 \
       --height=500 \
       --filename=$license_en \
       --checkbox="$text_license_checkbox"

case $? in
    0)
        echo "Start the installation."
        check-if-fusion360-exists
	      ;;
    1)
        echo "Go back."
        configure-locale
	      ;;
    -1)
        zenity --error \
          --text="$text_error"
        exit;
        ;;
esac
}

##############################################################################

# Load & View the LICENSE AGREEMENT of this Setup Wizard - es-ES

function licenses-es {

license_es=`dirname $0`/data/locale/es-ES/license-es

zenity --text-info \
       --title="$program_name" \
       --width=700 \
       --height=500 \
       --filename=$license_es \
       --checkbox="$text_license_checkbox"

case $? in
    0)
        echo "Start the installation."
        check-if-fusion360-exists
	      ;;
    1)
        echo "Go back"
        configure-locale
	      ;;
    -1)
        zenity --error \
          --text="$text_error"
        exit;
	      ;;
esac

}

##############################################################################

# Load & View the LICENSE AGREEMENT of this Setup Wizard - fr-FR

function licenses-fr {

license_fr=`dirname $0`/data/locale/fr-FR/license-fr

zenity --text-info \
       --title="$program_name" \
       --width=700 \
       --height=500 \
       --filename=$license_fr \
       --checkbox="$text_license_checkbox"

case $? in
    0)
        echo "Start the installation."
        check-if-fusion360-exists
	      ;;
    1)
        echo "Go back"
        configure-locale
	      ;;
    -1)
        zenity --error \
          --text="$text_error"
        exit;
	      ;;
esac

}

##############################################################################

# Load & View the LICENSE AGREEMENT of this Setup Wizard - it-IT

function licenses-it {

license_it=`dirname $0`/data/locale/it-IT/license-it

zenity --text-info \
       --title="$program_name" \
       --width=700 \
       --height=500 \
       --filename=$license_it \
       --checkbox="$text_license_checkbox"

case $? in
    0)
        echo "Start the installation."
        check-if-fusion360-exists
	      ;;
    1)
        echo "Go back"
        configure-locale
	      ;;
    -1)
        zenity --error \
          --text="$text_error"
        exit;
      	;;
esac

}

##############################################################################

# Load & View the LICENSE AGREEMENT of this Setup Wizard - ja-JP

function licenses-ja {

license_ja=`dirname $0`/data/locale/ja-JP/license-ja

zenity --text-info \
       --title="$program_name" \
       --width=700 \
       --height=500 \
       --filename=$license_ja \
       --checkbox="$text_license_checkbox"

case $? in
    0)
        echo "Start the installation."
        check-if-fusion360-exists
	      ;;
    1)
        echo "Go back"
        configure-locale
	      ;;
    -1)
        zenity --error \
          --text="$text_error"
        exit;
	      ;;
esac

}

##############################################################################

# Load & View the LICENSE AGREEMENT of this Setup Wizard - ko-KR

function licenses-ko {

license_ko=`dirname $0`/data/locale/ko-KR/license-ko

zenity --text-info \
       --title="$program_name" \
       --width=700 \
       --height=500 \
       --filename=$license_ko \
       --checkbox="$text_license_checkbox"

case $? in
    0)
        echo "Start the installation."
        check-if-fusion360-exists
	      ;;
    1)
        echo "Go back"
        configure-locale
	      ;;
    -1)
        zenity --error \
          --text="$text_error"
        exit;
	      ;;
esac

}

##############################################################################

# Load & View the LICENSE AGREEMENT of this Setup Wizard - zh-CN

function licenses-zh {

license_zh=`dirname $0`/data/locale/zh-CN/license-zh

zenity --text-info \
       --title="$program_name" \
       --width=700 \
       --height=500 \
       --filename=$license_zh \
       --checkbox="$text_license_checkbox"

case $? in
    0)
        echo "Start the installation."
        check-if-fusion360-exists
	      ;;
    1)
        echo "Go back"
        configure-locale
	      ;;
    -1)
        zenity --error \
          --text="$text_error"
        exit;
      	;;
esac

}

##############################################################################

# Autodesk Fusion 360 will be installed from scratch on this system!

function select-opengl_dxvk {
  response=$(zenity --list \
                    --radiolist \
                    --title="$program_name" \
                    --width=700 \
                    --height=500 \
                    --column="$text_select" --column="$text_driver" \
                    TRUE "$text_driver_opengl" \
                    FALSE "$text_driver_dxvk")

[[ $response = "$text_driver_opengl" ]] && driver_used=1 && select-your-os

[[ $response = "$text_driver_dxvk" ]] && driver_used=2 && select-your-os

[[ "$response" ]] || echo "Go back" && configure-locale
}

##############################################################################

# For the installation of Autodesk Fusion 360 one of the supported Linux distributions must be selected! - Part 1

function select-your-os {
  response=$(zenity --list \
                    --radiolist \
                    --title="$program_name" \
                    --width=700 \
                    --height=500 \
                    --column="$text_select" --column="$text_linux_distribution" \
                    FALSE "Arch Linux, Manjaro Linux, EndeavourOS, ..." \
                    FALSE "Debian 10, MX Linux 19.4, Raspberry Pi Desktop, ..." \
                    FALSE "Debian 11" \
                    FALSE "Fedora 33" \
                    FALSE "Fedora 34" \
                    FALSE "openSUSE Leap 15.2" \
                    FALSE "openSUSE Leap 15.3" \
                    FALSE "openSUSE Tumbleweed" \
                    FALSE "Red Hat Enterprise Linux 8.x" \
                    FALSE "Solus" \
                    FALSE "Ubuntu 18.04, Linux Mint 19.x, ..." \
                    FALSE "Ubuntu 20.04, Linux Mint 20.x, Pop!_OS 20.04, ..." \
                    FALSE "Ubuntu 20.10" \
                    FALSE "Ubuntu 21.04, Pop!_OS 21.04, ..." \
                    FALSE "Ubuntu 21.10" \
                    FALSE "Void Linux" \
                    FALSE "Gentoo Linux")

[[ $response = "Arch Linux, Manjaro Linux, EndeavourOS, ..." ]] && archlinux-1

[[ $response = "Debian 10, MX Linux 19.4, Raspberry Pi Desktop, ..." ]] && debian-based-1 && sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ buster main' && debian-based-2

[[ $response = "Debian 11" ]] && debian-based-1 && sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/debian/ bullseye main' && debian-based-2

[[ $response = "Fedora 33" ]] && fedora-based-1 && sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/33/winehq.repo && fedora-based-2

[[ $response = "Fedora 34" ]] && fedora-based-1 && sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/34/winehq.repo && fedora-based-2

[[ $response = "openSUSE Leap 15.2" ]] && su -c 'zypper up && zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.2/ wine && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.2/ wine && zypper install p7zip-full curl wget wine cabextract' && select-your-path

[[ $response = "openSUSE Leap 15.3" ]] && su -c 'zypper up && zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.3/ wine && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.3/ wine && zypper install p7zip-full curl wget wine cabextract' && select-your-path

[[ $response = "openSUSE Tumbleweed" ]] && su -c 'zypper up && zypper install p7zip-full curl wget wine cabextract' && select-your-path

[[ $response = "Red Hat Enterprise Linux 8.x" ]] && redhat-linux && select-your-path

[[ $response = "Solus" ]] && solus-linux && select-your-path

[[ $response = "Ubuntu 18.04, Linux Mint 19.x, ..." ]] && debian-based-1 && ubuntu18 && debian-based-2

[[ $response = "Ubuntu 20.04, Linux Mint 20.x, Pop!_OS 20.04, ..." ]] && debian-based-1 && ubuntu20 && debian-based-2

[[ $response = "Ubuntu 20.10" ]] && debian-based-1 && ubuntu20_10 && debian-based-2

[[ $response = "Ubuntu 21.04, Pop!_OS 21.04, ..." ]] && ubuntu21 && debian-based-2

[[ $response = "Ubuntu 21.10" ]] && ubuntu21_10 && debian-based-2

[[ $response = "Void Linux" ]] && void-linux && select-your-path

[[ $response = "Gentoo Linux" ]] && gentoo-linux && select-your-path

[[ "$response" ]] || echo "Go back" && select-opengl_dxvk
}

##############################################################################

# Here you can determine how Autodesk Fusion 360 should be instierlert! (Installation location)

function select-your-path {
  response=$(zenity --list \
                    --radiolist \
                    --title="$program_name" \
                    --width=700 \
                    --height=500 \
                    --column="$text_select" --column="$text_installation_location" \
                    TRUE "$text_installation_location_standard" \
                    FALSE "$text_installation_location_custom")

[[ $response = "$text_installation_location_standard" ]] && . data/resources/wine/wine-standard.sh

[[ $response = "$text_installation_location_custom" ]] && select-your-path-fusion360 && . data/resources/wine/wine-custom.sh

[[ "$response" ]] || echo "Go back" && abort-installation
}

##############################################################################

# Create & Select a directory for your Autodesk Fusion 360!

function select-your-path-fusion360 {
custom_directory=`zenity --file-selection --directory --title="$text_select_location_custom"`
}

##############################################################################

# Abort the installation of Autodesk Fusion 360!

function abort-installation {
  zenity --question \
         --title="$program_name" \
         --text="$text_abort" \
         --width=400 \
         --height=100
  answer=$?

  if [ "$answer" -eq 0 ]; then
      exit;
  elif [ "$answer" -eq 1 ]; then
      select-your-path
  fi
}

##############################################################################

# The installation is complete and will be terminated.

function program-exit {
  zenity --info \
  --text="$text_completed_installation"

  exit;
}

##############################################################################

# Autodesk Fusion 360 has already been installed on your system and you will now be given various options to choose from!

function new_modify_deinstall {
  response=$(zenity --list \
                    --radiolist \
                    --title="$program_name" \
                    --width=700 \
                    --height=500 \
                    --column="$text_select" --column="$text_select_option" \
                    TRUE "$text_select_option_1" \
                    FALSE "$text_select_option_2" \
                    FALSE "$text_select_option_3")

[[ $response = "$text_select_option_1" ]] && view-exist-fusion360

[[ $response = "$text_select_option_2" ]] && edit-exist-fusion360

[[ $response = "$text_select_option_3" ]] && deinstall-exist-fusion360

[[ "$response" ]] || echo "Go back" && configure-locale

}

##############################################################################

# View the path of your exist Autodesk Fusion 360! -View

function view-exist-fusion360 {
  file=`dirname $0`/$HOME/.local/share/fusion360/logfiles/log-path
  directory=`zenity --text-info \
         --title="$program_name" \
         --width=700 \
         --height=500 \
         --filename=$file \
         --checkbox="$text_new_installation_checkbox"`

  case $? in
      0)
          new_modify-select-opengl_dxvk
  	      ;;
      1)
          echo "Go back"
          new_modify_deinstall
  	      ;;
      -1)
        zenity --error \
          --text="$text_error"
          exit;
  	      ;;
  esac

}

##############################################################################

# View the path of your exist Autodesk Fusion 360! - edit-exist-fusion360

function edit-exist-fusion360 {
  file=`dirname $0`/data/logfiles/log-path
  directory=`zenity --text-info \
         --title="$program_name" \
         --width=700 \
         --height=500 \
         --filename=$file \
         --checkbox="$text_edit_installation_checkbox"`

  case $? in
      0)
          new_modify-select-opengl_dxvk
  	      ;;
      1)
          echo "Go back"
          new_modify_deinstall
  	      ;;
      -1)
        zenity --error \
          --text="$text_error"
          exit;
  	      ;;
  esac

}

##############################################################################

# Autodesk Fusion 360 will be installed from scratch on this system!

function new_modify-select-opengl_dxvk {
  response=$(zenity --list \
                    --radiolist \
                    --title="$program_name" \
                    --width=700 \
                    --height=500 \
                    --column="$text_select" --column="$text_driver" \
                    TRUE "$text_driver_opengl" \
                    FALSE "$text_driver_dxvk")

[[ $response = "$text_driver_opengl" ]] && driver_used=1 && select-your-path-fusion360 && . data/resources/wine/wine.sh && winetricks-custom

[[ $response = "$text_driver_dxvk" ]] && driver_used=2 && select-your-path-fusion360 && . data/resources/wine/wine.sh && winetricks-custom

[[ "$response" ]] || echo "Go back" && configure-locale
}

##############################################################################

# Deinstall a exist Autodesk Fusion 360 installation!

function deinstall-view-exist-fusion360 {
  file=`dirname $0`/data/logfiles/log-path
  directory=`zenity --text-info \
         --title="$program_name" \
         --width=700 \
         --height=500 \
         --filename=$file \
         --editable \
         --checkbox="$text_deinstall_checkbox"`

  case $? in
      0)
          zenity --question \
                 --title="$program_name" \
                 --text="$text_deinstall_question" \
                 --width=400 \
                 --height=100
          answer=$?

          if [ "$answer" -eq 0 ]; then
              echo "$directory" > $file
	      cp "$file" $HOME/.local/share/fusion360/logfiles/log-path
              deinstall-select-fusion360
          elif [ "$answer" -eq 1 ]; then
              deinstall-exist-fusion360
          fi

  	      ;;
      1)
          echo "Go back"
          new_modify_deinstall
  	      ;;
      -1)
        zenity --error \
          --text="$text_error"
          exit;
  	      ;;
  esac

}

##############################################################################

# Select your exist Autodesk Fusion 360 for the deinstallation!

function deinstall-select-fusion360 {
  deinstall_directory=`zenity --file-selection --directory --title="$text_select_location_deinstall"`
}

##############################################################################

# The uninstallation is complete and will be terminated.

function program-exit-uninstall {
  zenity --info \
  --text="$text_completed_deinstallation"

  exit;
}

##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

# Reset the driver for the installation of Autodesk Fusion 360!
driver_used=0

# Name of this program (Window Title)
program_name="Autodesk Fusion 360 for Linux - Setup Wizard"

logfile-installation
progress-indicator-dialog
