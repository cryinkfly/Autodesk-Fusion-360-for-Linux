#!/usr/bin/env bash

#############################################################################
# Name:         Autodesk Fusion 360 - Download Installer Client (Linux)     #
# Description:  This file download all files for the installer client.      #
# Author:       Steve Zabka                                                 #
# Author URI:   https://cryinkfly.com                                       #
# License:      MIT                                                         #
# Copyright (c) 2020-2024                                                   #
# Time/Date:    21:15/01.08.2024                                            #
# Version:      2.0.0                                                       #
#############################################################################

mkdir -p autodesk_fusion_360_installer_client/{data,graphics,locale,logs,styles}
curl -o autodesk_fusion_360_installer_client/Fusion360-Linux-Installer-x86_64.py -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/Fusion360-Linux-Installer-x86_64.py
curl -o autodesk_fusion_360_installer_client/data/autodesk_fusion_installer.sh -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/data/autodesk_fusion_installer.sh
curl -o autodesk_fusion_360_installer_client/graphics/welcome.svg -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/resource/graphics/welcome.svg
curl -o autodesk_fusion_360_installer_client/styles/fusion360-dark.css -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/resource/styles/fusion360-dark.css
curl -o autodesk_fusion_360_installer_client/styles/fusion360-light.css -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/resource/styles/fusion360-light.css
for lang in cs_CZ de_DE en_US es_ES fr_FR it_IT ja_JP ko_KR pl_PL pt_BR tr_TR zh_CN zh_TW; do
    mkdir -p autodesk_fusion_360_installer_client/locale/$lang/LC_MESSAGES  
    # Download the .po files
    curl -o autodesk_fusion_360_installer_client/locale/$lang/LC_MESSAGES/autodesk_fusion.po -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/$lang/LC_MESSAGES/autodesk_fusion.po
done
curl -o autodesk_fusion_360_installer_client/locale/update-locale.sh -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/update-locale.sh
chmod +x autodesk_fusion_360_installer_client/Fusion360-Linux-Installer-x86_64.py
chmod +x autodesk_fusion_360_installer_client/locale/update-locale.sh
chmod +x autodesk_fusion_360_installer_client/data/autodesk_fusion_installer.sh
echo "The Autodesk Fusion 360 installer client has been downloaded successfully!"
# Run update-locale.sh in an extra terminal to update the locale files and close the terminal after the update
cd autodesk_fusion_360_installer_client
source ./locale/update-locale.sh

# Run python3 Fusion360-Linux-Installer-x86_64.py from this bash script
python3 Fusion360-Linux-Installer-x86_64.py
