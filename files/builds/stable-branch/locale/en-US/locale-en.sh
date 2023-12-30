#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This is the English translation for the Setup Wizard.                              #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    19:00/26.07.2023                                                                   #
# Version:      1.6.2                                                                              #
####################################################################################################

# Path: /$HOME/.fusion360/locale/en-EN/locale-en.sh

###############################################################################################################################################################
# ALL DEFINITIONS FOR AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                                  #
###############################################################################################################################################################

# Window Title (Setup Wizard)
SP_TITLE="Setup Wizard - Autodesk Fusion 360 for Linux"

# Window Title:
SP_SUBTITLE="Welcome to the Autodesk Fusion 360 Installer for Linux"

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
WP_DRIVER_LABEL="Graphics Driver"
WP_DRIVER_SELECT=$(echo "DXVK,OpenGL")

# License Checkbox:
SP_LICENSE_CHECK_LABEL="I have read the terms and conditions and I accept them."
SP_LICENSE="$SP_PATH/locale/en-US/license-en.txt"

###############################################################################################################################################################

# Wineprefix Info - Autodesk Fusion 360 exist on the computer:
SP_LOGFILE_WINEPREFIX_INFO_TITLE="$SP_SUBTITLE"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_1="A previous installation of Autodesk Fusion 360 has been detected on your system!"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_2="Therefore, please select one of the options below to continue!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_1="Create a new Wineprefix in a different location!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_2="Repair a current Wineprefix on your system!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_3="Remove a current Wineprefix from your system!"

###############################################################################################################################################################

# Linux distribution - Configuration:
SP_OS_TITLE="Linux distribution - Configuration"
SP_OS_LABEL_1="In this step you can now select your Linux distribution to install the required packages for the installation."
SP_OS_LABEL_2="Linux distribution:"
SP_OS_SELECT=$(echo "Arch Linux,Debian 11,Debian 12, Debian Testing,EndeavourOS,Fedora 37,Fedora 38,Fedora Rawhide,Linux Mint 20.x,Linux Mint 21.x,Linux Mint 5.x - LMDE Version,Manjaro Linux,openSUSE Leap 15.4,openSUSE Leap 15.5,openSUSE Tumbleweed,Red Hat Enterprise Linux 8.x,Red Hat Enterprise Linux 9.x,Solus,Ubuntu 20.04,Ubuntu 22.04,Ubuntu 23.04,Void Linux,Gentoo Linux")

###############################################################################################################################################################

# Installation Folder - Configuration:
SP_INSTALLDIR_TITLE="Select the destination of the installation"
SP_INSTALLDIR_LABEL_1="The Setup Wizard will install Autodesk Fusion 360 to the following directory*."
SP_INSTALLDIR_LABEL_2="Directory:"
SP_INSTALLDIR_LABEL_3="*You can also choose a different directory for the installation by clicking in the field."

###############################################################################################################################################################

# Directory info:
SP_INSTALLDIR_INFO_TITLE="Select Installation Directory - Info"
SP_INSTALLDIR_INFO_LABEL_1="Danger! This directory already exists!"
SP_INSTALLDIR_INFO_LABEL_2="Please select a different directory."

###############################################################################################################################################################

# Wine Version
SP_WINE_SETTINGS_TITLE="Select Wine Version"
SP_WINE_SETTINGS_LABEL_1="Here you have to decide between two options*."
SP_WINE_SETTINGS_LABEL_2="Select:"
SP_WINE_VERSION_SELECT=$(echo "Wine Version (Staging),Wine version (6.23 or higher) is already installed on the system!")
SP_WINE_SETTINGS_LABEL_3="*Depending on which option is selected, further packages will be installed on your system!"

###############################################################################################################################################################

SP_INSTALL_PROGRESS_LABEL="Autodesk Fusion 360 will be installed on your system ..."
SP_INSTALL_PROGRESS_REFRESH_LABEL="Autodesk Fusion 360 is being updated on this system ..."

###############################################################################################################################################################

# Extension - Configuration:
SP_EXTENSION_SELECT="Select"
SP_EXTENSION_NAME="Extension"
SP_EXTENSION_DESCRIPTION="Description"

SP_EXTENSION_LIST="$SP_PATH/locale/en-US/extensions-en.txt"

SP_SEARCH_EXTENSION_CZECH_LOCALE_TITLE="Install the Czech-Locale-Extension"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_1="Select the file* in which the extension is located!"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_2="File:"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_3="*By default you will find your downloaded extensions in the download directory."

###############################################################################################################################################################
# ALL DEFINITIONS FOR UNINSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

DL_TITLE="Uninstaller - Autodesk Fusion 360 for Linux"
DL_SUBTITLE="Welcome to the Autodesk Fusion 360 Uninstaller for Linux"
DL_WELCOME_LABEL_1="Autodesk Fusion 360 will be uninstalled from your computer!"
DL_WELCOME_LABEL_2="Click Ok to continue or Cancel to exit this Uninstaller."
DL_WELCOME_TOOLTIP_1="Here you get more informations about this Uninstaller."

DL_WINEPREFIXES_DEL_INFO_TEXT="Are you sure you want to delete the selected Wineprefix from your computer?"
DL_WINEPREFIXES_DEL_INFO_LABEL="Yes, I am aware that all my personal data will be lost in the Wineprefix."

###############################################################################################################################################################

SP_COMPLETED_TEXT="Autodesk Fusion 360 was successfully installed and setup on your computer."
SP_COMPLETED_CHECK_LABEL="Run Autodesk Fusion 360"

###############################################################################################################################################################
# ALL DEFINITIONS FOR THE LAUNCHER OF AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                  #
###############################################################################################################################################################

UP_TITLE="Autodesk Fusion 360 for Linux - Launcher"
UP_NO_UPDATE_INFO_LABEL="No newer version was found, so your Autodesk fusion 360 is up to date!"
UP_SKIP_INFO_LABEL="The update was skipped! Please consider checking for updates next time."
UP_SKIP_UPDATE_QUESTION_LABEL="Are you sure you want to skip searching for an Autodesk Fusion 360 update?"

UP_QUESTION_LABEL="A new version has been released! Do you want to update now?"

UP_NO_CONNECTION_WARNING_LABEL="The connection to the server could not be established! Checking for new updates has been skipped! Please check your internet connection!"

# Added - New question dialog
UP_WANT_TO_CHECK_FOR_UPDATES="Would you like to check for updates to Fusion360 before launching?"

# REMOVED - UP_PROGRESS_LABEL_1="Connecting to the server ..."
# REMOVED - UP_PROGRESS_LABEL_2="# Check all files .."
# REMOVED - UP_PROGRESS_LABEL_3="# All files are checked!"
UP_INSTALL_UPDATE_PROGRESS_LABEL="Autodesk Fusion 360 will be updated to a newer version ..."

###############################################################################################################################################################
###############################################################################################################################################################

SELECT="Select"
WINEPREFIXES_TYPE="Wineprefixes Type"
WINEPREFIXES_DRIVER="Wineprefixes Driver"
WINEPREFIXES_DIRECTORY="Wineprefixes Directory"
