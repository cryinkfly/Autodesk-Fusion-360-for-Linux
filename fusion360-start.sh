#!/bin/bash

# Name:         Autodesk Fusion 360 - Start-Script (Linux)
# Description:  With this file you can run Autodesk Fusion 360 on your system.
# Author:       Steve Zabka
# Author URI:   https://cryinkfly.de
# Time/Date:    06:00/15.05.2021
# Version:      0.2

# 1. Step: Open a Terminal and run this command: cd Downloads && chmod +x fusion360-start.sh && sh fusion360-start.sh
# 2. Step: Now you can run Autodesk Fusion 360 with this file in the future.

env WINEPREFIX="/$HOME/.fusion360" wine C:\\windows\\command\\start.exe /Unix /$HOME/.fusion360/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk
