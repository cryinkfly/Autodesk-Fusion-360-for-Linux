#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you get all languages for the Setup Wizard.                         #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    16:00/13.09.2022                                                                   #
# Version:      1.5.1                                                                              #
####################################################################################################

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

declare -rA _LOCALES=(
  [cs]="CZ"
  [de]="DE"
  [en]="US"
  [es]="ES"
  [fr]="FR"
  [it]="IT"
  [ja]="JP"
  [ko]="KR"
  [zh]="CN"
)

# Load & Save the locale files into the folders (asynchronously)!
# Use the `wait` keyword after to block until completed.
function load-locale-languages {
  for lang in "${!_LOCALES[@]}"
  do
    country="${_LOCALES[$lang]}"

    (
      wget -N -P \
        "$SP_PATH/locale/$lang-$country" \
        "https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/$lang-$country/locale-$lang.sh" \
      && chmod +x "$SP_PATH/locale/$lang-$country/locale-$lang.sh"
    ) &
  done
}

###############################################################################################################################################################

# Load & Save the translations of the licenses into the folders asynchronously!
# Use the `wait` keyword after to block until completed.
function load-locale-licenses {
  for lang in "${!_LOCALES[@]}"
  do
    country="${_LOCALES[$lang]}"

    wget -N -P \
      "$SP_PATH/locale/$lang-$country" \
      "https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/$lang-$country/license-$lang.txt" \
    &
  done
}

###############################################################################################################################################################

# Load & Save the translations of the extensions into the folders
# asynchronously! Use the `wait` keyword after to block until completed.
function load-locale-extensions {
  for lang in "${!_LOCALES[@]}"
  do
    country="${_LOCALES[$lang]}"

    wget -N -P \
      "$SP_PATH/locale/$lang-$country" \
      "https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/$lang-$country/extensions-$lang.txt" \
    &
  done
}

###############################################################################################################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:                                                                                                                   #
###############################################################################################################################################################

load-locale-languages
load-locale-licenses
load-locale-extensions
wait
