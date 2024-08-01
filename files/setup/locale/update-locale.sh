#!/usr/bin/env bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you can update the Autodesk Fusion Installer Locale files.          #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2024                                                                          #
# Time/Date:    23:15/31.07.2024                                                                   #
# Version:      1.0.0                                                                              #
####################################################################################################

# Declare an associative array with language names and their locale codes
declare -A locales=(
    ["English"]='en_US'
    ["German - Deutsch"]='de_DE'
    ["Czech - Čeština"]='cs_CZ'
    ["French - Français"]='fr_FR'
    ["Italian - Italiano"]='it_IT'
    ["Japanese - 日本語"]='ja_JP'
    ["Korean - 한국인"]='ko_KR'
    ["Polish - Polski"]='pl_PL'
    ["Portuguese (Brazilian)"]='pt_BR'
    ["Simplified Chinese - 简体中文"]='zh_CN'
    ["Spanish - Español"]='es_ES'
    ["Traditional Chinese - 中國人"]='zh_TW'
    ["Turkish - Türkçe"]='tr_TR'
)

# Loop through each locale and update the .mo file from the .po file
for lang in "${!locales[@]}"; do
    locale=${locales[$lang]}
    po_file="locale/${locale}/LC_MESSAGES/autodesk_fusion.po"
    mo_file="locale/${locale}/LC_MESSAGES/autodesk_fusion.mo"
    
    # Check if the .po file exists
    if [[ -f "$po_file" ]]; then
        echo "Updating $mo_file from $po_file"
        msgfmt -o "$mo_file" "$po_file"
    else
        echo "Warning: $po_file does not exist. Skipping $lang."
    fi
done

echo "Update completed."

