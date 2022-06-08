#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Cronjob for Update (Linux)                                   #
# Description:  This file checks whether there is a newer version of Autodesk Fusion 360.          #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    22:30/08.06.2022                                                                   #
# Version:      1.1                                                                                #
####################################################################################################

# Path: /$HOME/.fusion360/bin/update.sh

###############################################################################################################################################################

# Default-Path:
DL_PATH="$HOME/.fusion360"

###############################################################################################################################################################

# Copy the file where the user can see the exits Wineprefixes of Autodesk Fusion 360 on the system.
function UP_GET_FILES {
  mkdir -p "/tmp/fusion360/logs"
  cp "$HOME/.fusion360/config/settings.txt" "/tmp/fusion360/config"
}

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

function UP_LOAD_LOCALE {
  UP_LOCALE=`cat /tmp/fusion360/settings.txt | awk 'NR == 1'`
  if [[ $UP_LOCALE = "Czech" ]]; then
    echo "CS"
    . $DL_PATH/locale/cs-CZ/locale-cs.sh
  elif [[ $UP_LOCALE = "English" ]]; then
    echo "EN"
    . $DL_PATH/locale/en-US/locale-en.sh
  elif [[ $UP_LOCALE = "German" ]]; then
    echo "DE"
    . $DL_PATH/locale/de-DE/locale-de.sh
  elif [[ $UP_LOCALE = "Spanish" ]]; then
    echo "ES"
    . $DL_PATH0/locale/es-ES/locale-es.sh
  elif [[ $UP_LOCALE = "French" ]]; then
    echo "FR"
    . $DL_PATH/locale/fr-FR/locale-fr.sh
  elif [[ $UP_LOCALE = "Italian" ]]; then
    echo "IT"
    . $DL_PATH/locale/it-IT/locale-it.sh
  elif [[ $UP_LOCALE = "Japanese" ]]; then
    echo "JP"
    . $DL_PATH/locale/ja-JP/locale-ja.sh
  elif [[ $UP_LOCALE = "Korean" ]]; then
    echo "KO"
    . $DL_PATH/locale/ko-KR/locale-ko.sh
  elif [[ $UP_LOCALE = "Chinese" ]]; then
    echo "ZH"
    . $DL_PATH/locale/zh-CN/locale-zh.sh
  else 
   echo "EN"
   . $DL_PATH/locale/en-US/locale-en.sh
  fi
}

###############################################################################################################################################################

# Checks if there is an update for Autodesk Fusion 360.
function UP_CHECK_INFO {
  if [ $GET_UPDATE -eq 1 ]; then
    UP_QUESTION
  elif [ $GET_UPDATE -eq 0 ]; then
    UP_NO_UPDATE_INFO
  else    
    UP_NO_CONNECTION_WARNING
  fi
}

###############################################################################################################################################################

function UP_GET_UPDATE {
  wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360installer.exe
  mv "Fusion360installer.exe" "$HOME/.fusion360/downloads/Fusion360installer.exe"
  cp "$HOME/.fusion360/downloads/Fusion360installer.exe" "$WP_BOX/drive_c/users/$USER/Downloads/Fusion360installer.exe"
}

###############################################################################################################################################################

# Start Fusion360installer.exe - Part 1
function UP_FUSION360_INSTALL_START_1 {
  WINEPREFIX=$WP_BOX wine $WP_BOX/drive_c/users/$USER/Downloads/Fusion360installer.exe
}

# Stop Fusion360installer.exe - Part 1
function UP_FUSION360_INSTALL_STOP_1 {
  sleep 3m
  kill -9 $(ps aux |grep -i '\.exe' |awk '{print $2}'|tr '\n' ' ')
}

# Start Fusion360installer.exe - Part 2
function UP_FUSION360_INSTALL_START_2 {
  WINEPREFIX=$WP_BOX wine $WP_BOX/drive_c/users/$USER/Downloads/Fusion360installer.exe
}

# Stop Fusion360installer.exe - Part 2
function UP_FUSION360_INSTALL_STOP_2 {
  sleep 1m
  kill -9 $(ps aux |grep -i '\.exe' |awk '{print $2}'|tr '\n' ' ')
}

###############################################################################################################################################################
# ALL DIALOGS ARE ARRANGED HERE:                                                                                                                              #
###############################################################################################################################################################

# The user get a informationt that no newer version of Autodesk Fusion 360 was found!
function UP_NO_UPDATE_INFO {
  yad --title="$UP_TITLE" --text="$UP_NO_UPDATE_INFO_LABEL" --text-align=center
  LAUNCHER_RUN_FUSION360
}

###############################################################################################################################################################

# The user will be informed that he is skipping the update!
function UP_SKIP_INFO {
  yad --title="$UP_TITLE" --text="$UP_SKIP_INFO_LABEL" --text-align=center
  LAUNCHER_RUN_FUSION360
}

###############################################################################################################################################################

# The user get a informationt that there is no connection to the server!
function UP_NO_CONNECTION_WARNING {
  yad --title="$UP_TITLE" --text="$UP_NO_CONNECTION_WARNING_LABEL" --text-align=center
  LAUNCHER_RUN_FUSION360
}

###############################################################################################################################################################

# The user will be asked if he wants to update or not.
function UP_QUESTION {
  yad --title="$UP_TITLE" --text="$UP_QUESTION_LABEL" --text-align=center --button=gtk-cancel:0 --button=gtk-ok:1
  
  answer=$?

  if [ "$answer" -eq 0 ]; then    
    UP_GET_UPDATE
    UP_FUSION360_INSTALL_UPDATE_PROGRESS
  elif [ "$answer" -eq 1 ]; then
    UP_SKIP_INFO
  fi
}

###############################################################################################################################################################

# A progress bar is displayed here.
function UP_PROGRESS {
  UP_PROGRESS_MAIN () {
    echo "30" ; sleep 5
    echo "50" ; sleep 1
    echo "UP_PROGRESS_LABEL_2" ; sleep 5
    echo "100" ; sleep 3
    echo "UP_PROGRESS_LABEL_3" ; sleep 1
  }
  
  UP_PROGRESS_MAIN | yad --title="$UP_TITLE" --progress --progress-text "$UP_PROGRESS_LABEL_1" --percentage=0 --button=gtk-cancel:0 --button=gtk-ok:1

  ret=$?

  # Responses to above button presses are below:
  if [[ $ret -eq 0 ]]; then
    UP_SKIP_INFO 
  elif [[ $ret -eq 1 ]]; then
    UP_CHECK_INFO
  fi
}

###############################################################################################################################################################

function UP_FUSION360_INSTALL_UPDATE_PROGRESS {

UP_FUSION360_INSTALL_PROGRESS_MAIN () {
echo "20"
UP_FUSION360_INSTALL_START_1 & UP_FUSION360_INSTALL_STOP_1 # These two commands run in the same time.
echo "70"
UP_FUSION360_INSTALL_START_2 & UP_FUSION360_INSTALL_STOP_2 # These two commands run in the same time.
sleep 5
echo "100"
}

UP_FUSION360_INSTALL_UPDATE_PROGRESS_MAIN | yad --progress --progress-text "$UP_INSTALL_UPDATE_PROGRESS_LABEL" --percentage=0 --auto-close

LAUNCHER_RUN_FUSION360
}

###############################################################################################################################################################
# THE PROGRAM IS STARTED HERE:                                                                                                                                #
###############################################################################################################################################################

UP_GET_FILES
UP_LOAD_LOCALE
UP_PROGRESS
