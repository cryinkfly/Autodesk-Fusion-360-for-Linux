#!/bin/bash

# Name:         Autodesk Fusion 360 - Start-Script - Flatpak (Linux)
# Description:  With this file you can run Autodesk Fusion 360 on your system.
# Author:       Steve Zabka
# Author URI:   https://cryinkfly.de
# Time/Date:    11:00/16.05.2021
# Version:      0.1

# 1. Step: Open a Terminal and run this command: cd Downloads && chmod +x fusion360-flatpak-start.sh && sh fusion360-flatpak-start.sh
# 2. Step: Now you can run Autodesk Fusion 360 with this file in the future.

flatpak run org.winehq.flatpak-proton-68-ge-1 bash &&
wine /$HOME/.local/share/flatpak-proton-68-ge-1/default/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk
