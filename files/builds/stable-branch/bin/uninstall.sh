#!/bin/bash

################################################################################
# Name:         Autodesk Fusion 360 - Uninstall the software (Linux)           #
# Description:  With this file you delete Autodesk Fusion 360 on your system.  #
# Author:       Steve Zabka                                                    #
# Author URI:   https://cryinkfly.com                                          #
# License:      MIT                                                            #
# Copyright (c) 2020-2022                                                      #
# Time/Date:    11:00/21.02.2022                                               #
# Version:      0.7                                                            #
################################################################################

# Path: /$HOME/.config/fusion-360/bin/uninstall.sh

###############################################################################################################################################################

# Window Title (Launcher)
program_name="Autodesk Fusion 360 for Linux - Uninstall"

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################


# Get a file where the user can see the exits Wineprefixes of Autodesk Fusion 360 on the system.
function setupact-get-wineprefixes-log {
  mkdir -p "/tmp/fusion-360/logs"
  cp "$HOME/.config/fusion-360/logs/wineprefixes.log" "/tmp/fusion-360/logs"
  mv "/tmp/fusion-360/logs/wineprefixes.log" "/tmp/fusion-360/logs/wineprefixes"
}

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
  config_locale=`. $HOME/.config/fusion-360/local/user-locale.sh $HOME/.config/fusion-360/logs/profile-locale.log 1`
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

# Remove a exist Wineprefix of Autodesk Fusion 360!
function setupact-uninstall {
  setupact-select-wineprefix-info
  setupact-select-wineprefix
  rm -r "$wineprefix_directory"
  setupact-uninstall-completed
}

###############################################################################################################################################################
# ALL DIALOGS ARE ARRANGED HERE:                                                                                                                              #
###############################################################################################################################################################

# The user will be asked if he wants to uninstall or not.
function setupact-uninstall-question {
  zenity --question \
         --title="$program_name" \
         --text="$text_uninstall_question" \
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
         --text="$text_uninstall_cancel" \
         --width=400 \
         --height=100
	 
  if [ "$uninstall_standalone" -eq 0 ]; then       
    exit;
  elif [ "$uninstall_standalone" -eq 1 ]; then 
    echo "Go back"
    program_name="Autodesk Fusion 360 for Linux - Setup Wizard"
    setupact-modify-f360
  fi
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
                    --checkbox="$text_uninstall_checkbox"`

  case $? in
    0)
        zenity --question \
               --title="$program_name" \
               --text="$text_uninstall_edit_question" \
               --width=400 \
               --height=100
        answer=$?

        if [ "$answer" -eq 0 ]; then
          echo "$directory" > $file
	  cp "$file" "$HOME/.config/fusion-360/logs"
	  mv "$HOME/.config/fusion-360/logs/wineprefixes" "$HOME/.config/fusion-360/logs/wineprefixes.log"
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
               --text="$text_error"
        exit;
        ;;
  esac

}

###############################################################################################################################################################

# Select the Wineprefix-directory of your Autodesk Fusion 360 installation!
function setupact-select-wineprefix-info {
  zenity --info \
         --text="$text_uninstall_path" \
         --width=400 \
         --height=100
}

function setupact-select-wineprefix {
  wineprefix_directory=`zenity --file-selection --directory --title="$text_uninstall_path_select"`
}

###############################################################################################################################################################

# The uninstallation is complete and will be terminated.
function setupact-uninstall-completed {
  zenity --info \
         --width=400 \
         --height=100 \
         --text="$text_uninstall_completed"

  exit;
}


# Abort the locale-configuration of Uninstall!
function setupact-uninstall-configure-locale-abort {
  zenity --question \
         --title="$program_name" \
         --text="$text_abort" \
         --width=400 \
         --height=100
  answer=$?

  if [ "$answer" -eq 0 ]; then
    exit;
  elif [ "$answer" -eq 1 ]; then
    setupact-uninstall-configure-locale
  fi
}

###############################################################################################################################################################
# THE PROGRAM IS STARTED HERE:                                                                                                                                #
###############################################################################################################################################################

setupact-config-locale
setupact-get-wineprefixes-log
setupact-uninstall-question
