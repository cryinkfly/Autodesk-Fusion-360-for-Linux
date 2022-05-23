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
function DL_WINEPREFIXES_GET_INFO {
  mkdir -p "/tmp/fusion360/logs"
  cp "$HOME/.fusion360/logs/wineprefixes.log" "/tmp/fusion360/logs"
  # All Wineprefixes from the .wineprefixes.log are loaded here. (Array)
  # So you'll have each line in ${var[1]}, ${var[2]} and so on.
  mapfile -t -O 1 var </tmp/fusion360/logs/wineprefixes.log
}

function DL_WINEPREFIXES_DELETE_CHECK {
  # ...
  
  # Delete the String
  sed --in-place '/some string here/d' /tmp/fusion360/logs/wineprefixes.log
}

# GUI where you can see all Wineprefixes (LOOP)
# ...
