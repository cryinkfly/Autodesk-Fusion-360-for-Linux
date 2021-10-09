#!/bin/bash

#############################################################################
# Name:         Autodesk Fusion 360 - Launcher (Linux)                      #
# Description:  With this file you run Autodesk Fusion 360 on your system.  #
# Author:       Steve Zabka                                                 #
# Author URI:   https://cryinkfly.com                                       #
# License:      MIT                                                         #
# Copyright (c) 2020-2021                                                   #
# Time/Date:    20:00/09.10.2021                                            #
# Version:      1.0                                                         #
#############################################################################

#################################
# Open Autodesk Fusion 360 now! #
#################################

function fusion360-starter {

launcher="$(find $HOME/.wineprefixes/fusion360 -name Fusion360.exe -printf "%T+ %p" | sort -r 2>&1 | head -n 1 | sed -r 's/.+0000000000 (.+)/\1/')" && WINEPREFIX="$HOME/.wineprefixes/fusion360" wine "$launcher"

}

fusion360-starter
