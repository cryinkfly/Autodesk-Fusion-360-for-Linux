#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you can install Autodesk Fusion 360 on Linux.                       #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    12:00/30.04.2022                                                                   #
# Version:      1.7.9 -> 1.8.0                                                                     #
####################################################################################################

# Path: /$HOME/.fusion360/bin/install.sh

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
# THE INITIALIZATION OF DEPENDENCIES STARTS HERE:                                                                                                             #
###############################################################################################################################################################

# Create the structure for the installation of Autodesk Fusion 360:
function SP_STRUCTURE {
  mkdir -p $SP_PATH/bin
  mkdir -p $SP_PATH/locale/cs-CZ
  mkdir -p $SP_PATH/locale/de-DE
  mkdir -p $SP_PATH/locale/en-US
  mkdir -p $SP_PATH/locale/es-ES
  mkdir -p $SP_PATH/locale/fr-FR
  mkdir -p $SP_PATH/locale/it-IT
  mkdir -p $SP_PATH/locale/ja-JP
  mkdir -p $SP_PATH/locale/ko-KR
  mkdir -p $SP_PATH/locale/zh-CN
  mkdir -p $SP_PATH/extensions
  mkdir -p $SP_PATH/logs
  mkdir -p $SP_PATH/downloads
  echo "EN" > /tmp/settings.txt
  echo "DXVK" >> /tmp/settings.txt
}

###############################################################################################################################################################

# Load the index of locale files:
function SP_LOCALE_INDEX {
  wget -N -P $SP_PATH/locale https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/locale.sh
  chmod +x $SP_PATH/locale/locale.sh
  . $SP_PATH/locale/locale.sh
}

# Czech:
function SP_LOCALE_CS {
  SP_LOCALE="cs-CZ"
  . $SP_PATH/locale/cs-CZ/locale-cs.sh
}

# German:
function SP_LOCALE_DE {
  SP_LOCALE="de-DE"
  . $SP_PATH/locale/de-DE/locale-de.sh
}

# English:
function SP_LOCALE_EN {
  SP_LOCALE="en-US"
  . $SP_PATH/locale/en-US/locale-en.sh
}

# Spanish:
function SP_LOCALE_ES {
  SP_LOCALE="es-ES"
  . $SP_PATH0/locale/es-ES/locale-es.sh
}

# French:
function SP_LOCALE_FR {
  SP_LOCALE="fr-FR"
  . $SP_PATH/locale/fr-FR/locale-fr.sh
}


# Italian:
function SP_LOCALE_IT {
  SP_LOCALE="it-IT"
  . $SP_PATH/locale/it-IT/locale-it.sh
}

# Japanese:
function SP_LOCALE_JA {
  SP_LOCALE="ja-JP"
  . $SP_PATH/locale/ja-JP/locale-ja.sh
}

# Korean:
function SP_LOCALE_KO {
  SP_LOCALE="ko-KR"
  . $SP_PATH/locale/ko-KR/locale-ko.sh
}

# Chinese:
function SP_LOCALE_ZH {
  SP_LOCALE="zh-CN"
  . $SP_PATH/locale/zh-CN/locale-zh.sh
}

###############################################################################################################################################################

# Load the newest winetricks version:
function SP_WINETRICKS_LOAD {
  wget -N -P $SP_PATH/bin https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
  chmod +x $SP_PATH/bin/winetricks
}

###############################################################################################################################################################

# Load newest Autodesk Fusion 360 installer version for the Setup Wizard!
function SP_FUSION360_INSTALLER_LOAD {
  # Search for a existing installer of Autodesk Fusion 360
  FUSION360_INSTALLER="$SP_PATH/downloads/Fusion360installer.exe"
  if [ -f "$FUSION360_INSTALLER" ]; then
    echo "The Autodesk Fusion 360 installer exist!"
  else
    echo "The Autodesk Fusion 360 installer doesn't exist and will be downloaded for you!"
    wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360installer.exe
    mv "Fusion360installer.exe" "$HOME/.config/fusion-360/downloads/Fusion360installer.exe"
  fi
}

