#!/usr/bin/env bash

#############################################################################
# Name:         Autodesk Fusion 360 - Launcher (Linux)                      #
# Description:  With this file you run Autodesk Fusion 360 on your system.  #
# Author:       Steve Zabka                                                 #
# Author URI:   https://cryinkfly.com                                       #
# License:      MIT                                                         #
# Copyright (c) 2020-2024                                                   #
# Time/Date:    22:00/05.08.2024                                            #
# Version:      2.0.0-Alpha                                                 #
#############################################################################

# Path: SELECTED__INSTALLATION_PATH/bin/autodesk_fusion_launcher.sh

#################################
# Open Autodesk Fusion 360 now! #
#################################

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# Check in which directory the autodesk_fusion_launcher.sh file is located.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Make AUTODESK_ROOT_DIRECTORY absolute (one level up from the script dir)
AUTODESK_ROOT_DIRECTORY="$(cd "$SCRIPT_DIR/.." && pwd)"
WINEPREFIX_LOG_FILE="$AUTODESK_ROOT_DIRECTORY/logs/wineprefixes.log"
if [ ! -f "$WINEPREFIX_LOG_FILE" ]; then
    echo "wineprefixes.log not found at $WINEPREFIX_LOG_FILE. Exiting..."
    exit 1
fi
LOG_AUTODESK_ROOT_DIRECTORY=$(awk 'NR == 2' "$WINEPREFIX_LOG_FILE")
if [ "$AUTODESK_ROOT_DIRECTORY" != "$LOG_AUTODESK_ROOT_DIRECTORY" ]; then
    echo "Error: AUTODESK_ROOT_DIRECTORY does not match wineprefixes.log (line 2). Exiting..."
    exit 1
fi
WINEPREFIX_DIRECTORY=$(awk 'NR == 3' "$WINEPREFIX_LOG_FILE")
PROTON_VERSION=$(awk 'NR == 4' "$WINEPREFIX_LOG_FILE")

# This feature will check if there is a new version of Autodesk Fusion 360.
function check_autodesk_fusion_online_versions() {
    curl -o "$AUTODESK_ROOT_DIRECTORY/logs/version.txt" -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/build-version.txt
    ONLINE_BUILD_VERSION=$(awk 'NR == 1' "$AUTODESK_ROOT_DIRECTORY/logs/version.txt")
    ONLINE_INSIDER_BUILD_VERSION=$(awk 'NR == 2' "$AUTODESK_ROOT_DIRECTORY/logs/version.txt")
    echo "Online Build-Version: $ONLINE_BUILD_VERSION"
    echo "Online Insider-Build-Version: $ONLINE_INSIDER_BUILD_VERSION"
    #check_versions #Update function not work correctly at the moment!!!
    run_autodesk_fusion
}

function check_version_file() {
    # Find the newest version.txt file from the Autodesk Fusion 360 installation.
    AUTODESK_FUSION_API_VERSION=$(find "$WINEPREFIX_DIRECTORY" -name fusion_version.txt -printf "%T+ %p\n" | sort -r 2>&1 | head -n 1 | sed -r 's/.+0000000000 (.+)/\1/')
    if [ -f "$AUTODESK_FUSION_API_VERSION" ]; then
        echo "The version.txt file exists!"
        check_versions
    else
        echo "The version.txt file does not exist!"
        run_autodesk_fusion
    fi
}

function check_versions() {
    # Get the string from the version.txt file from FUSION360_API_VERSION
    SYSTEM_BUILD_VERSION=$(cat "$AUTODESK_FUSION_API_VERSION")
    echo "System Build-Version: $SYSTEM_BUILD_VERSION"
    if [ "$ONLINE_BUILD_VERSION" = "$SYSTEM_BUILD_VERSION" ] || [ "$ONLINE_INSIDER_BUILD_VERSION" = "$SYSTEM_BUILD_VERSION" ]; then
        echo "Do nothing!"
        run_autodesk_fusion
    else
        backup_old_version
        update
    fi
}

