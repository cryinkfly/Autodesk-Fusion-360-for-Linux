#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you get all extensions for the Setup Wizard.                        #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2021                                                                          #
# Time/Date:    10:00/20.10.2021                                                                   #
# Version:      1.0                                                                                #
####################################################################################################

###############################################################################################################################################################
# ALL FUNCTIONS & DIALOGS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# Load & Save the locale files into the folders!

function load-extensions-files {
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/AirfoilTools_win64.msi
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/blob/main/files/extensions/AdditiveAssistant.bundle-win64.msi
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/blob/main/files/extensions/HP_3DPrinters_for_Fusion360-win64.msi
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/blob/main/files/extensions/OctoPrint_for_Fusion360-win64.msi
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/blob/main/files/extensions/RoboDK.bundle-win64.msi
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/resources/extensions/extensions-standard.sh
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/resources/extensions/extensions-custom.sh
}

##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

load-extensions-files