###############################################################################################################################################################

# Load the icons and .desktop-files:
function SP_FUSION360_SHORTCUTS_LOAD {
  # Create a .desktop file (launcher.sh) for Autodesk Fusion 360!
  wget -N -P $SP_PATH/bin https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/fusion360.svg
  mkdir -p $HOME/.local/share/applications/wine/Programs/Autodesk
  echo "[Desktop Entry]" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360.desktop
  echo "Name=Autodesk Fusion 360" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360.desktop    
  echo "Comment=Autodesk Fusion 360 is a cloud-based 3D modeling, CAD, CAM, and PCB software platform for product design and manufacturing." >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360.desktop
  echo "Exec=bash ./launcher.sh" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360.desktop
  echo "Type=Application" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360.desktop
  echo "Categories=Development;Graphics;Science" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360.desktop
  echo "StartupNotify=true" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360.desktop
  echo "Icon=$SP_PATH/bin/fusion360.svg" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360.desktop
  echo "Terminal=true" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360.desktop
  echo "Path=$SP_PATH/bin" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360.desktop
  # Create a .desktop file (uninstall.sh) for Autodesk Fusion 360!
  wget -N -P $SP_PATH/bin https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/fusion360-uninstall.svg
  echo "[Desktop Entry]" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360\ Uninstall.desktop
  echo "Name=Autodesk Fusion 360 - Uninstall" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360\ Uninstall.desktop    
  echo "Comment=With this program you can delete Autodesk Fusion 360 on your system!" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360\ Uninstall.desktop
  echo "Exec=bash ./uninstall.sh" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360\ Uninstall.desktop
  echo "Type=Application" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360\ Uninstall.desktop
  echo "Categories=Development;Graphics;Science" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360\ Uninstall.desktop
  echo "StartupNotify=true" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360\ Uninstall.desktop
  echo "Icon=$SP_PATH/bin/fusion360-uninstall.svg" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360\ Uninstall.desktop
  echo "Terminal=true" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360\ Uninstall.desktop
  echo "Path=$SP_PATH/bin" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360\ Uninstall.desktop
  wget -N -P $SP_PATH/bin https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/uninstall.sh
  chmod +x $SP_PATH/bin/uninstall.sh  
  wget -N -P $SP_PATH/bin https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/launcher.sh
  chmod +x $SP_PATH/bin/launcher.sh
  wget -N -P $SP_PATH/bin https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/update.sh
  chmod +x $SP_PATH/bin/update.sh
  wget -N -P $SP_PATH/bin https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/read-text.sh
  chmod +x $SP_PATH/bin/read-text.sh
}

###############################################################################################################################################################
# ALL LOG-FUNCTIONS ARE ARRANGED HERE:                                                                                                                        #
###############################################################################################################################################################

# Provides information about setup actions during installation.
function SP_LOGFILE {
  exec 5> $SP_PATH/logs/setupact.log
  BASH_XTRACEFD="5"
  set -x
}

###############################################################################################################################################################
# ALL FUNCTIONS FOR DXVK AND OPENGL START HERE:                                                                                                               #
###############################################################################################################################################################

function SP_DXVK_OPENGL_1 {
  if [[ $SP_DRIVER = "DXVK" ]]; then
    WINEPREFIX=$WP_PATH sh $SP_PATH/bin/winetricks -q dxvk
    wget -N -P $WP_PATH/drive_c/users/$USER/Downloads https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/driver/video/dxvk/DXVK.reg
    cd "$WP_PATH/drive_c/users/$USER/Downloads"
    WINEPREFIX=$WP_PATH wine regedit.exe DXVK.reg
  fi
}

function SP_DXVK_OPENGL_2 {
  if [[ $SP_DRIVER = "DXVK" ]]; then
    wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/driver/video/dxvk/DXVK.xml
    mv "DXVK.xml" "NMachineSpecificOptions.xml"
  else
    wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/driver/video/opengl/OpenGL.xml
    mv "OpenGL.xml" "NMachineSpecificOptions.xml"
  fi
}

