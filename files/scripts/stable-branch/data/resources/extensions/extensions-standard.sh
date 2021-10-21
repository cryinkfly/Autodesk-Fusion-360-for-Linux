#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you get all extensions for the Setup Wizard.                        #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2021                                                                          #
# Time/Date:    16:00/21.10.2021                                                                   #
# Version:      1.2                                                                                #
####################################################################################################

###############################################################################################################################################################
# ALL FUNCTIONS & DIALOGS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# Install selected plugins!

function install-extensions-standard {

if [ "$plugin_1" = "1" ]; then
  airfoil-tools-plugin-standard
else
  echo "Airfoil Tools not selected."
fi

if [ "$plugin_2" = "1" ]; then
  additive-assistant-plugin-standard
else
  echo "Additive Assistant (FFF) not selected."
fi

if [ "$plugin_3" = "1" ]; then
  czech-locale-plugin-standard
else
  echo "Czech localization for F360 not selected."
fi

if [ "$plugin_4" = "1" ]; then
  hp-3dprinter-connector-plugin-standard
else
  echo "HP 3D Printers for Autodesk® Fusion 360™ not selected."
fi

if [ "$plugin_5" = "1" ]; then
  octoprint-plugin-standard
else
  echo "OctoPrint for Autodesk® Fusion 360™ not selected."
fi

if [ "$plugin_6" = "1" ]; then
  robodk-plugin-standard
else
  echo "RoboDK not selected."
fi

if [ "$reset" = "1" ]; then
  manager-extensions-standard
else
  echo "Reset!"
fi
}

##############################################################################

# Airfoil Tools

function airfoil-tools-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/extensions/AirfoilTools_win64.msi
}

##############################################################################

# Additive Assistant (FFF)

function additive-assistant-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/extensions/AdditiveAssistant.bundle-win64.msi
}

##############################################################################

# Czech localization for F360

function czech-locale-search-plugin {
CZECH_LOCALE=`zenity --file-selection --title="$text_select_czech_plugin"`

case $? in
       0)
              echo "\"$FILE\" selected.";;
       1)
              zenity --info \
              --text="$text_info_czech_plugin"
              install-extensions-standard
              ;;
       -1)
              echo "An unexpected error occurred!";;
esac
}

function czech-locale-plugin-standard {
    czech-locale-search-plugin
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine $CZECH_LOCALE
}

##############################################################################

# HP 3D Printers for Autodesk® Fusion 360™

function hp-3dprinter-connector-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/extensions/HP_3DPrinters_for_Fusion360-win64.msi
}

##############################################################################

# OctoPrint for Autodesk® Fusion 360™

function octoprint-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/extensions/OctoPrint_for_Fusion360-win64.msi
}

##############################################################################

# RoboDK

function robodk-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/extensions/RoboDK.bundle-win64.msi
}

##############################################################################
# ALL DIALOGS ARE ARRANGED HERE:
##############################################################################

# Installation of various extensions is offered here. For examble: OctoPrint for Autodesk® Fusion 360™

function manager-extensions-standard {
  response=$(zenity --list \
                    --checklist \
                    --title="$program_name" \
                    --width=900 \
                    --height=500 \
                    --column="$text_select" --column="$text_extension" --column="$text_extension_description"\
                    FALSE "Airfoil Tools" "$text_extension_description_1" \
                    FALSE "Additive Assistant (FFF)" "$text_extension_description_2" \
                    FALSE "Czech localization for F360" "$text_extension_description_3" \
                    FALSE "HP 3D Printers for Autodesk® Fusion 360™" "$text_extension_description_4" \
                    FALSE "OctoPrint for Autodesk® Fusion 360™" "$text_extension_description_5" \
                    FALSE "RoboDK" "$text_extension_description_6" )

[[ $response = *"Airfoil Tools"* ]] && plugin_1="1"

[[ $response = *"Additive Assistant (FFF)"* ]] && plugin_2="1"

[[ $response = *"Czech localization for F360"* ]] && plugin_3="1"

[[ $response = *"HP 3D Printers for Autodesk® Fusion 360™"* ]] && plugin_4="1"

[[ $response = *"OctoPrint for Autodesk® Fusion 360™"* ]] && plugin_5="1"

[[ $response = *"RoboDK"* ]] && plugin_6="1"

[[ "$response" ]] || reset="1" #manager-extensions-standard
}

##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

plugin_1="0"
plugin_2="0"
plugin_3="0"
plugin_4="0"
plugin_5="0"
plugin_6="0"
reset="0"

manager-extensions-standard
install-extensions-standard
