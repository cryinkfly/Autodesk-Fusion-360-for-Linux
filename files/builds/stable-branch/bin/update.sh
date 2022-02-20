#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Cronjob for Update (Linux)                                   #
# Description:  This file checks whether there is a newer version of Autodesk Fusion 360.          #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    12:30/20.02.2022                                                                   #
# Version:      0.0.6                                                                              #
####################################################################################################

# Path: /$HOME/.config/fusion-360/bin/update.sh

###############################################################################################################################################################

# Window Title (Launcher)
program_name="Autodesk Fusion 360 for Linux - Launcher"

# I will change this value as soon as a new version of Autodesk Fusion 360 is available. 
# A value of 0 means that there is no update and a value of 1 will notify the user that there is an update.
get_update=0

# Domain Name:
domain="www.github.com"

# Reset connection-value!
connection=0

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# Check the connection to the server of GitHub.
function setupact-check-connection {
  ping -c 5 $domain 2>/dev/null 1>/dev/null
  if [ "$?" = 0 ]; then
    connection=1
    echo "Connection to the domain worked!"
  else
    echo "No connection to the domain!"
fi
}

###############################################################################################################################################################

# Checks if there is an update for Autodesk Fusion 360.
function setupact-check-info {
  if [ $connection -eq 1 ] && [ $get_update -eq 1 ]; then
    setupact-update-question
  elif [ $connection -eq 1 ] && [ $get_update -eq 0 ]; then
    setupact-no-update-info 
  else    
    setupact-no-connection-error
  fi
}

###############################################################################################################################################################

function setupact-get-update {
  wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360installer.exe
  mv "Fusion360installer.exe" "$HOME/.config/fusion-360/downloads/Fusion360installer.exe"
}

###############################################################################################################################################################

function setupact-install-update {
  WINEPREFIX="$HOME/.wineprefixes/fusion360" wine $HOME/.config/fusion-360/downloads/Fusion360installer.exe -p deploy -g -f log.txt --quiet
  WINEPREFIX="$HOME/.wineprefixes/fusion360" wine $HOME/.config/fusion-360/downloads/Fusion360installer.exe -p deploy -g -f log.txt --quiet
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

# The user will be informed that he is skipping the update!
function setupact-skip-info {
  zenity --warning \
  --text="The update was skipped! Please update your Autodesk Fusion 360 version soon!" \
  --width=400 \
  --height=100
}

###############################################################################################################################################################

# The user get a informationt that there is no connection to the server!
function setupact-no-connection-warning {
  zenity --error \
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
    setupact-get-update
    setupact-install-update
  elif [ "$answer" -eq 1 ]; then
    setupact-skip-info
  fi
}

###############################################################################################################################################################

# A progress bar is displayed here.
function setupact-progressbar {
  (
echo "30" ; sleep 2
echo "# Connecting to the server ..." ; sleep 3
setupact-check-connection
echo "50" ; sleep 1
echo "# Check all files ..." ; sleep 1
echo "100" ; sleep 3
) |
zenity --progress \
  --title="$program_name" \
  --text="Search for new updates ..." \
  --width=400 \
  --height=100 \
  --percentage=0

if [ "$?" = 0 ] ; then
        setupact-check-info
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
# THE PROGRAM IS STARTED HERE:                                                                                                                                #
###############################################################################################################################################################

setupact-progressbar