###############################################################################################################################################################
# ALL FUNCTIONS FOR WINE AND WINETRICKS START HERE:                                                                                                           #
###############################################################################################################################################################

# Autodesk Fusion 360 will now be installed using Wine and Winetricks.
function SP_FUSION360_INSTALL {
  # Note that the winetricks sandbox verb merely removes the desktop integration and Z: drive symlinks and is not a "true" sandbox.
  # It protects against errors rather than malice. It's useful for, e.g., keeping games from saving their settings in random subdirectories of your home directory. 
  # But it still ensures that wine, for example, no longer has access permissions to Home! 
  # For this reason, the EXE files must be located directly in the Wineprefix folder!
  WINEPREFIX=$WP_PATH sh $SP_PATH/bin/winetricks -q sandbox
  # We must install some packages!
  WINEPREFIX=$WP_PATH sh $SP_PATH/bin/winetricks -q atmlib gdiplus corefonts cjkfonts msxml4 msxml6 vcrun2017 fontsmooth=rgb winhttp win10
  # We must install cjkfonts again then sometimes it doesn't work in the first time!
  WINEPREFIX=$WP_PATH sh $SP_PATH/bin/winetricks -q cjkfonts
  SP_DXVK_OPENGL_1
  # We must copy the EXE-file directly in the Wineprefix folder (Sandbox-Mode)!
  cp "$SP_PATH/downloads/Fusion360installer.exe" "$wineprefixname/drive_c/users/$USER/Downloads"
  WINEPREFIX=$WP_PATH wine $wineprefixname/drive_c/users/$USER/Downloads/Fusion360installer.exe -p deploy -g -f log.txt --quiet
  WINEPREFIX=$WP_PATH wine $wineprefixname/drive_c/users/$USER/Downloads/Fusion360installer.exe -p deploy -g -f log.txt --quiet
  mkdir -p "$WP_PATH/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options"
  cd "$WP_PATH/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options"
  SP_DXVK_OPENGL_2
  mkdir -p "$WP_PATH/drive_c/users/$USER/AppData/Local/Autodesk/Neutron Platform/Options"
  cd "$WP_PATH/drive_c/users/$USER/AppData/Local/Autodesk/Neutron Platform/Options"
  SP_DXVK_OPENGL_2
  mkdir -p "$WP_PATH/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options"
  cd "$WP_PATH/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options"
  SP_DXVK_OPENGL_2
  cd "SP_PATH/bin"
  SP_FUSION360_SHORTCUTS_LOAD
  SP_FUSION360_EXTENSIONS
  SP_COMPLETED
}

###############################################################################################################################################################
# ALL FUNCTIONS FOR SUPPORTED LINUX DISTRIBUTIONS START HERE:                                                                                                 #
###############################################################################################################################################################

function OS_ARCHLINUX {
  echo "Checking for multilib..."
  if ARCHLINUX_VERIFY_MULTILIB ; then
    echo "multilib found. Continuing..."
    sudo pacman -Sy --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
    SP_FUSION360_INSTALL
  else
    echo "Enabling multilib..."
    echo "[multilib]" | sudo tee -a /etc/pacman.conf
    echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf
    sudo pacman -Sy --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
    SP_FUSION360_INSTALL
  fi
}

function ARCHLINUX_VERIFY_MULTILIB {
  if cat /etc/pacman.conf | grep -q '^\[multilib\]$' ; then
    true
  else
    false
  fi
}

###############################################################################################################################################################

function DEBIAN_BASED_1 {
  # Some systems require this command for all repositories to work properly and for the packages to be downloaded for installation!
  sudo apt-get --allow-releaseinfo-change update  
  # Added i386 support for wine!
  sudo dpkg --add-architecture i386
}

