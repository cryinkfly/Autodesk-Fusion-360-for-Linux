#!/bin/bash

################################################################################
# Name:         Autodesk Fusion 360 - Uninstall the software (Linux)           #
# Description:  With this file you delete Autodesk Fusion 360 on your system.  #
# Author:       Steve Zabka                                                    #
# Author URI:   https://cryinkfly.com                                          #
# License:      MIT                                                            #
# Copyright (c) 2020-2022                                                      #
# Time/Date:    07:30/23.05.2022                                               #
# Version:      0.7 -> 0.8                                                     #
################################################################################

# Path: /$HOME/.fusion360/bin/uninstall.sh

###############################################################################################################################################################
# THE INITIALIZATION OF DEPENDENCIES STARTS HERE:                                                                                                             #
###############################################################################################################################################################

# Get a file where the user can see the exits Wineprefixes of Autodesk Fusion 360 on the system.

function DL_WINEPREFIXES_LIST {
  DL_WINEPREFIXES=$(yad --height=300 --list --checklist --column=SELECT --column=WINEPREFIXES < /tmp/fusion360/logs/wineprefixes.log)
  DL_WINEPREFIXES_VAR_1=`grep -n "$DL_WINEPREFIXES" /tmp/fusion360/logs/wineprefixes.log | grep -Eo '^[^:]+'`
  DL_WINEPREFIXES_VAR_2=1
  DL_WINEPREFIXES_VAR_SUM=`echo $(( var1 - var2 ))`
  # Get info if the user is sure with there choise ...
  
  
  sed --in-place "${DL_WINEPREFIXES_VAR_SUM}d" /tmp/fusion360/logs/wineprefixes.log
  DL_WINEPREFIXES_VAR_1=`grep -n "$DL_WINEPREFIXES" /tmp/fusion360/logs/wineprefixes.log | grep -Eo '^[^:]+'`
  sed --in-place "${DL_WINEPREFIXES_VAR_1}d" /tmp/fusion360/logs/wineprefixes.log
  # Continue with removing ...
  rmdir $DL_WINEPREFIXES
  # Check if there another Wineprefixes ...
  # if then
  # rmdir $HOME/.fusion360
  # else nothing
  # ...
}
