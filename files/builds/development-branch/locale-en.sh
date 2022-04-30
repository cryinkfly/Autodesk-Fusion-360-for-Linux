#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This is the English translation for the Setup Wizard.                              #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    17:30/21.02.2022                                                                   #
# Version:      1.5 -> 1.6                                                                         #
####################################################################################################

# Path: /$HOME/.fusion360/locale/en-EN/locale-en.sh

###############################################################################################################################################################
# ALL DEFINITIONS FOR INSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                          #
###############################################################################################################################################################

# Window Title:
SP_TITLE="Welcome to the Autodesk Fusion 360 Installer for Linux"

# Welcome Screen:
SP_WELCOME_LABEL_1="This setup wizard installs Autodesk Fusion 360 on your computer so that you can also work on your projects on Linux."
SP_WELCOME_LABEL_2="Click Ok to continue or Cancel to exit the setup wizard."
SP_WELCOME_TOOLTIP_1="Here you get more informations about this setup wizard."
SP_WELCOME_TOOLTIP_2="Here you can adjust the default setting. For example the language."

# Default-Path:
SP_PATH="$HOME/.fusion360"

# General Settings:
SP_SETTINGS_TITLE="General Settings"
SP_SETTINGS_LABEL_1="Here you have the option to adjust* further settings:"
SP_SETTINGS_LABEL_2="*Please remember that any change will affect the Autodesk Fusion 360 installation!"
SP_LOCALE_LABEL="Languages"
SP_LOCALE_SELECT=$(echo "Czech,English,German,Spanish,French,Italian,Japanese,Korean,Chinese")
SP_DRIVER_LABEL="Graphics Driver"
SP_DRIVER_SELECT=$(echo "DXVK,OpenGL")

# Reset the locale value:
SP_LOCALE="EN"

# Reset the graphics driver value:
SP_DRIVER="DXVK"

# Linux distribution - Configuration:
SP_OS_TITLE="Linux distribution - Configuration"
SP_OS_LABEL_1="In this step you can now select your Linux distribution to install the required packages for the installation."
SP_OS_LABEL_2="Linux distribution:"
SP_OS_SELECT=$(echo "Arch Linux,Debian 10,Debian 11,EndeavourOS,Fedora 34,Fedora 35,Fedora 36,Linux Mint 19.x,Linux Mint 20.x,Manjaro Linux,openSUSE Leap 15.2,openSUSE Leap 15.3,openSUSE Leap 15.4,openSUSE Tumbleweed,Red Hat Enterprise Linux 8.x,Red Hat Enterprise Linux 9.x,Solus,Ubuntu 18.04,Ubuntu 20.04,Ubuntu 22.04,Void Linux,Gentoo Linux")


# Installation Folder - Configuration:
SP_INSTALLDIR_TITLE="Select Installation Folder"
SP_INSTALLDIR_LABEL_1="The Setup Wizard will install Autodesk Fusion 360 to the following folder*."
SP_INSTALLDIR_LABEL_2="Folder:"
SP_INSTALLDIR_LABEL_3="*You can also choose a different folder for the installation by clicking in the field."
