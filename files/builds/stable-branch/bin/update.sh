#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Cronjob for Update (Linux)                                   #
# Description:  This file checks whether there is a newer version of Autodesk Fusion 360.          #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    17:00/21.02.2022                                                                   #
# Version:      1.0.0                                                                              #
####################################################################################################

# Path: /$HOME/.config/fusion-360/bin/update.sh

###############################################################################################################################################################

# Window Title (Launcher)
program_name="Autodesk Fusion 360 for Linux - Launcher"

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# Load the locale files ...

function load-locale-cs {
  . $HOME/.config/fusion-360/locale/cs-CZ/locale-cs.sh
}

function load-locale-de {
  . $HOME/.config/fusion-360/locale/de-DE/locale-de.sh
}

function load-locale-en {
  . $HOME/.config/fusion-360/locale/en-US/locale-en.sh
}

function load-locale-es {
  . $HOME/.config/fusion-360/locale/es-ES/locale-es.sh
}

function load-locale-fr {
  . $HOME/.config/fusion-360/locale/fr-FR/locale-fr.sh
}

function load-locale-it {
  . $HOME/.config/fusion-360/locale/it-IT/locale-it.sh
}

function load-locale-ja {
  . $HOME/.config/fusion-360/locale/ja-JP/locale-ja.sh
}

function load-locale-ko {
  . $HOME/.config/fusion-360/locale/ko-KR/locale-ko.sh
}

function load-locale-zh {
  . $HOME/.config/fusion-360/locale/zh-CN/locale-zh.sh
}

function setupact-config-locale {
  config_locale=`. $HOME/.config/fusion-360/bin/read-text.sh $HOME/.config/fusion-360/logs/profile-locale.log 1`
  if [ "$config_locale" = "cs-CZ" ]; then
    load-locale-cs
  elif [ "$config_locale" = "de-DE" ]; then
    load-locale-de
  elif [ "$config_locale" = "en-US" ]; then
    load-locale-en
  elif [ "$config_locale" = "es-ES" ]; then
    load-locale-es
  elif [ "$config_locale" = "fr-FR" ]; then
    load-locale-fr
  elif [ "$config_locale" = "it-IT" ]; then
    load-locale-it
  elif [ "$config_locale" = "ja-JP" ]; then
    load-locale-ja
  elif [ "$config_locale" = "ko-KR" ]; then
    load-locale-ko
  elif [ "$config_locale" = "zh-CN" ]; then
    load-locale-zh
  else
    load-locale-en
  fi  
}

###############################################################################################################################################################

# Checks if there is an update for Autodesk Fusion 360.
function setupact-check-info {
  if [ $get_update -eq 1 ]; then
    setupact-update-question
  elif [ $get_update -eq 0 ]; then
    setupact-no-update-info 
  else    
    setupact-no-connection-warning
  fi
}

###############################################################################################################################################################

function setupact-get-update {
  wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360installer.exe
  mv "Fusion360installer.exe" "$HOME/.config/fusion-360/downloads/Fusion360installer.exe"
  cp "$HOME/.config/fusion-360/downloads/Fusion360installer.exe" "$HOME/.wineprefixes/fusion360/drive_c/users/$USER/Downloads/Fusion360installer.exe"
}

###############################################################################################################################################################

# You must change the first part ($HOME/.wineprefixes/fusion360) and the last part (WINEPREFIX="$HOME/.wineprefixes/fusion360") when you have installed Autodesk Fusion 360 into another directory!
function setupact-install-update {
  WINEPREFIX="$HOME/.wineprefixes/fusion360" wine $HOME/.wineprefixes/fusion360/drive_c/users/$USER/Downloads/Fusion360installer.exe -p deploy -g -f log.txt --quiet
  WINEPREFIX="$HOME/.wineprefixes/fusion360" wine $HOME/.wineprefixes/fusion360/drive_c/users/$USER/Downloads/Fusion360installer.exe -p deploy -g -f log.txt --quiet
}

###############################################################################################################################################################
# ALL DIALOGS ARE ARRANGED HERE:                                                                                                                              #
###############################################################################################################################################################

# The user get a informationt that no newer version of Autodesk Fusion 360 was found!
function setupact-no-update-info {
  zenity --info \
         --text="$text_no_update_info" \
         --width=400 \
         --height=100
}

###############################################################################################################################################################

# The user will be informed that he is skipping the update!
function setupact-skip-info {
  zenity --warning \
         --text="$text_skip_update_info" \
         --width=400 \
         --height=100
}

###############################################################################################################################################################

# The user get a informationt that there is no connection to the server!
function setupact-no-connection-warning {
  zenity --error \
         --text="$text_no_connection_warning" \
         --width=400 \
         --height=100
}

###############################################################################################################################################################

# The user will be asked if he wants to update or not.
function setupact-update-question {
  zenity --question \
         --title="$program_name" \
         --text="$text_update_question" \
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
    echo "50" ; sleep 1
    echo "# Check all files ..." ; sleep 1
    setupact-config-update
    echo "75" ; sleep 3
    echo "# All files are checked!" ; sleep 1
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
           --text="$text_skip_update_question" \
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
             --text="$text_error"
    exit;
  fi
}

###############################################################################################################################################################
# THE PROGRAM IS STARTED HERE:                                                                                                                                #
###############################################################################################################################################################

setupact-config-locale
setupact-progressbar
