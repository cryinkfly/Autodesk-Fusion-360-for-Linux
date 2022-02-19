#!/bin/bash

################################################################################
# Name:         Autodesk Fusion 360 - Uninstall the software (Linux)           #
# Description:  With this file you delete Autodesk Fusion 360 on your system.  #
# Author:       Steve Zabka                                                    #
# Author URI:   https://cryinkfly.com                                          #
# License:      MIT                                                            #
# Copyright (c) 2020-2022                                                      #
# Time/Date:    08:30/19.02.2022                                               #
# Version:      0.2                                                            #
################################################################################

# Path: /$HOME/.config/fusion-360/bin/uninstall.sh

###############################################################################################################################################################

# Window Title (Launcher)
program_name="Autodesk Fusion 360 for Linux - Uninstall"

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# Remove a exist Wineprefix of Autodesk Fusion 360!
function setupact-uninstall {
  setupact-select-wineprefix-info
  setupact-select-wineprefix
  rm -r "$wineprefix_directory"
  setupact-uninstall-completed
}

###############################################################################################################################################################

function setupact-get-wineprefixes-log {
  mkdir -p "/tmp/fusion-360/logs"
  cp "$HOME/.config/fusion-360/logs/wineprefixes.log" "/tmp/fusion-360/logs"
  mv "/tmp/fusion-360/logs/wineprefixes.log" "/tmp/fusion-360/logs/wineprefixes"
}

###############################################################################################################################################################
# ALL DIALOGS ARE ARRANGED HERE:                                                                                                                              #
###############################################################################################################################################################

# The user will be asked if he wants to uninstall or not.
function setupact-update-question {
  zenity --question \
         --title="$program_name" \
         --text="Do you really want to uninstall Autodesk Fusion 360 from your system?" \
         --width=400 \
         --height=100
 
 answer=$?

  if [ "$answer" -eq 0 ]; then       
    setupact-uninstall-dialog
  elif [ "$answer" -eq 1 ]; then
    setupact-cancel-info
  fi
}

###############################################################################################################################################################

# The user will be informed that he is skipping the update!
function setupact-cancel-info {
  zenity --info \
         --text="The uninstallation was aborted!" \
         --width=400 \
         --height=100
}

###############################################################################################################################################################

# Deinstall a exist Wineprefix of Autodesk Fusion 360!
function setupact-uninstall-dialog {
  
  file=/tmp/fusion-360/logs/wineprefixes
  
  directory=`zenity --text-info \
                    --title="$program_name" \
                    --width=700 \
                    --height=500 \
                    --filename=$file \
                    --editable \
                    --checkbox="$text_deinstall_checkbox"`

  case $? in
      0)
          zenity --question \
                 --title="$program_name" \
                 --text="$Do you want to save your changes and deleting the correct existing Autodesk Fusion 360 installation?" \
                 --width=400 \
                 --height=100
          answer=$?

          if [ "$answer" -eq 0 ]; then
              echo "$directory" > $file
	      mv "$file" "/tmp/fusion-360/logs/wineprefixes.log"
	      cp "/tmp/fusion-360/logs/wineprefixes.log" "$HOME/.config/fusion-360/logs/wineprefixes.log"
              setupact-uninstall
          elif [ "$answer" -eq 1 ]; then
              setupact-uninstall-dialog
          fi
  	      ;;
      1)
              echo "Go back"
              setupact-update-question
  	      ;;
      -1)
              zenity --error \
                     --text="An unexpected error occurred!"
              exit;
  	      ;;
  esac

}

###############################################################################################################################################################

# Select the Wineprefix-directory of your Autodesk Fusion 360 installation!
function setupact-select-wineprefix-info {
  zenity --info \
         --text="Select the Wineprefix-directory of your Autodesk Fusion 360 installation, which you want to uninstall! For example: /home/user/.wineprefixes/fusion360" \
         --width=400 \
         --height=100
}

function setupact-select-wineprefix {
  wineprefix_directory=`zenity --file-selection --directory --title="Select the Wineprefix-directory ..."`
}

###############################################################################################################################################################

# The uninstallation is complete and will be terminated.
function setupact-uninstall-completed {
  zenity --info \
         --width=400 \
         --height=100 \
         --text="$text_completed_deinstallation"

  exit;
}

###############################################################################################################################################################
# THE PROGRAM IS STARTED HERE:                                                                                                                                #
###############################################################################################################################################################

setupact-update-question

