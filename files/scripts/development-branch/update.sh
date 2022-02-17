#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Cronjob for Update (Linux)                                   #
# Description:  This file checks whether there is a newer version of Autodesk Fusion 360.          #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    11:15/17.02.2022                                                                   #
# Version:      0.0.4                                                                              #
####################################################################################################

# Path: /$HOME/.config/fusion-360/bin/update.sh

###############################################################################################################################################################

# Window Title (Launcher)
program_name="Autodesk Fusion 360 for Linux - Launcher"

# I will change this value as soon as a new version of Autodesk Fusion 360 is available. 
# A value of 0 means that there is no update and a value of 1 will notify the user that there is an update.
get_update=0

# Domain Name
domain="www.github.com"

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# Check the connection to the server of GitHub.
function setupact-check-connection {
  ping -c 5 $domain 2>/dev/null 1>/dev/null
  if [ "$?" = 0 ]; then
    echo "Host found"
  else
    echo "Host not found"
    setupact-no-connection-warning
    # Skip the update proecess ... (Still in Progress!)
fi
}

# Checks if there is an update for Autodesk Fusion 360.
function setupact-check-update {
  if [ $get_update -eq 1 ]; then
    setupact-get-update
  else    
    echo "Do nothing!"
    setupact-no-update-info
  fi
}

# Checks the current day of the week so that the update can be performed.
# %u day of week (1..7); 1 is Monday.

# The update runs on Monday, Wednesday and Friday.
function setupact-get-update  {
  pc_date=$(date +%u)
  if [ $pc_date -eq 1 ]; then
     echo "Monday"
    setupact-update-question
  elif [ $pc_date -eq 3 ]; then
     echo "Wednesday"
    setupact-update-question
  elif [ $pc_date -eq 5 ]; then
     echo "Friday"
    setupact-update-question
  else    
    setupact-no-update-info
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

# The user get a informationt that no newer version of Autodesk Fusion 360 was found!
function setupact-no-update-info {
  zenity --info \
  --text="No newer version was found, so your Autodesk fusion 360 is up to date!" \
  --width=400 \
  --height=100
}

###############################################################################################################################################################

# The user get a informationt that there is no connection to the server!
function setupact-no-connection-warning {
  zenity --warning \
  --text="The connection to the server could not be established! The search for new updates has been skipped! Please check your internet connection!" \
  --width=400 \
  --height=100
}

###############################################################################################################################################################

# The user will be asked if he wants to update or not.
function setupact-update-question {
  zenity --question \
  --title="$program_name" \
  --text="A new version has been released! Would you like to update now?" \
  --width=400 \
  --height=100
  answer=$?

  if [ "$answer" -eq 0 ]; then
     echo "Do nothing!"
  elif [ "$answer" -eq 1 ]; then
    setupact-get-f360exe
    setupact-update
  fi
}

###############################################################################################################################################################

# A progress bar is displayed here.
function setupact-progressbar {
  (
echo "5" ; sleep 1
echo "# Connecting to the server ..." ; sleep 5
setupact-check-connection
echo "25" ; sleep 1
echo "# Check for updates ..." ; sleep 3
setupact-check-update
echo "75" ; sleep 1
) |
zenity --progress \
  --title="$program_name" \
  --text="Checking if there is a new version of Autodesk fusion 360 available ..." \
  --width=400 \
  --height=100 \
  --percentage=0

if [ "$?" = 0 ] ; then
        setupact-update-solved
elif [ "$?" = 1 ] ; then
        zenity --question \
                 --title="$program_name" \
                 --text="Are you sure you want to skip checking for an Autodesk Fusion 360 update?" \
                 --width=400 \
                 --height=100
        answer=$?

        if [ "$answer" -eq 0 ]; then
              echo "Do nothing!"
        elif [ "$answer" -eq 1 ]; then
              setupact-progressbar
        fi
elif [ "$?" = -1 ] ; then
        zenity --error \
          --text="An unexpected error occurred!"
        exit;
fi
}

###############################################################################################################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:                                                                                                                   #
###############################################################################################################################################################

setupact-progressbar
