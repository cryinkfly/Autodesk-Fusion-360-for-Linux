#!/bin/bash

#############################################################################
# Name:         Autodesk Fusion 360 - Launcher (Linux)                      #
# Description:  With this file you run Autodesk Fusion 360 on your system.  #
# Author:       Steve Zabka                                                 #
# Author URI:   https://cryinkfly.com                                       #
# License:      MIT                                                         #
# Copyright (c) 2020-2021                                                   #
# Time/Date:    10:00/09.11.2021                                            #
# Version:      1.0                                                         #
#############################################################################

#################################
# Open Autodesk Fusion 360 now! #
#################################

function fusion360-starter {

# You must change the first part ($HOME/.wineprefixes/fusion360) and the last part (WINEPREFIX="$HOME/.wineprefixes/fusion360") when you have installed Autodesk Fusion 360 into another directory!
launcher="$(find $HOME/.local/share/flatpak-wine619 -name Fusion360.exe -printf "%T+ %p" | sort -r 2>&1 | head -n 1 | sed -r 's/.+0000000000 (.+)/\1/')" && flatpak run org.winehq.flatpak-wine619 bash && wine "$launcher"

}

fusion360-starter
