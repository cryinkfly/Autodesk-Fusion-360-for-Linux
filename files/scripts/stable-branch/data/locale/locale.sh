#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you get all languages for the Setup Wizard.                         #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2021                                                                          #
# Time/Date:    10:00/20.10.2021                                                                   #
# Version:      1.0                                                                                #
####################################################################################################

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# Load & Save the locale files into the folders!

function load-locale-languages {
  wget -P -N /cs-CZ/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/cs-CZ/locale-cs.sh
  chmod +x ../cs-CZ/locale-cs.sh
  wget -P -N /de-DE/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/de-DE/locale-de.sh
  chmod +x ../de-DE/locale-de.sh
  wget -P -N /en-US/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/en-US/locale-en.sh
  chmod +x ../en-US/locale-en.sh
  wget -P -N /es-ES/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/es-ES/locale-es.sh
  chmod +x ../es-ES/locale-es.sh
  wget -P -N /fr-FR/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/fr-FR/locale-fr.sh
  chmod +x ../fr-FR/locale-fr.sh
  wget -P -N /it-IT/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/it-IT/locale-it.sh
  chmod +x ../it-IT/locale-it.sh
  wget -P -N /ja-JP/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/ja-JP/locale-ja.sh
  chmod +x ../ja-JP/locale-ja.sh
  wget -P -N /ko-KR/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/ko-KR/locale-ko.sh
  chmod +x ../ko-KR/locale-ko.sh
  wget -P -N /zh-CN/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/zh-CN/locale-zh.sh
  chmod +x ../zh-CN/locale-zh.sh
}

##############################################################################

# Load & Save the licenses into the folders!

function load-locale-licenses {
  wget -P -N /cs-CZ/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/cs-CZ/license-cs
  wget -P -N /de-DE/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/de-DE/license-de
  wget -P -N /en-US/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/en-US/license-en
  wget -P -N /es-ES/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/es-ES/license-es
  wget -P -N /fr-FR/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/fr-FR/license-fr
  wget -P -N /it-IT/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/it-IT/license-it
  wget -P -N /ja-JP/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/ja-JP/license-ja
  wget -P -N /ko-KR/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/ko-KR/license-ko
  wget -P -N /zh-CN/ https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/scripts/stable-branch/data/locale/zh-CN/license-zh
}

##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

load-locale-languages
load-locale-licenses
