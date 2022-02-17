#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Cronjob for Update (Linux)                                   #
# Description:  This file checks whether there is a newer version of Autodesk Fusion 360.          #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    09:30/17.02.2022                                                                   #
# Version:      0.0.3                                                                              #
####################################################################################################

# Path: /$HOME/.config/fusion-360/bin/update.sh

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                        #
###############################################################################################################################################################

# I will change this value as soon as a new version of Autodesk Fusion 360 is available. 
# A value of 0 means that there is no update and a value of 1 will notify the user that there is an update.
get_update=0

function setupact-check {
  if [ $get_update -eq 1 ]; then
    setupact-get-update
  else    
    # echo "Do nothing!"
  fi
}

# Checks the current day of the week so that the update can be performed.
# %u day of week (1..7); 1 is Monday.

# The update runs on Monday, Wednesday and Friday.
function setupact-get-update  {
  pc_date=$(date +%u)
  if [ $pc_date -eq 1 ]; then
    # echo "Monday"
    setupact-get-f360exe
    setupact-update
  elif [ $pc_date -eq 3 ]; then
    # echo "Wednesday"
    setupact-get-f360exe
    setupact-update
  elif [ $pc_date -eq 5 ]; then
    # echo "Friday"
    setupact-get-f360exe
    setupact-update
  else    
    # echo "Do nothing!"
  fi
}

function setupact-get-f360exe {
  wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360installer.exe
}

function setupact-update {
  WINEPREFIX="$HOME/.wineprefixes/fusion360" wine Fusion360installer.exe -p deploy -g -f log.txt --quiet
  WINEPREFIX="$HOME/.wineprefixes/fusion360" wine Fusion360installer.exe -p deploy -g -f log.txt --quiet
}

###############################################################################################################################################################
# ALL DIALOGS ARE ARRANGED HERE:                                                                                                                              #
###############################################################################################################################################################

# Still in Progress!

###############################################################################################################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:                                                                                                                   #
###############################################################################################################################################################

setupact-check
