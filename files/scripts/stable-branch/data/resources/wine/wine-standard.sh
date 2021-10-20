#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you install Autodesk Fusion 360 with Wine and Winetricks.           #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2021                                                                          #
# Time/Date:    10:00/20.10.2021                                                                   #
# Version:      1.0                                                                                #
####################################################################################################

###############################################################################################################################################################
# DESCRIPTION IN DETAIL                                                                                                                                       #
###############################################################################################################################################################
# Autodesk Fusion 360 will now be installed using Wine and Winetricks!                                                                                        #
###############################################################################################################################################################

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

function install-winetricks-standard {
   mkdir -p $HOME/.wineprefixes/fusion360
   WINEPREFIX=$HOME/.wineprefixes/fusion360 sh data/resources/wine/winetricks -q corefonts cjkfonts msxml4 msxml6 vcrun2017 fontsmooth=rgb win8
   # We must install cjkfonts again then sometimes it doesn't work the first time!
   WINEPREFIX=$HOME/.wineprefixes/fusion360 sh data/resources/wine/winetricks -q cjkfonts
   configure-dxvk-or-opengl-standard-1
   WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/fusion360-installer/Fusion360installer.exe -p deploy -g -f log.txt --quiet
   WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/fusion360-installer/Fusion360installer.exe -p deploy -g -f log.txt --quiet
   mkdir -p "$HOME/.wineprefixes/fusion360/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options"
   configure-dxvk-or-opengl-standard-2
   # Because the location varies depending on the Linux distro!
   mkdir -p "$HOME/.wineprefixes/fusion360/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options"
   configure-dxvk-or-opengl-standard-3
   #Set up the program launcher for you!
   wget -P $HOME/.local/share/applications/wine/Programs/Autodesk https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/Autodesk%20Fusion%20360.desktop
   logfile-installation-standard
   . data/resources/extensions/extensions-standard.sh
   program-exit
}

##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

install-winetricks-standard