function DEBIAN_BASED_2 {
  sudo apt-get update
  sudo apt-get install p7zip p7zip-full p7zip-rar curl winbind cabextract wget
  sudo apt-get install --install-recommends winehq-staging
  SP_FUSION360_INSTALL
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

function FEDORA_BASED_1 {
  sudo dnf update
  sudo dnf upgrade
  sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}

function FEDORA_BASED_2 {
  sudo dnf install p7zip p7zip-plugins curl wget wine cabextract
  SP_FUSION360_INSTALL
}

function OS_FEDORA_34 {
  sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_34/Emulators:Wine:Fedora.repo
}

function OS_FEDORA_35 {
  sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_35/Emulators:Wine:Fedora.repo
}

function OS_FEDORA_36 {
  sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_36/Emulators:Wine:Fedora.repo
}

###############################################################################################################################################################

function OS_OPENSUSE_152 {
  su -c 'zypper up && zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.2/ wine && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.2/ wine && zypper install p7zip-full curl wget wine cabextract'
  SP_FUSION360_INSTALL
}

function OS_OPENSUSE_153 {
  su -c 'zypper up && zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.3/ wine && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.3/ wine && zypper install p7zip-full curl wget wine cabextract'
  SP_FUSION360_INSTALL
}

# Has not been published yet!
function OS_OPENSUSE_154 {
  su -c 'zypper up && zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.4/ wine && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.4/ wine && zypper install p7zip-full curl wget wine cabextract'
  SP_FUSION360_INSTALL
}

function OS_OPENSUSE_TW {
  su -c 'zypper up && zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/ wine && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/ wine && zypper install p7zip-full curl wget wine cabextract'
  SP_FUSION360_INSTALL
}

###############################################################################################################################################################

function OS_REDHAT_LINUX_8 {
  sudo subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms
  sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
  sudo dnf upgrade
  sudo dnf install wine
  SP_FUSION360_INSTALL
}

function OS_REDHAT_LINUX_9 {
  sudo subscription-manager repos --enable codeready-builder-for-rhel-9-x86_64-rpms
  sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
  sudo dnf upgrade
  sudo dnf install wine
  SP_FUSION360_INSTALL
}

###############################################################################################################################################################

function OS_SOLUS_LINUX {
  sudo eopkg install -y wine winetricks p7zip curl cabextract samba ppp
  SP_FUSION360_INSTALL
}

###############################################################################################################################################################

function OS_VOID_LINUX {
  sudo xbps-install -Sy wine wine-mono wine-gecko winetricks p7zip curl cabextract samba ppp
  SP_FUSION360_INSTALL
}

###############################################################################################################################################################

function OS_GENTOO_LINUX {
  sudo emerge -nav virtual/wine app-emulation/winetricks app-emulation/wine-mono app-emulation/wine-gecko app-arch/p7zip app-arch/cabextract net-misc/curl net-fs/samba net-dialup/ppp
  SP_FUSION360_INSTALL
}

###############################################################################################################################################################
# ALL FUNCTIONS FOR THE EXTENSIONS START HERE:                                                                                                                #
###############################################################################################################################################################

# Install a extension: Airfoil Tools

function EXTENSION_AIRFOIL_TOOLS {
  cd "$WP_PATH/drive_c/users/$USER/Downloads"
  wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/files/extensions/AirfoilTools_win64.msi &&
  WINEPREFIX=$WP_PATH wine AirfoilTools_win64.msi
}

###############################################################################################################################################################

# Install a extension: Additive Assistant (FFF)

function EXTENSION_ADDITIVE_ASSISTANT {
  cd "$WP_PATH/drive_c/users/$USER/Downloads"
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/AdditiveAssistant.bundle-win64.msi &&
  WINEPREFIX=$WP_PATH msiexec /i AdditiveAssistant.bundle-win64.msi
}

###############################################################################################################################################################

# Install a extension: Czech localization for F360
function EXTENSION_CZECH_LOCALE {
  SP_SEARCH_EXTENSION_CZECH_LOCALE
  WINEPREFIX=$WP_PATH msiexec /i $CZECH_LOCALE_EXTENSION
}

###############################################################################################################################################################

# Install a extension: HP 3D Printers for Autodesk® Fusion 360™
function EXTENSION_HP_3DPRINTER_CONNECTOR {
  cd "$WP_PATH/drive_c/users/$USER/Downloads"
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/HP_3DPrinters_for_Fusion360-win64.msi &&
  WINEPREFIX=$WP_PATH msiexec /i HP_3DPrinters_for_Fusion360-win64.msi
}

###############################################################################################################################################################

# Install a extension: Helical Gear Generator
function EXTENSION_HELICAL_GEAR_GENERATOR {
  cd "$WP_PATH/drive_c/users/$USER/Downloads"
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/HelicalGear_win64.msi &&
  WINEPREFIX=$WP_PATH msiexec /i HelicalGear_win64.msi
}

###############################################################################################################################################################

# Install a extension: OctoPrint for Autodesk® Fusion 360™
function EXTENSION_OCTOPRINT {
  cd "$WP_PATH/drive_c/users/$USER/Downloads"
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/OctoPrint_for_Fusion360-win64.msi &&
  WINEPREFIX=$WP_PATH msiexec /i OctoPrint_for_Fusion360-win64.msi
}

###############################################################################################################################################################

# Install a extension: Parameter I/O
function EXTENSION_PARAMETER_IO {
  cd "$WP_PATH/drive_c/users/$USER/Downloads"
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/ParameterIO_win64.msi &&
  WINEPREFIX=$WP_PATH msiexec /i ParameterIO_win64.msi
}

###############################################################################################################################################################

# Install a extension: RoboDK
function EXTENSION_ROBODK {
  cd "$WP_PATH/drive_c/users/$USER/Downloads"
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/RoboDK.bundle-win64.msi &&
  WINEPREFIX=$WP_PATH msiexec /i RoboDK.bundle-win64.msi
}

###############################################################################################################################################################

# Install a extension: Ultimaker Digital Factory for Autodesk Fusion 360™
function EXTENSION_ULTIMAKER_DIGITAL_FACTORY {
  cd "$WP_PATH/drive_c/users/$USER/Downloads"
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/Ultimaker_Digital_Factory-win64.msi &&
  WINEPREFIX=$WP_PATH msiexec /i Ultimaker_Digital_Factory-win64.msi
}

###############################################################################################################################################################
# ALL DIALOGS ARE ARRANGED HERE:                                                                                                                              #
###############################################################################################################################################################

function SP-WELCOME {
yad \
--form \
--separator="" \
--center \
--height=125 \
--width=750 \
--buttons-layout=center \
--title="" \
--field="<big>SP_TITLE</big>:LBL" \
--field="$SP_WELCOME_LABEL_1:LBL" \
--field="$SP_WELCOME_LABEL_2:LBL" \
--align=center \
--button=gtk-about!!"$SP_WELCOME_TOOLTIP_1":1 \
--button=gtk-preferences!!"$SP_WELCOME_TOOLTIP_2":2 \
--button=gtk-cancel:99 \
--button=gtk-ok:3

ret=$?

# Responses to above button presses are below:
if [[ $ret -eq 1 ]]; then
    xdg-open https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux
    SP-WELCOME
elif [[ $ret -eq 2 ]]; then
    SP-SETTINGS
    SP_LOCALE_SETTINGS
    SP_DRIVER_SETTINGS
    SP-WELCOME
elif [[ $ret -eq 3 ]]; then
    SP_LICENSE
fi
}

###############################################################################################################################################################

function SP_SETTINGS {
yad --title="" \
--form --separator="," --item-separator="," \
--borders=15 \
--width=550 \
--buttons-layout=center \
--align=center \
--field="<big><b>$SP_SETTINGS_TITLE</b></big>:LBL" \
--field=":LBL" \
--field="$SP_SETTINGS_LABEL_1:LBL" \
--field="$SP_LOCALE_LABEL:CB" \
--field="$SP_DRIVER_LABEL:CB" \
--field="$SP_SETTINGS_LABEL_2:LBL" \
"" "" "" "$SP_LOCALE_SELECT" "$SP_DRIVER_SELECT" "" | while read line; do
echo "`echo $line | awk -F',' '{print $4}'`" > /tmp/settings.txt
echo "`echo $line | awk -F',' '{print $5}'`" >> /tmp/settings.txt
done
}

###############################################################################################################################################################

function SP_LOCALE_SETTINGS {
SP_LOCALE=`cat /tmp/settings.txt | awk 'NR == 1'`
if [[ $SP_LOCALE = "Czech" ]]; then
    echo "CS"
    SP_LOCALE_CS
    LICENSE="$SP_PATH/locale/cs-CZ/license-cs.txt"
elif [[ $SP_LOCALE = "English" ]]; then
    echo "EN"
    SP_LOCALE_EN
    LICENSE="$SP_PATH/locale/en-US/license-en.txt"
elif [[ $SP_LOCALE = "German" ]]; then
    echo "DE"
    SP_LOCALE_DE
    LICENSE="$SP_PATH/locale/de-DE/license-de.txt"
elif [[ $SP_LOCALE = "Spanish" ]]; then
    echo "ES"
    SP_LOCALE_ES
    LICENSE="$SP_PATH/locale/es-ES/license-es.txt"
elif [[ $SP_LOCALE = "French" ]]; then
    echo "FR"
    SP_LOCALE_FR
    LICENSE="$SP_PATH/locale/fr-FR/license-fr.txt"
elif [[ $SP_LOCALE = "Italian" ]]; then
    echo "IT"
    SP_LOCALE_IT
    LICENSE="$SP_PATH/locale/it-IT/license-it.txt"
elif [[ $SP_LOCALE = "Japanese" ]]; then
    echo "JP"
    SP_LOCALE_JP
    LICENSE="$SP_PATH/locale/ja-JP/license-ja.txt"
elif [[ $SP_LOCALE = "Korean" ]]; then
    echo "KO"
    SP_LOCALE_KO
    LICENSE="$SP_PATH/locale/ko-KR/license-ko.txt"
elif [[ $SP_LOCALE = "Chinese" ]]; then
    echo "ZH"
    SP_LOCALE_ZH
    LICENSE="$SP_PATH/locale/zh-CN/license-zh.txt"
else 
   echo "EN"
   SP_LOCALE_EN
   LICENSE="$SP_PATH/locale/en-US/license-en.txt"
fi
}

###############################################################################################################################################################

function SP_DRIVER_SETTINGS {
SP_DRIVER=`cat /tmp/settings.txt | awk 'NR == 2'`
}

###############################################################################################################################################################

function SP_LICENSE {
SP_LICENSE_TEXT=$(cat $LICENSE)
SP_LICENSE_CHECK=$(yad \
--title="" \
--form \
--borders=15 \
--width=550 \
--height=450 \
--buttons-layout=center \
--align=center \
--field=":TXT" "$SP_LICENSE_TEXT" \
--field="$SP_LICENSE_CHECK_LABEL:CHK" )

if [[ $SP_LICENSE_CHECK = *"TRUE"* ]]; then
    echo "TRUE"
    SP_INSTALLDIR
else
    echo "FALSE"
    SP_LICENSE
fi
}

###############################################################################################################################################################

function SP_INSTALLDIR {
WP_PATH=$(yad --title="" \
--form --separator="" \
--borders=15 \
--width=550 \
--buttons-layout=center \
--align=center \
--field="<big><b>$SP_INSTALLDIR_TITLE</b></big>:LBL" \
--field=":LBL" \
--field="<b>$SP_INSTALLDIR_LABEL_1</b>:LBL" \
--field="$SP_INSTALLDIR_LABEL_2:CB" \
--field="<b>$SP_INSTALLDIR_LABEL_3</b>:LBL" \
"" "" "" "$HOME/.wineprefixes/fusion360" "" )

# Continue with the installation ...
SP_WINE_SETTINGS
}

###############################################################################################################################################################

function SP_WINE_SETTINGS {
WINE_VERSION=$(yad --title="" \
--form --separator="" --item-separator="," \
--borders=15 \
--width=550 \
--buttons-layout=center \
--align=center \
--field="<big><b>$SP_WINE_SETTINGS_TITLE</b></big>:LBL" \
--field=":LBL" \
--field="<b>$SP_WINE_SETTINGS_LABEL_1</b>:LBL" \
--field="$SP_WINE_SETTINGS_LABEL_2:CB" \
--field="<b>$SP_WINE_SETTINGS_LABEL_3</b>:LBL" \
"" "" "" "$SP_WINE_VERSION_SELECT" "" )

if [[ $WINE_VERSION = "Wine Version (Staging)" ]]; then
    echo "Install Wine on your system!"
    SP_OS_SETTINGS
else
    echo "Wine version (6.23 or higher) is already installed on the system!"
    SP_FUSION360_INSTALL
fi
}

###############################################################################################################################################################

function SP_OS_SETTINGS {
SP_OS=$(yad --title="" \
--form --separator="" --item-separator="," \
--borders=15 \
--width=550 \
--buttons-layout=center \
--align=center \
--field="<big><b>$SP_OS_TITLE</b></big>:LBL" \
--field=":LBL" \
--field="$SP_OS_LABEL_1:LBL" \
--field="$SP_OS_LABEL_2:CB" \
"" "" "" "$SP_OS_SELECT" )

if [[ $SP_OS = "Arch Linux" ]]; then
    echo "Arch Linux"
    OS_ARCHLINUX
elif [[ $SP_OS = "Debian 10" ]]; then
    echo "Debian 10"
    DEBIAN_BASED_1
    OS_DEBIAN_10
    DEBIAN_BASED_1
elif [[ $SP_OS = "Debian 11" ]]; then
    echo "Debian 11"
    DEBIAN_BASED_1
    OS_DEBIAN_11
    DEBIAN_BASED_1
elif [[ $SP_OS = "EndeavourOS" ]]; then
    echo "EndeavourOS"
    OS_ARCHLINUX
elif [[ $SP_OS = "Fedora 34" ]]; then
    echo "Fedora 34"
    FEDORA_BASED_1
    OS_FEDORA_34
    FEDORA_BASED_2
elif [[ $SP_OS = "Fedora 35" ]]; then
    echo "Fedora 35"
    FEDORA_BASED_1
    OS_FEDORA_35
    FEDORA_BASED_1
elif [[ $SP_OS = "Fedora 36" ]]; then
    echo "Fedora 36"
    FEDORA_BASED_1
    OS_FEDORA_36
    FEDORA_BASED_1
elif [[ $SP_OS = "Linux Mint 19.x" ]]; then
    echo "Linux Mint 19.x"
    DEBIAN_BASED_1
    OS_UBUNTU_18
    DEBIAN_BASED_2
elif [[ $SP_OS = "Linux Mint 20.x" ]]; then
    echo "Linux Mint 20.x"
    DEBIAN_BASED_1
    OS_UBUNTU_20
    DEBIAN_BASED_1
elif [[ $SP_OS = "Manjaro Linux" ]]; then
    echo "Manjaro Linux"
    OS_ARCHLINUX
elif [[ $SP_OS = "openSUSE Leap 15.2" ]]; then
    echo "openSUSE Leap 15.2"
    OS_OPENSUSE_152
elif [[ $SP_OS = "openSUSE Leap 15.3" ]]; then
    echo "openSUSE Leap 15.3"
    OS_OPENSUSE_153
elif [[ $SP_OS = "openSUSE Leap 15.4" ]]; then
    echo "openSUSE Leap 15.4"
    OS_OPENSUSE_154
elif [[ $SP_OS = "openSUSE Tumbleweed" ]]; then
    echo "openSUSE Tumbleweed"
    OS_OPENSUSE_TW
elif [[ $SP_OS = "Red Hat Enterprise Linux 8.x" ]]; then
    echo "Red Hat Enterprise Linux 8.x"
    OS_REDHAT_LINUX_8
elif [[ $SP_OS = "Red Hat Enterprise Linux 9.x" ]]; then
    echo "Red Hat Enterprise Linux 9.x"
    OS_REDHAT_LINUX_9
elif [[ $SP_OS = "Solus" ]]; then
    echo "Solus"
    OS_SOLUS_LINUX
elif [[ $SP_OS = "Ubuntu 18.04" ]]; then
    echo "Ubuntu 18.04"
    DEBIAN_BASED_1
    OS_UBUNTU_18
    DEBIAN_BASED_2
elif [[ $SP_OS = "Ubuntu 20.04" ]]; then
    echo "Ubuntu 20.04"
    DEBIAN_BASED_1
    OS_UBUNTU_20
    DEBIAN_BASED_2
elif [[ $SP_OS = "Ubuntu 22.04" ]]; then
    echo "Ubuntu 22.04"
    DEBIAN_BASED_1
    OS_UBUNTU_22
    DEBIAN_BASED_2
elif [[ $SP_OS = "Void Linux" ]]; then
    echo "Void Linux"
    OS_VOID_LINUX
elif [[ $SP_OS = "Gentoo Linux" ]]; then
    echo "Gentoo Linux"
    OS_GENTOO_LINUX
fi
}

###############################################################################################################################################################

function SP_FUSION360_EXTENSIONS {
EXTENSIONS=$(yad --button=gtk-cancel:99 --button=gtk-ok:0 --height=300 --list --multiple --checklist --column=Select --column=Extension --column=Description < shopping.list)

if [[ $EXTENSIONS = *"Airfoil Tools"* ]]; then
    echo "Airfoil Tools"
    EXTENSION_AIRFOIL_TOOLS
fi

if [[ $EXTENSIONS = *"Additive Assistant (FFF)"* ]]; then
    echo "Additive Assistant (FFF)"
    EXTENSION_ADDITIVE_ASSISTANT
fi

if [[ $EXTENSIONS = *"Czech localization for F360"* ]]; then
    echo "Czech localization for F360"
    EXTENSION_CZECH_LOCALE
fi

if [[ $EXTENSIONS = *"HP 3D Printers for Autodesk® Fusion 360™"* ]]; then
    echo "HP 3D Printers for Autodesk® Fusion 360™"
    EXTENSION_HP_3DPRINTER_CONNECTOR
fi

if [[ $EXTENSIONS = *"Helical Gear Generator"* ]]; then
    echo "Helical Gear Generator"
    EXTENSION_HELICAL_GEAR_GENERATOR
fi

if [[ $EXTENSIONS = *"OctoPrint for Autodesk® Fusion 360™"* ]]; then
    echo "OctoPrint for Autodesk® Fusion 360™"
    EXTENSION_OCTOPRINT
fi

if [[ $EXTENSIONS = *"Parameter I/O"* ]]; then
    echo "Parameter I/O"
    EXTENSION_PARAMETER_IO
fi

if [[ $EXTENSIONS = *"RoboDK"* ]]; then
    echo "RoboDK"
    EXTENSION_ROBODK
fi

if [[ $EXTENSIONS = *"Ultimaker Digital Factory for Autodesk Fusion 360™"* ]]; then
    echo "Ultimaker Digital Factory for Autodesk Fusion 360™"
    EXTENSION_ULTIMAKER_DIGITAL_FACTORY
fi

###############################################################################################################################################################

# Still in Progress ...

###############################################################################################################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:                                                                                                                   #
###############################################################################################################################################################

SP_STRUCTURE
SP_LOCALE_INDEX
SP_LOCALE_EN
SP-WELCOME
