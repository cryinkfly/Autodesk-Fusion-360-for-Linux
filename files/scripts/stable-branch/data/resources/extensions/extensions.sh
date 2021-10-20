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

# Load & Save the locale files into the folders!

function load-extensions-files {
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/blob/main/files/extensions/AdditiveAssistant.bundle-win64.msi
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/blob/main/files/extensions/AdditiveAssistant.bundle-win64.msi
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/blob/main/files/extensions/HP_3DPrinters_for_Fusion360-win64.msi
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/blob/main/files/extensions/OctoPrint_for_Fusion360-win64.msi
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/blob/main/files/extensions/RoboDK.bundle-win64.msi
}

##############################################################################

# Airfoil Tools

function airfoil-tools-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine AirfoilTools_win64.msi
}

function airfoil-tools-plugin-custom {
    WINEPREFIX=$custom_directory wine AirfoilTools_win64.msi
}

##############################################################################

# Additive Assistant (FFF)

function additive-assistant-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine AdditiveAssistant.bundle-win64.msi
}

function additive-assistant-plugin-custom {
    WINEPREFIX=$custom_directory wine AdditiveAssistant.bundle-win64.msi
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

function czech-locale-plugin-custom {
    czech-locale-search-plugin
    WINEPREFIX=$custom_directory wine $CZECH_LOCALE
}

##############################################################################

# HP 3D Printers for Autodesk® Fusion 360™

function hp-3dprinter-connector-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine HP_3DPrinters_for_Fusion360-win64.msi
}

function hp-3dprinter-connector-plugin-custom {
    WINEPREFIX=$custom_directory wine HP_3DPrinters_for_Fusion360-win64.msi
}

##############################################################################

# OctoPrint for Autodesk® Fusion 360™

function octoprint-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine OctoPrint_for_Fusion360-win64.msi
}

function octoprint-plugin-custom {
    WINEPREFIX=$custom_directory wine OctoPrint_for_Fusion360-win64.msi
}

##############################################################################

# RoboDK

function robodk-plugin-standard {
    WINEPREFIX=$HOME/.wineprefixes/fusion360 wine RoboDK.bundle-win64.msi
}

function robodk-plugin-custom {
    WINEPREFIX=$custom_directory wine RoboDK.bundle-win64.msi
}

##############################################################################
# ALL DIALOGS ARE ARRANGED HERE:
##############################################################################

# Installation of various extensions is offered here. For examble: OctoPrint for Autodesk® Fusion 360™

function install-extensions-standard {
  response=$(zenity --list \
                    --checklist \
                    --title="$program_name" \
                    --width=400 \
                    --height=300 \
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

function install-extensions-custom {
  response=$(zenity --list \
                    --checklist \
                    --title="$program_name" \
                    --width=400 \
                    --height=300 \
                    --column="$text_select" --column="$text_extension" --column="$text_extension_description"\
                    FALSE "Airfoil Tools" "$text_extension_description_1" \
                    FALSE "Additive Assistant (FFF)" "$text_extension_description_2" \
                    FALSE "Czech localization for F360" "$text_extension_description_3" \
                    FALSE "HP 3D Printers for Autodesk® Fusion 360™" "$text_extension_description_4" \
                    FALSE "OctoPrint for Autodesk® Fusion 360™" "$text_extension_description_5" \
                    FALSE "RoboDK" "$text_extension_description_6" )

[[ $response = "Airfoil Tools" ]] && airfoil-tools-plugin-custom

[[ $response = "Additive Assistant (FFF)" ]] && additive-assistant-plugin-custom

[[ $response = "Czech localization for F360" ]] && czech-locale-plugin-custom

[[ $response = "HP 3D Printers for Autodesk® Fusion 360™" ]] && hp-3dprinter-connector-plugin-custom

[[ $response = "OctoPrint for Autodesk® Fusion 360™" ]] && octoprint-plugin-custom

[[ $response = "RoboDK" ]] && robodk-plugin-custom

[[ "$response" ]] || install-extensions-custom
}

##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

load-extensions-files
