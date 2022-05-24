#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This is the English translation for the Setup Wizard.                              #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    07:30/24.05.2022                                                                   #
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

###############################################################################################################################################################

# General Settings:
SP_SETTINGS_TITLE="General Settings"
SP_SETTINGS_LABEL_1="Here you have the option to adjust* further settings:"
SP_SETTINGS_LABEL_2="*Please remember that any change will affect the Autodesk Fusion 360 installation!"
SP_LOCALE_LABEL="Languages"
SP_LOCALE_SELECT=$(echo "Czech,English,German,Spanish,French,Italian,Japanese,Korean,Chinese")
SP_DRIVER_LABEL="Graphics Driver"
SP_DRIVER_SELECT=$(echo "DXVK,OpenGL")

# Locale value:
SP_LOCALE="EN"

# License Checkbox:
SP_LICENSE_CHECK_LABEL="I have read the terms and conditions and I accept them."

###############################################################################################################################################################

# Wineprefix Info - Autodesk Fusion 360 exist on the computer:
SP_LOGFILE_WINEPREFIX_INFO_TITLE="Welcome to the Autodesk Fusion 360 Installer for Linux"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_1="A previous installation of Autodesk Fusion 360 has been detected on your system!"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_2="Therefore, please select one of the options below to continue!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_1="Create a new Wineprefix in a different location!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_2="Repair the current Wineprefix on your system!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_3="Remove the current Wineprefix from your system!"

###############################################################################################################################################################

# Linux distribution - Configuration:
SP_OS_TITLE="Linux distribution - Configuration"
SP_OS_LABEL_1="In this step you can now select your Linux distribution to install the required packages for the installation."
SP_OS_LABEL_2="Linux distribution:"
SP_OS_SELECT=$(echo "Arch Linux,Debian 10,Debian 11,EndeavourOS,Fedora 34,Fedora 35,Fedora 36,Linux Mint 19.x,Linux Mint 20.x,Manjaro Linux,openSUSE Leap 15.2,openSUSE Leap 15.3,openSUSE Leap 15.4,openSUSE Tumbleweed,Red Hat Enterprise Linux 8.x,Red Hat Enterprise Linux 9.x,Solus,Ubuntu 18.04,Ubuntu 20.04,Ubuntu 22.04,Void Linux,Gentoo Linux")

###############################################################################################################################################################

# Installation Folder - Configuration:
SP_INSTALLDIR_TITLE="Select Installation Folder"
SP_INSTALLDIR_LABEL_1="The Setup Wizard will install Autodesk Fusion 360 to the following folder*."
SP_INSTALLDIR_LABEL_2="Folder:"
SP_INSTALLDIR_LABEL_3="*You can also choose a different folder for the installation by clicking in the field."

###############################################################################################################################################################

# Directory info:
SP_INSTALLDIR_INFO_TITLE="Select Installation Folder -Info"
SP_INSTALLDIR_INFO_LABEL_1="Danger! This directory already exists!"
SP_INSTALLDIR_INFO_LABEL_2="Please select a different directory."

###############################################################################################################################################################

# Wine Version
SP_WINE_SETTINGS_TITLE="Select Wine Version"
SP_WINE_SETTINGS_LABEL_1="Here you have to decide between two options*."
SP_WINE_SETTINGS_LABEL_2="Select:"
SP_WINE_SELECT=$(echo "Wine Version (Staging),Wine version (6.23 or higher) is already installed on the system!")
SP_WINE_SETTINGS_LABEL_3="*Depending on which option is selected, further packages will be installed on your system!"

###############################################################################################################################################################

# Extension - Configuration:
SP_EXTENSION_SELECT="Select"
SP_EXTENSION_NAME="Extension"
SP_EXTENSION_DESCRIPTION="Description"

SP_EXTENSION_DESCRIPTION_1="This extension helps you by the optimization any thing or part that is exposed to a moving gas or liquid. For example: wings, fins, propellers and turbines."
SP_EXTENSION_DESCRIPTION_2="This extension helps you by analyses a number of aspects of your designs and provides clear feedback on how to improve the manufacturability of the part."
SP_EXTENSION_DESCRIPTION_3="This extension gives you the option to use the Czech user interface (UI) in Autodesk Fusion 360."
SP_EXTENSION_DESCRIPTION_4="This extension is a connector between Autodesk® Fusion 360™ and the HP SmartStream Software and is used to send over jobs directly to the HP Software."
SP_EXTENSION_DESCRIPTION_5="Helical gears resemble spur gears with the teeth at an angle."
SP_EXTENSION_DESCRIPTION_6="With this extension you can send the G-code of your created 3D models directly to the OctoPrint server via Autodesk Fusion 360."
SP_EXTENSION_DESCRIPTION_7="Enables the user to Import/Update parameters from or export them to a CSV (Comma Separated Values) file."
SP_EXTENSION_DESCRIPTION_8="This extension allows you to program more than 50 different robot manufacturers and 500 robots directly from Autodesk Fusion 360."
SP_EXTENSION_DESCRIPTION_9="This plug-in is a connector between Autodesk® Fusion 360™ and the Ultimaker Digital Factory site and its services."

###############################################################################################################################################################
# ALL DEFINITIONS FOR UNINSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

DL_TITLE="Welcome to the Autodesk Fusion 360 Uninstaller for Linux"
DL_WELCOME_LABEL_1="Autodesk Fusion 360 will be uninstalled from your computer!"
DL_WELCOME_LABEL_2="Click Ok to continue or Cancel to exit this Uninstaller."
DL_WELCOME_TOOLTIP_1="Here you get more informations about this Uninstaller."

DL_SELECT="Select"

DL_WINEPREFIXES_DEL_INFO_TEXT="Are you sure you want to delete the selected Wineprefix from your computer?"
DL_WINEPREFIXES_DEL_INFO_LABEL="Yes, I am aware that all my personal data will be lost in the Wineprefix."
