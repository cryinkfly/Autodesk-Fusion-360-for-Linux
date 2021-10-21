#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you get all extensions for the Setup Wizard.                        #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2021                                                                          #
# Time/Date:    17:00/21.10.2021                                                                   #
# Version:      1.1                                                                                #
####################################################################################################

###############################################################################################################################################################
# ALL FUNCTIONS & DIALOGS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# Load & Save the locale files into the folders!

function load-extensions-files {
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/AirfoilTools_win64.msi
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/blob/main/files/extensions/AdditiveAssistant_win64.msi
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/blob/main/files/extensions/HP3DPrintersForFusion360_win64.msi
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/blob/main/files/extensions/OctoPrintForFusion360_win64.msi
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/blob/main/files/extensions/RoboDK_win64.msi
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/resources/extensions/extensions-standard.sh
  chmod +x data/resources/extensions/extensions-standard.sh
  wget -N -P data/resources/extensions https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/resources/extensions/extensions-custom.sh
  chmod +x data/resources/extensions/extensions-custom.sh
}

##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

load-extensions-files
