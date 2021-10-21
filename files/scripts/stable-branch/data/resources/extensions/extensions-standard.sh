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

# Airfoil Tools

function airfoil-tools-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/extensions/AirfoilTools_win64.msi
}

##############################################################################

# Additive Assistant (FFF)

function additive-assistant-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/extensions/AdditiveAssistant_win64.msi
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
              manager-extensions-standard
              install-extensions-standard
              ;;
       -1)
              zenity --error \
              --text="$text_error"
              exit;
              ;;
esac
}

function czech-locale-plugin-standard {
    czech-locale-search-plugin
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine $CZECH_LOCALE
}

##############################################################################

# HP 3D Printers for Autodesk® Fusion 360™

function hp-3dprinter-connector-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/extensions/HP3DPrintersForFusion360_win64.msi
}

##############################################################################

# OctoPrint for Autodesk® Fusion 360™

function octoprint-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/extensions/OctoPrintForFusion360_win64.msi
}

##############################################################################

# RoboDK

function robodk-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/extensions/RoboDK_win64.msi
}

##############################################################################
# ALL DIALOGS ARE ARRANGED HERE:
##############################################################################

# Installation of various extensions is offered here. For examble: OctoPrint for Autodesk® Fusion 360™

function manager-extensions-standard {

  response=$(zenity --list \
                    --checklist \
                    --title="$program_name" \
                    --width=1000 \
                    --height=500 \
                    --column="$text_select" --column="$text_extension" --column="$text_extension_description"\
                    FALSE "Airfoil Tools" "$text_extension_description_1" \
                    FALSE "Additive Assistant (FFF)" "$text_extension_description_2" \
                    FALSE "Czech localization for F360" "$text_extension_description_3" \
                    FALSE "HP 3D Printers for Autodesk® Fusion 360™" "$text_extension_description_4" \
                    FALSE "OctoPrint for Autodesk® Fusion 360™" "$text_extension_description_5" \
                    FALSE "RoboDK" "$text_extension_description_6" )

[[ $response = *"Airfoil Tools"* ]] && airfoil-tools-plugin-standard

[[ $response = *"Additive Assistant (FFF)"* ]] && additive-assistant-plugin-standard

[[ $response = *"Czech localization for F360"* ]] && czech-locale-plugin-standard

[[ $response = *"HP 3D Printers for Autodesk® Fusion 360™"* ]] && hp-3dprinter-connector-plugin-standard

[[ $response = *"OctoPrint for Autodesk® Fusion 360™"* ]] && octoprint-plugin-standard

[[ $response = *"RoboDK"* ]] && robodk-plugin-standard

[[ "$response" ]] || manager-extensions-standard
}

##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

manager-extensions-standard