function backup_old_version() {
    # Backup the old version of the Autodesk Fusion 360
    echo "Backup the old version of the Autodesk Fusion 360!"
    # Copy $wineprefix to $wineprefix-backup-$SYSTEM_BUILD_VERSION
    cp -r "$WINEPREFIX_DIRECTORY" "$WINEPREFIX_DIRECTORY-backup-$SYSTEM_BUILD_VERSION"
}

function update() {
    echo "Update the Autodesk Fusion 360 version!"
    # Download the newest version of the Autodesk Fusion 360
    AUTODESK_FUSION_INSTALLER="$AUTODESK_ROOT_DIRECTORY/downloads/Fusion360ClientInstaller.exe"
    fusion360_installer_url="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Client%20Downloader.exe"
    curl -L "$fusion360_installer_url" -o $AUTODESK_FUSION_INSTALLER
    cp "$AUTODESK_ROOT_DIRECTORY/downloads/Fusion360ClientInstaller.exe" "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Downloads"
    # Install the newest version of the Autodesk Fusion 360
    WINEPREFIX="$WINEPREFIX_DIRECTORY" timeout -k 2m 1m wine "$WINEPREFIX_DIRECTORY/drive_c/users/$USER/Downloads/Fusion360installer.exe" --quiet
    WINEPREFIX="$WINEPREFIX_DIRECTORY" timeout -k 2m 1m wine "$WINEPREFIX_DIRECTORY/drive_c/users/$USER/Downloads/Fusion360installer.exe" --quiet
    run_autodesk_fusion
}

function run_autodesk_fusion() {
    if [ "$PROTON_VERSION" == "Wine"]; then
        run_autodesk_fusion_wine
    else
        run_autodesk_fusion_proton
    fi
}
# You must change the first part ($HOME/.wineprefixes/fusion360) and the last part (WINEPREFIX="$HOME/.wineprefixes/fusion360") when you have installed Autodesk Fusion 360 into another directory!
function run_autodesk_fusion_wine() {
    LAUNCHER="$(find "$WINEPREFIX_DIRECTORY" -name Fusion360.exe -printf "%T+ %p\n" | sort -r 2>&1 | head -n 1 | cut -d' ' -f2-)"
    echo $LAUNCHER && WINEPREFIX="$WINEPREFIX_DIRECTORY" WINEDEBUG=-all WINEDEBUG=-d3d wine "$LAUNCHER"
    # WINEDEBUG=-all = Logs everything, probably gives too much information in most cases, but may come in handy for subtle issues
    # WINEDEBUG=-d3d = Will turn off all d3d messages, and additionally disable checking for GL errors after operations. This may improve performance.
}

function run_autodesk_fusion_proton() {
    LAUNCHER="$(find "$WINEPREFIX_DIRECTORY" -name Fusion360.exe -printf "%T+ %p\n" | sort -r 2>&1 | head -n 1 | cut -d' ' -f2-)"
    #LAUNCHER_WIN=$(echo "$LAUNCHER" | sed "s|$PROTONPREFIX_DIRECTORY/pfx/drive_c|C:|" | sed 's|/|\\|g')
    STEAM_DIRECTORY="$HOME/.local/share/Steam"
    PROTON_DIRECTORY="$STEAM_DIRECTORY/compatibilitytools.d/$PROTON_VERSION"
    
    if ! pgrep -x steam >/dev/null 2>&1; then
        echo -e "$(gettext "${YELLOW}Starting Steam...${NOCOLOR}")"
        steam &>/dev/null &
        sleep 5
    fi

    echo $LAUNCHER && STEAM_COMPAT_CLIENT_INSTALL_PATH="$STEAM_DIRECTORY" STEAM_COMPAT_DATA_PATH="$WINEPREFIX_DIRECTORY" "$PROTON_DIRECTORY/proton" run "$LAUNCHER"
}

###############################################################################################################################################################
# THE PROGRAM IS STARTED HERE:                                                                                                                                #
###############################################################################################################################################################

check_autodesk_fusion_online_versions
