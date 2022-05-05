#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you can install Autodesk Fusion 360 on Linux.                       #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    18:30/05.05.2022                                                                   #
# Version:      1.7.9 -> 1.8.0                                                                     #
####################################################################################################

# Path: /$HOME/.fusion360/bin/install.sh

###############################################################################################################################################################
# DESCRIPTION IN DETAIL                                                                                                                                       #
###############################################################################################################################################################
# With the help of my setup wizard, you will be given a way to install Autodesk Fusion 360 with some extensions on                                            #
# Linux so that you don't have to use Windows or macOS for this program in the future!                                                                        #
#                                                                                                                                                             #
# Also, my setup wizard will guides you through the installation step by step and will install some required packages.                                        #
#                                                                                                                                                             #
# The next one is you have the option of installing the program directly on your system or you can install it on an external storage medium.                  #
#                                                                                                                                                             #
# But it's important to know, you must to purchase the licenses directly from the manufacturer of Autodesk Fusion 360, when you will work with them on Linux! #
###############################################################################################################################################################

###############################################################################################################################################################
# ALL BASIC VALUES ARE CONFIGURED HERE:                                                                                                                       #
###############################################################################################################################################################

# Default-Path:
SP_PATH="$HOME/.fusion360"

# Reset the locale value:
SP_LOCALE="en-US"
SP_LICENSE="$SP_PATH/locale/en-US/license-en.txt"

# Reset the graphics driver value:
SP_DRIVER="DXVK"

###############################################################################################################################################################
# THE INITIALIZATION OF DEPENDENCIES STARTS HERE:                                                                                                             #
###############################################################################################################################################################

function SP_STRUCTURE {
  mkdir -p $SP_PATH/bin
  mkdir -p $SP_PATH/logs
  mkdir -p $SP_PATH/config
  mkdir -p $SP_PATH/servers
  mkdir -p $SP_PATH/graphics
  mkdir -p $SP_PATH/downloads
  mkdir -p $SP_PATH/locale/cs-CZ
  mkdir -p $SP_PATH/locale/de-DE
  mkdir -p $SP_PATH/locale/en-US
  mkdir -p $SP_PATH/locale/es-ES
  mkdir -p $SP_PATH/locale/fr-FR
  mkdir -p $SP_PATH/locale/it-IT
  mkdir -p $SP_PATH/locale/ja-JP
  mkdir -p $SP_PATH/locale/ko-KR
  mkdir -p $SP_PATH/locale/zh-CN
}

###############################################################################################################################################################

# Get all server connections (links):
function SP_SERVER_LIST {  
  # LIST
  wget -N -P $SP_PATH/servers https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/servers/server-list.txt
  
  # LANGUAGE FILES
  SP_SERVER_1=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 8'`
  SP_SERVER_2=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 10'`
  SP_SERVER_3=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 11'`
  SP_SERVER_4=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 13'`
  SP_SERVER_5=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 14'`
  SP_SERVER_6=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 16'`
  SP_SERVER_7=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 17'`
  SP_SERVER_8=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 19'`
  SP_SERVER_9=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 20'`
  SP_SERVER_10=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 22'`
  SP_SERVER_11=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 23'`
  SP_SERVER_12=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 25'`
  SP_SERVER_13=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 26'`
  SP_SERVER_14=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 28'`
  SP_SERVER_15=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 29'`
  SP_SERVER_16=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 31'`
  SP_SERVER_17=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 32'`
  SP_SERVER_18=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 34'`
  SP_SERVER_19=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 35'`
  
  # WINETRICKS
  SP_SERVER_20=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 42'`
  
  # AUTODESK FUSION 360 INSTALLER
  SP_SERVER_21=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 49'`
  
  # DXVK AND OPENGL:
  SP_SERVER_22=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 56'`
  SP_SERVER_23=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 57'`
  SP_SERVER_24=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 58'`
  
  # ICONS:
  SP_SERVER_25=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 65'`
  SP_SERVER_26=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 66'`
  
  # EXTRA SCRIPTS:
  SP_SERVER_27=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 73'`
  SP_SERVER_28=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 74'`
  SP_SERVER_29=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 75'`
  SP_SERVER_30=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 76'`
  
  # EXTENSIONS:
  SP_SERVER_30=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 83'`
  SP_SERVER_30=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 84'`
  SP_SERVER_30=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 85'`
  SP_SERVER_30=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 86'`
  SP_SERVER_30=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 87'`
  SP_SERVER_30=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 88'`
  SP_SERVER_30=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 89'`
  SP_SERVER_30=`cat $SP_PATH/servers/server-list.txt | awk 'NR == 90'`
}

