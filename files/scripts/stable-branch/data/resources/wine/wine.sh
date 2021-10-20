#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you install Autodesk Fusion 360 with Wine and Winetricks.           #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2021                                                                          #
# Time/Date:    10:00/20.10.2021                                                                   #
# Version:      1.0                                                                                #
####################################################################################################

###############################################################################################################################################################
# DESCRIPTION IN DETAIL                                                                                                                                       #
###############################################################################################################################################################
# Autodesk Fusion 360 will now be installed using Wine and Winetricks!                                                                                        #
###############################################################################################################################################################

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

function winetricks-standard {
   mkdir -p $HOME/.wineprefixes/fusion360
   WINEPREFIX=$HOME/.wineprefixes/fusion360 sh data/resources/wine/winetricks -q corefonts cjkfonts msxml4 msxml6 vcrun2017 fontsmooth=rgb win8
   # We must install cjkfonts again then sometimes it doesn't work the first time!
   WINEPREFIX=$HOME/.wineprefixes/fusion360 sh data/resources/wine/winetricks -q cjkfonts
   configure-dxvk-or-opengl-standard-1
   WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/fusion360-installer/Fusion360installer.exe -p deploy -g -f log.txt --quiet
   WINEPREFIX=$HOME/.wineprefixes/fusion360 wine data/resources/fusion360-installer/Fusion360installer.exe -p deploy -g -f log.txt --quiet
   mkdir -p "$HOME/.wineprefixes/fusion360/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options"
   configure-dxvk-or-opengl-standard-2
   # Because the location varies depending on the Linux distro!
   mkdir -p "$HOME/.wineprefixes/fusion360/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options"
   configure-dxvk-or-opengl-standard-3
   #Set up the program launcher for you!
   wget https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/Autodesk%20Fusion%20360.desktop
   mv Autodesk%20Fusion%20360.desktop $HOME/.local/share/applications/Autodesk%20Fusion%20360.desktop
   logfile-installation-standard
   . data/resources/extensions/extensions.sh && install-extensions-standard
   program-exit
}

##############################################################################

# Winetricks - Custom

function winetricks-custom {
   mkdir -p $custom_directory
   WINEPREFIX=$custom_directory sh data/resources/wine/winetricks -q corefonts cjkfonts msxml4 msxml6 vcrun2017 fontsmooth=rgb win8
   # We must install cjkfonts again then sometimes it doesn't work the first time!
   WINEPREFIX=$custom_directory sh data/resources/wine/winetricks -q cjkfonts
   configure-dxvk-or-opengl-custom-1
   WINEPREFIX=$custom_directory wine data/resources/fusion360-installer/Fusion360installer.exe -p deploy -g -f log.txt --quiet
   WINEPREFIX=$custom_directory wine data/resources/fusion360-installer/Fusion360installer.exe -p deploy -g -f log.txt --quiet
   mkdir -p "$custom_directory/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options"
   configure-dxvk-or-opengl-custom-2
   # Because the location varies depending on the Linux distro!
   mkdir -p "$custom_directory/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options"
   configure-dxvk-or-opengl-custom-3
   #Set up the program launcher for you!
   wget https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/Autodesk%20Fusion%20360
   desktop-launcher-custom
   mv Autodesk%20Fusion%20360 $HOME/.local/share/applications/Autodesk%20Fusion%20360.desktop
   logfile-installation-custom
   . data/resources/extensions/extensions.sh && install-extensions-custom
   program-exit
}

##############################################################################
# ALL DIALOGS ARE ARRANGED HERE:
##############################################################################

function desktop-launcher-custom {
  file=`dirname $0`/Autodesk%20Fusion%20360
  launcher=`zenity --text-info \
         --title="$program_name" \
         --width=650 \
         --height=400 \
         --filename=$file \
         --editable \
         --checkbox="$text_desktop_launcher_custom_checkbox"`

  case $? in
      0)
          zenity --question \
                 --title="$program_name" \
                 --text="$text_desktop_launcher_custom_question" \
                 --width=350 \
                 --height=100
          answer=$?

          if [ "$answer" -eq 0 ]; then
              echo "$launcher" > $file
          elif [ "$answer" -eq 1 ]; then
              desktop-launcher-custom
          fi

  	      ;;
      1)
          echo "Go back"
          desktop-launcher-custom
  	      ;;
      -1)
          zenity --error \
          --text="$text_error"
          exit;
  	      ;;
  esac
}
