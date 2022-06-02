#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Server List for the Setup Wizard (Linux)                     #
# Description:  With this file get the Setup Wizard all servers.                                   #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    018:15/02.06.2022                                                                   #
# Version:      x.x.x -> 0.0.1                                                                     #
####################################################################################################

# Path: /$HOME/.fusion360/servers/server-list.sh

###############################################################################################################################################################

# LANGUAGE FILES:

SP_SERVER_LOCALE="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/locale.sh"

###############################################################################################################################################################

# WINETRICKS:

SP_SERVER_WINETRICKS="https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"

###############################################################################################################################################################

# AUTODESK FUSION 360 INSTALLER:

SP_SERVER_FUSION360_INSTALLER="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe"

###############################################################################################################################################################

# DXVK AND OPENGL:

SP_SERVER_22="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/driver/video/dxvk/DXVK.reg"
SP_SERVER_23="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/driver/video/dxvk/DXVK.xml"
SP_SERVER_24="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/driver/video/opengl/OpenGL.xml"

###############################################################################################################################################################

# ICONS:

SP_SERVER_25="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/fusion360.svg"
SP_SERVER_26="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/fusion360-uninstall.svg"

###############################################################################################################################################################

# EXTRA SCRIPTS:

SP_SERVER_27="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/uninstall.sh"
SP_SERVER_28="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/launcher.sh"
SP_SERVER_29="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/update.sh"
SP_SERVER_30="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/read-text.sh"

###############################################################################################################################################################

# EXTENSIONS:

SP_SERVER_31="https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/files/extensions/AirfoilTools_win64.msi"
SP_SERVER_32="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/AdditiveAssistant.bundle-win64.msi"
SP_SERVER_33="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/HP_3DPrinters_for_Fusion360-win64.msi"
SP_SERVER_34="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/HelicalGear_win64.msi"
SP_SERVER_35="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/OctoPrint_for_Fusion360-win64.msi"
SP_SERVER_36="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/ParameterIO_win64.msi"
SP_SERVER_37="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/RoboDK.bundle-win64.msi"
SP_SERVER_38="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/Ultimaker_Digital_Factory-win64.msi"

###############################################################################################################################################################
