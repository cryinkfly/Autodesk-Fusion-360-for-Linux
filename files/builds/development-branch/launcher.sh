#!/bin/bash

#############################################################################
# Name:         Autodesk Fusion 360 - Launcher (Linux)                      #
# Description:  With this file you run Autodesk Fusion 360 on your system.  #
# Author:       Steve Zabka                                                 #
# Author URI:   https://cryinkfly.com                                       #
# License:      MIT                                                         #
# Copyright (c) 2020-2022                                                   #
# Time/Date:    08:45/05.06.2022                                            #
# Version:      1.8 -> 1.9                                                  #
#############################################################################

# Path: /$HOME/.config/fusion-360/bin/launcher.sh

#################################
# Open Autodesk Fusion 360 now! #
#################################

SP_PATH="$HOME/.fusion360"

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

function LAUNCHER_LOAD_LOCALE {
  DL_LOCALE=`cat /tmp/fusion360/settings.txt | awk 'NR == 1'`
  if [[ $LAUNCHER_LOAD_LOCALE = "Czech" ]]; then
    echo "CS"
    . $DL_PATH/locale/cs-CZ/locale-cs.sh
  elif [[ $LAUNCHER_LOAD_LOCALE = "English" ]]; then
    echo "EN"
    . $DL_PATH/locale/en-US/locale-en.sh
  elif [[ $LAUNCHER_LOAD_LOCALE = "German" ]]; then
    echo "DE"
    . $DL_PATH/locale/de-DE/locale-de.sh
  elif [[ $LAUNCHER_LOAD_LOCALE = "Spanish" ]]; then
    echo "ES"
    . $DL_PATH0/locale/es-ES/locale-es.sh
  elif [[ $LAUNCHER_LOAD_LOCALE = "French" ]]; then
    echo "FR"
    . $DL_PATH/locale/fr-FR/locale-fr.sh
  elif [[ $LAUNCHER_LOAD_LOCALE = "Italian" ]]; then
    echo "IT"
    . $DL_PATH/locale/it-IT/locale-it.sh
  elif [[ $LAUNCHER_LOAD_LOCALE = "Japanese" ]]; then
    echo "JP"
    . $DL_PATH/locale/ja-JP/locale-ja.sh
  elif [[ $LAUNCHER_LOAD_LOCALE = "Korean" ]]; then
    echo "KO"
    . $DL_PATH/locale/ko-KR/locale-ko.sh
  elif [[ $LAUNCHER_LOAD_LOCALE = "Chinese" ]]; then
    echo "ZH"
    . $DL_PATH/locale/zh-CN/locale-zh.sh
  else 
   echo "EN"
   . $DL_PATH/locale/en-US/locale-en.sh
  fi
}


###############################################################################################################################################################
# THE PROGRAM IS STARTED HERE:                                                                                                                                #
###############################################################################################################################################################

LAUNCHER_LOAD_LOCALE
Fusion360Launcher="$(mktemp)"
rm $Fusion360Launcher
mkfifo $Fusion360Launcher
# Kanal wird etabliert:
exec 3<> $Fusion360Launcher
# Yad wird gestartet:
yad --notification --command='./fusion360.sh' --listen <&3 &
# Menü wird definiert:
>&3 echo "menu:\
Open Fusion 360 ...!./fusion360.sh!$SP_PATH/graphics/favorite.svg|\
Switch Boxes ...!./switcher.sh!$SP_PATH/graphics/window.svg|\
Documentation ...!./help.sh!$SP_PATH/graphics/help.svg|\
Settings ...!./settings.sh!$SP_PATH/graphics/settings.svg|\
About ...!./about.sh!$SP_PATH/graphics/about.svg|\
Exit ...!pkill yad!$SP_PATH/graphics/exit.svg \
"
# Tooltip wird definiert:
>&3 echo "TOOLTIP:Fusion360Launcher"
# Icon wird definiert:
>&3 echo "icon:$SP_PATH/graphics/launcher.svg"
