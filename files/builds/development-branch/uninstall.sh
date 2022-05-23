#!/bin/bash

################################################################################
# Name:         Autodesk Fusion 360 - Uninstall the software (Linux)           #
# Description:  With this file you delete Autodesk Fusion 360 on your system.  #
# Author:       Steve Zabka                                                    #
# Author URI:   https://cryinkfly.com                                          #
# License:      MIT                                                            #
# Copyright (c) 2020-2022                                                      #
# Time/Date:    07:00/23.05.2022                                               #
# Version:      0.7 -> 0.8                                                     #
################################################################################

# Path: /$HOME/.fusion360/bin/uninstall.sh

###############################################################################################################################################################
# THE INITIALIZATION OF DEPENDENCIES STARTS HERE:                                                                                                             #
###############################################################################################################################################################

# Get a file where the user can see the exits Wineprefixes of Autodesk Fusion 360 on the system.
function DL_WINEPREFIXES_GET_INFO {
  mkdir -p "/tmp/fusion360/logs"
  cp "$HOME/.fusion360/logs/wineprefixes.log" "/tmp/fusion360/logs"
  DL_WINEPREFIXES_INFO=`cat /tmp/fusion360/logs/wineprefixes.log | awk 'NR == 1'`
}
