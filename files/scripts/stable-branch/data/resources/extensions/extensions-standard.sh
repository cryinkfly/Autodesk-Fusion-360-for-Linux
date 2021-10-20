#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you get all extensions for the Setup Wizard.                        #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2021                                                                          #
# Time/Date:    10:00/20.10.2021                                                                   #
# Version:      1.0                                                                                #
####################################################################################################

###############################################################################################################################################################
# ALL FUNCTIONS & DIALOGS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

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

function install-extensions-standard {
  response=$(zenity --list \
                    --checklist \
                    --title="$program_name" \
                    --width=650 \
                    --height=400 \
                    --column="$text_select" --column="$text_extension" --column="$text_extension_description"\
                    FALSE "Airfoil Tools" "$text_extension_description_1" \
                    FALSE "Additive Assistant (FFF)" "$text_extension_description_2" \
                    FALSE "Czech localization for F360" "$text_extension_description_3" \
                    FALSE "HP 3D Printers for Autodesk® Fusion 360™" "$text_extension_description_4" \
                    FALSE "OctoPrint for Autodesk® Fusion 360™" "$text_extension_description_5" \
                    FALSE "RoboDK" "$text_extension_description_6" )

[[ $response = "Airfoil Tools" ]] && airfoil-tools-plugin-standard

[[ $response = "Additive Assistant (FFF)" ]] && additive-assistant-plugin-standard

[[ $response = "Czech localization for F360" ]] && czech-locale-plugin-standard

[[ $response = "HP 3D Printers for Autodesk® Fusion 360™" ]] && hp-3dprinter-connector-plugin-standard

[[ $response = "OctoPrint for Autodesk® Fusion 360™" ]] && octoprint-plugin-standard

[[ $response = "RoboDK" ]] && robodk-plugin-standard

[[ "$response" ]] || install-extensions-standard
}

##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

install-extensions-standard
