#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you get all languages for the Setup Wizard.                         #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    18:15/02.06.2022                                                                   #
# Version:      1.1 -> 1.2                                                                         #
####################################################################################################

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# Load & Save the locale files into the folders!
function load-locale-languages {
  wget -N -P $HOME/.config/fusion-360/locale/cs-CZ/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/cs-CZ/locale-cs.sh
  chmod +x $HOME/.config/fusion-360/locale/cs-CZ/locale-cs.sh
  wget -N -P $HOME/.config/fusion-360/locale/de-DE/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/de-DE/locale-de.sh
  chmod +x $HOME/.config/fusion-360/locale/de-DE/locale-de.sh
  wget -N -P $HOME/.config/fusion-360/locale/en-US/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/en-US/locale-en.sh
  chmod +x $HOME/.config/fusion-360/locale/en-US/locale-en.sh
  wget -N -P $HOME/.config/fusion-360/locale/es-ES/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/es-ES/locale-es.sh
  chmod +x $HOME/.config/fusion-360/locale/es-ES/locale-es.sh
  wget -N -P $HOME/.config/fusion-360/locale/fr-FR/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/fr-FR/locale-fr.sh
  chmod +x $HOME/.config/fusion-360/locale/fr-FR/locale-fr.sh
  wget -N -P $HOME/.config/fusion-360/locale/it-IT/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/it-IT/locale-it.sh
  chmod +x $HOME/.config/fusion-360/locale/it-IT/locale-it.sh
  wget -N -P $HOME/.config/fusion-360/locale/ja-JP/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/ja-JP/locale-ja.sh
  chmod +x $HOME/.config/fusion-360/locale/ja-JP/locale-ja.sh
  wget -N -P $HOME/.config/fusion-360/locale/ko-KR/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/ko-KR/locale-ko.sh
  chmod +x $HOME/.config/fusion-360/locale/ko-KR/locale-ko.sh
  wget -N -P $HOME/.config/fusion-360/locale/zh-CN/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/zh-CN/locale-zh.sh
  chmod +x $HOME/.config/fusion-360/locale/zh-CN/locale-zh.sh
}

###############################################################################################################################################################

# Load & Save the licenses into the folders!
function load-locale-licenses {
  wget -N -P $HOME/.config/fusion-360/locale/cs-CZ/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/cs-CZ/license-cs.txt
  wget -N -P $HOME/.config/fusion-360/locale/de-DE/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/de-DE/license-de.txt
  wget -N -P $HOME/.config/fusion-360/locale/en-US/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/en-US/license-en.txt
  wget -N -P $HOME/.config/fusion-360/locale/es-ES/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/es-ES/license-es.txt
  wget -N -P $HOME/.config/fusion-360/locale/fr-FR/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/fr-FR/license-fr.txt
  wget -N -P $HOME/.config/fusion-360/locale/it-IT/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/it-IT/license-it.txt
  wget -N -P $HOME/.config/fusion-360/locale/ja-JP/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/ja-JP/license-ja.txt
  wget -N -P $HOME/.config/fusion-360/locale/ko-KR/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/ko-KR/license-ko.txt
  wget -N -P $HOME/.config/fusion-360/locale/zh-CN/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/zh-CN/license-zh.txt
}

###############################################################################################################################################################

# Load & Save the licenses into the folders!
function load-locale-extensions {
  wget -N -P $HOME/.config/fusion-360/locale/cs-CZ/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/cs-CZ/extensions-cs.txt
  wget -N -P $HOME/.config/fusion-360/locale/de-DE/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/de-DE/extensions-de.txt
  wget -N -P $HOME/.config/fusion-360/locale/en-US/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/en-US/extensions-en.txt
  wget -N -P $HOME/.config/fusion-360/locale/es-ES/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/es-ES/extensions-es.txt
  wget -N -P $HOME/.config/fusion-360/locale/fr-FR/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/fr-FR/extensions-fr.txt
  wget -N -P $HOME/.config/fusion-360/locale/it-IT/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/it-IT/extensions-it.txt
  wget -N -P $HOME/.config/fusion-360/locale/ja-JP/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/ja-JP/extensions-ja.txt
  wget -N -P $HOME/.config/fusion-360/locale/ko-KR/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/ko-KR/extensions-ko.txt
  wget -N -P $HOME/.config/fusion-360/locale/zh-CN/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/zh-CN/extensions-zh.txt
}

###############################################################################################################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:                                                                                                                   #
###############################################################################################################################################################

load-locale-languages
load-locale-licenses
load-locale-extensions

