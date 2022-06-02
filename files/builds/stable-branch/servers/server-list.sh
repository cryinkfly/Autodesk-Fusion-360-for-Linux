#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Server List for the Setup Wizard (Linux)                     #
# Description:  With this file get the Setup Wizard all servers.                                   #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    08:35/06.05.2022                                                                   #
# Version:      x.x.x -> 0.0.1                                                                     #
####################################################################################################

# Path: /$HOME/.fusion360/servers/server-list.sh

###############################################################################################################################################################

# LANGUAGE FILES:

SP_SERVER_1="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/locale.sh"

SP_SERVER_1_1="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/cs-CZ/locale-cs.sh"
SP_SERVER_1_2="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/cs-CZ/license-cs.txt"
SP_SERVER_1_3="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/cs-CZ/extensions-cs.txt"

SP_SERVER_2_1="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/de-DE/locale-de.sh"
SP_SERVER_2_2="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/de-DE/license-de.txt"
SP_SERVER_2_3="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/de-DE/extensions-de.txt"

SP_SERVER_3_1="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/en-US/locale-en.sh"
SP_SERVER_3_2="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/en-US/license-en.txt"
SP_SERVER_3_3="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/en-US/extensions-en.txt"

SP_SERVER_4_1="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/es-ES/locale-es.sh"
SP_SERVER_4_2="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/es-ES/license-es.txt"
SP_SERVER_4_3="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/es-ES/extensions-es.txt"

SP_SERVER_5_1="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/fr-FR/locale-fr.sh"
SP_SERVER_5_2="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/fr-FR/license-fr.txt"
SP_SERVER_5_3="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/fr-FR/license-fr.txt"

SP_SERVER_6_1="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/it-IT/locale-it.sh"
SP_SERVER_6_2="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/it-IT/license-it.txt"
SP_SERVER_6_3="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/it-IT/extensions-it.txt"

SP_SERVER_7_1="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/ja-JP/locale-ja.sh"
SP_SERVER_7_2="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/ja-JP/license-ja.txt"
SP_SERVER_7_3="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/ja-JP/extensions-ja.txt"

SP_SERVER_8_1="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/ko-KR/locale-ko.sh"
SP_SERVER_8_2="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/ko-KR/license-ko.txt"
SP_SERVER_8_2="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/ko-KR/extensions-ko.txt"

SP_SERVER_9_1="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/zh-CN/locale-zh.sh"
SP_SERVER_9_2="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/zh-CN/license-zh.txt"
SP_SERVER_9_3="https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/zh-CN/extensions-zh.txt"

###############################################################################################################################################################

# WINETRICKS:

SP_SERVER_20="https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"

###############################################################################################################################################################

# AUTODESK FUSION 360 INSTALLER:

SP_SERVER_21="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe"

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
