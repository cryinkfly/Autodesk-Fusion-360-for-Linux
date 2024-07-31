#!/usr/bin/env bash

#############################################################################
# Name:         Autodesk Fusion 360 - Launcher (Linux)                      #
# Description:  With this file you run Autodesk Fusion 360 on your system.  #
# Author:       Steve Zabka                                                 #
# Author URI:   https://cryinkfly.com                                       #
# License:      MIT                                                         #
# Copyright (c) 2020-2024                                                   #
# Time/Date:    22:50/31.07.2024                                            #
# Version:      1.9.3                                                       #
#############################################################################

# Path: SELECTED__INSTALLATION_PATH/bin/autodesk_fusion_launcher.sh

#################################
# Open Autodesk Fusion 360 now! #
#################################

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# Check in which directory the autodesk_fusion_launcher.sh file is located.
echo "The current working directory is: $PWD"
launcher_root_path=$(cd .. && echo "$PWD")
wineprefix_log_file=$launcher_root_path/logs/wineprefixes.log

# Line 2
wineprefix=$(awk 'NR == 2' "$wineprefix_log_file")

# This feature will check if there is a new version of Autodesk Fusion 360.
function check_autodesk_fusion_online_versions {
  curl -o ../logs/version.txt -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/build-version.txt
  online_build_version=$(awk 'NR == 1' ../logs/version.txt)
  online_insider_build_version=$(awk 'NR == 2' ../logs/version.txt)
  echo "Online Build-Version: $online_build_version"
  echo "Online Insider-Build-Version: $online_insider_build_version"
}

function check_version_file {
  # Find the newest version.txt file from the Autodesk Fusion 360 installation.
  autodesk_fusion_api_version=$(find "$wineprefix" -name version.txt -printf "%T+ %p\n" | sort -r 2>&1 | head -n 1 | sed -r 's/.+0000000000 (.+)/\1/')
  if [ -f "$autodesk_fusion_api_version" ]; then
    echo "The version.txt file exists!"
    check_versions
  else
    echo "The version.txt file does not exist!"
    run_autodesk_fusion
  fi
}

function check_versions {
  # Get the string from the version.txt file from FUSION360_API_VERSION
  system_build_version=$(awk 'NR == 1' "$autodesk_fusion_api_version")
  echo "System Build-Version: $system_build_version"
  if [ "$online_build_version" = "$system_build_version" ] || [ "$online_insider_build_version" = "$system_build_version" ]; then
    echo "Do nothing!"
    run_autodesk_fusion
  else
    backup_old_version
    update
  fi
}

function backup_old_version {
  # Backup the old version of the Autodesk Fusion 360
  echo "Backup the old version of the Autodesk Fusion 360!"
  # Copy $wineprefix to $wineprefix-backup-$SYSTEM_BUILD_VERSION
  cp -r "$wineprefix" "$wineprefix-backup-$system_build_version"
}

function update {
  echo "Update the Autodesk Fusion 360 version!"
  # Download the newest version of the Autodesk Fusion 360
  fusion360_installer="$launcher_root_path/downloads/Fusion360installer.exe"
  fusion360_installer_url="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Client%20Downloader.exe"
  curl -L "$fusion360_installer_url" -o Fusion360installer.exe
  rm -rf "$fusion360_installer"
  mv -f Fusion360installer.exe "$fusion360_installer"
  cp "Fusion360installer.exe" "$wineprefix/drive_c/users/$USER/Downloads/Fusion360installer.exe"
  # Install the newest version of the Autodesk Fusion 360
  WINEPREFIX="$wineprefix" timeout -k 2m 1m wine "$wineprefix/drive_c/users/$USER/Downloads/Fusion360installer.exe" --quiet
  WINEPREFIX="$wineprefix" timeout -k 2m 1m wine "$wineprefix/drive_c/users/$USER/Downloads/Fusion360installer.exe" --quiet
  run_autodesk_fusion
}

# You must change the first part ($HOME/.wineprefixes/fusion360) and the last part (WINEPREFIX="$HOME/.wineprefixes/fusion360") when you have installed Autodesk Fusion 360 into another directory!
function run_autodesk_fusion {
  launcher="$(find "$wineprefix" -name Fusion360.exe -printf "%T+ %p\n" | sort -r 2>&1 | head -n 1 | sed -r 's/.+0000000000 (.+)/\1/')" && echo $launcher && WINEPREFIX="$wineprefix" wine "$launcher"
  # WINEDEBUG=-all = Logs everything, probably gives too much information in most cases, but may come in handy for subtle issues
  # WINEDEBUG=-d3d = Will turn off all d3d messages, and additionally disable checking for GL errors after operations. This may improve performance.
}

###############################################################################################################################################################
# THE PROGRAM IS STARTED HERE:                                                                                                                                #
###############################################################################################################################################################

check_autodesk_fusion_online_versions
check_versions