###############################################################################################################################################################

# Load the index of locale files:
function SP_LOCALE_INDEX {
  wget -N -P $SP_PATH/locale $SP_SERVER_1
  chmod +x $SP_PATH/locale/locale.sh
  . $SP_PATH/locale/locale.sh
  SP_LOCALE_EN
}

# Czech:
function SP_LOCALE_CS {
  SP_LOCALE="cs-CZ"
  . $SP_PATH/locale/cs-CZ/locale-cs.sh
  SP_LICENSE="$SP_PATH/locale/cs-CZ/license-cs.txt"
}

# German:
function SP_LOCALE_DE {
  SP_LOCALE="de-DE"
  . $SP_PATH/locale/de-DE/locale-de.sh
  SP_LICENSE="$SP_PATH/locale/de-DE/license-de.txt"
}

# English:
function SP_LOCALE_EN {
  SP_LOCALE="en-US"
  . $SP_PATH/locale/en-US/locale-en.sh
  SP_LICENSE="$SP_PATH/locale/en-US/license-en.txt"
}

# Spanish:
function SP_LOCALE_ES {
  SP_LOCALE="es-ES"
  . $SP_PATH0/locale/es-ES/locale-es.sh
  SP_LICENSE="$SP_PATH/locale/es-ES/license-es.txt"
}

# French:
function SP_LOCALE_FR {
  SP_LOCALE="fr-FR"
  . $SP_PATH/locale/fr-FR/locale-fr.sh
  SP_LICENSE="$SP_PATH/locale/fr-FR/license-fr.txt"
}


# Italian:
function SP_LOCALE_IT {
  SP_LOCALE="it-IT"
  . $SP_PATH/locale/it-IT/locale-it.sh
  SP_LICENSE="$SP_PATH/locale/it-IT/license-it.txt"
}

# Japanese:
function SP_LOCALE_JA {
  SP_LOCALE="ja-JP"
  . $SP_PATH/locale/ja-JP/locale-ja.sh
  SP_LICENSE="$SP_PATH/locale/ja-JP/license-ja.txt"
}

# Korean:
function SP_LOCALE_KO {
  SP_LOCALE="ko-KR"
  . $SP_PATH/locale/ko-KR/locale-ko.sh
  SP_LICENSE="$SP_PATH/locale/ko-KR/license-ko.txt"
}

# Chinese:
function SP_LOCALE_ZH {
  SP_LOCALE="zh-CN"
  . $SP_PATH/locale/zh-CN/locale-zh.sh
  SP_LICENSE="$SP_PATH/locale/zh-CN/license-zh.txt"
}

###############################################################################################################################################################

# Load the newest winetricks version:
function SP_WINETRICKS_LOAD {
  wget -N -P $SP_PATH/bin $SP_SERVER_20
  chmod +x $SP_PATH/bin/winetricks
}

###############################################################################################################################################################

# Load newest Autodesk Fusion 360 installer version for the Setup Wizard!
function SP_FUSION360_INSTALLER_LOAD {
  # Search for a existing installer of Autodesk Fusion 360
  FUSION360_INSTALLER="$SP_PATH/downloads/Fusion360installer.exe"
  if [ -f "$FUSION360_INSTALLER" ]; then
    echo "The Autodesk Fusion 360 installer exist!"
  else
    echo "The Autodesk Fusion 360 installer doesn't exist and will be downloaded for you!"
    wget $SP_SERVER_21 -O Fusion360installer.exe
    mv "Fusion360installer.exe" "$SP_PATH/downloads/Fusion360installer.exe"
  fi
}
