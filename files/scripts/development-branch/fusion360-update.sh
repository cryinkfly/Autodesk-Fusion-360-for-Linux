#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Cronjob for Update (Linux)                                   #
# Description:  This file checks whether there is a newer version of Autodesk Fusion 360.          #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    17:45/15.02.2022                                                                   #
# Version:      0.0.1                                                                              #
####################################################################################################

###############################################################################################################################################################
# ALL LOG-FUNCTIONS ARE ARRANGED HERE:                                                                                                                        #
###############################################################################################################################################################

# Check if already exists a Autodesk Fusion 360 installation on your system.
function setupact-check-f360 {
f360_path="$HOME/.config/fusion360/logs/wineprefixes-path.log"
if [ -f "$f360_path" ]; then
    mkdir -p tmp/logs # Create a tempory folder.
    cp "$HOME/.config/fusion360/logs/wineprefixes-path.log" tmp/logs # Copy this file to another place for the next process.
    mv tmp/logs/wineprefixes-path.log tmp/logs/wineprefixes-path  # Rename this file for the next process.
    setupact-update-f360 # Update a exists Wineprefix of Autodesk Fusion 360.
else    
    setupact-check-f360-error
fi
}

# Remove Temp folder!
function setupact-del-tmp {
rm -f tmp
}


# Still  in  Progress!
