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

# Winetricks - Custom

function install-winetricks-custom {
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
   wget -P $HOME/.local/share/applications/wine/Programs/Autodesk https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/files/Autodesk%20Fusion%20360.desktop
   wget https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/launcher.sh -O Fusion360launcher
   mv Fusion360launcher data/resources/fusion360-installer/Fusion360launcher
   desktop-launcher-custom
   logfile-installation-custom
   . data/resources/extensions/extensions-custom.sh
   program-exit
}

##############################################################################
# ALL DIALOGS ARE ARRANGED HERE:
##############################################################################

function desktop-launcher-custom {
  file=`dirname $0`/data/resources/fusion360-installer/Fusion360launcher
  launcher=`zenity --text-info \
         --title="$program_name" \
         --width=700 \
         --height=500 \
         --filename=$file \
         --editable \
         --checkbox="$text_desktop_launcher_custom_checkbox"`

  case $? in
      0)
          zenity --question \
                 --title="$program_name" \
                 --text="$text_desktop_launcher_custom_question" \
                 --width=400 \
                 --height=100
          answer=$?

          if [ "$answer" -eq 0 ]; then
              echo "$launcher" > $file
              mv $file "$HOME/.local/share/fusion360/launcher.sh"
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


##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

install-winetricks-custom
