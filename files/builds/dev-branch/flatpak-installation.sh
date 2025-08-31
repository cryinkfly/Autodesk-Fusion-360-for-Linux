#!/usr/bin/env bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux / Flatpak)                               #
# Description:  This script installs Autodesk Fusion 360 inside a Flatpak Wine runtime on Linux.   #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2025                                                                          #
# Time/Date:    10:15/31.08.2025                                                                   #
# Version:      1.0.3-Alpha                                                                        #
####################################################################################################
# Notes:
#   - All commands and procedures are derived from my previous scripts and have been
#     specifically adapted for execution within a Flatpak Wine environment.
#   - Sets up Wine prefix, required libraries via winetricks, WebView2 runtime, DLL overrides,
#     and handles Autodesk installer execution with appropriate timeouts.
#   - Designed for a double-sandbox environment (Flatpak + Wine sandbox).
#   - EXE files must be placed inside the Wine prefix, as Wine cannot access $HOME directly.
####################################################################################################

# CONFIGURATION OF THE COLOR SCHEME:
RED=$'\033[0;31m'
YELLOW=$'\033[0;33m'
GREEN=$'\033[0;32m'
NOCOLOR=$'\033[0m'

###############################################################################################################################################################

# URL's to download Fusion360Installer.exe files
#AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe" <-- Old Link!!!
AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Admin%20Install.exe"
#AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Client%20Downloader.exe"

# URL to download Microsoft Edge WebView2.Exec
WEBVIEW2_INSTALLER_URL="https://github.com/aedancullen/webview2-evergreen-standalone-installer-archive/releases/download/109.0.1518.78/MicrosoftEdgeWebView2RuntimeInstallerX64.exe"

# URL to download Firefox ESR
# The newer Firefox versions have some DLL bugs and that's why the ESR version is used.
FIREFOX_ESR_INSTALLER_URL="https://download.mozilla.org/?product=firefox-esr-latest-ssl&os=win64&lang=de"

# URL to download the patched Qt6WebEngineCore.dll file
# QT6_WEBENGINECORE_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/Qt6WebEngineCore.dll.7z" -> OLD Qt6WebEngineCore.dll
QT6_WEBENGINECORE_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/Qt6WebEngineCore-06-2025.7z"

# URL to download the patched siappdll.dll file
SIAPPDLL_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/siappdll.dll"

###############################################################################################################################################################

# Debian based systems:
# apt install p7zip-full cabextract winbind

###############################################################################################################################################################

flatpak install flathub org.winehq.Wine/x86_64/stable-24.08 -y # Issue solved: Similar refs found for ‘org.winehq.Wine’ in remote ‘flathub’ ...
flatpak update org.winehq.Wine -y # Upgrade to the Latest Version 

flatpak run org.winehq.Wine --version #Check version of wine

###############################################################################################################################################################

# Note: The winetricks "sandbox" verb only removes desktop integration (e.g. autostart entries, menu shortcuts) 
# and the Z: drive symlink that normally maps your entire home directory. 
# This is not a "true" security sandbox, but rather a safeguard against misbehavior — 
# for example, preventing games from saving settings into random subdirectories of $HOME.
#
# In this setup, however, Wine is already running inside a Flatpak sandbox. 
# When you additionally enable the winetricks sandbox mode, you effectively get a "double sandbox":
#
#   1. Flatpak already restricts Wine's access to your system and isolates it from the host.
#   2. Winetricks "sandbox" further removes the Z: drive mapping inside the Wine prefix.
#
# As a result, Wine in this configuration has no direct access to your $HOME directory 
# or the host filesystem outside the prefix. 
# Therefore, executable files (EXEs) must be placed directly inside the Wine prefix, 
# since Wine no longer has permissions to reach outside of that sandboxed environment.
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q sandbox

# Install required libraries
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q sandbox atmlib gdiplus arial corefonts cjkfonts dotnet452 msxml4 msxml6 vcrun2017 fontsmooth=rgb winhttp win10

# Install CJK fonts separately (only if the first run failed)
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q cjkfonts

# We must set to Windows 10 or 11 again because some other winetricks sometimes set it back to Windows XP!
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q win10

# Install DXVK for DirectX 9/11/...
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q dxvk

# Apply DLL overrides via registry for DirectX, ...
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "d3d10core" /t REG_SZ /d "native" /f
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "d3d11" /t REG_SZ /d "native" /f
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "d3d9" /t REG_SZ /d "builtin" /f
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "dxgi" /t REG_SZ /d "native" /f
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "adpclientservice.exe" /t REG_SZ /d "" /f # Remove tracking metrics/calling home
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "AdCefWebBrowser.exe" /t REG_SZ /d "builtin" /f
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "msvcp140" /t REG_SZ /d "native" /f
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "mfc140u" /t REG_SZ /d "native" /f
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "bcp47langs" /t REG_SZ /d "" /f

# Disable window decorations / Issue solved: Wine windows are incorrectly decorated by GTK/Wayland or X11
#flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\X11 Driver" /v Decorated /t REG_SZ /d N /f
#flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\X11 Driver" /v Managed /t REG_SZ /d N /f

###############################################################################################################################################################

# Download and install WebView2 to handle Login attempts, required even though we redirect to your default browser
curl -L "$WEBVIEW2_INSTALLER_URL" -o "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/MicrosoftEdgeWebView2RuntimeInstallerX64.exe"
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine $HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/MicrosoftEdgeWebView2RuntimeInstallerX64.exe /silent /install

# Pre-create shortcut directory for latest re-branding Microsoft Edge WebView2
mkdir -p "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/AppData/Roaming/Microsoft/Internet Explorer/Quick Launch/User Pinned/"

###############################################################################################################################################################

# Create mimetype link to handle web login call backs to the Identity Manager
cat > $HOME/.local/share/applications/adskidmgr-opener.desktop << EOL
[Desktop Entry]
Type=Application
Name=adskidmgr Scheme Handler
Exec=sh -c 'ADSK_EXE=$(find "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/" -name "AdskIdentityManager.exe" | head -1); flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine "$ADSK_EXE" "%u"'
StartupNotify=false
MimeType=x-scheme-handler/adskidmgr;
EOL

# Set the permissions for the .desktop file to read-only
chmod 444 $HOME/.local/share/applications/adskidmgr-opener.desktop
    
# Set the mimetype handler for the Identity Manager
xdg-mime default adskidmgr-opener.desktop x-scheme-handler/adskidmgr

###############################################################################################################################################################

# Download the Autodesk Fusion Installer
curl -L "$AUTODESK_FUSION_INSTALLER_URL" -o "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/Fusion360ClientInstaller.exe"

# --- First run of the installer: allow up to 10 minutes ---
timeout 600 flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine $HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/Fusion360ClientInstaller.exe --quiet || echo "First run timed out."

# Kill Wine to ensure clean state
flatpak kill org.winehq.Wine

# --- Second run of the installer: allow up to 1 minute ---
timeout 60 flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine $HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/Fusion360ClientInstaller.exe --quiet || echo "Second run timed out."

# Kill Wine to ensure clean state
flatpak kill org.winehq.Wine

###############################################################################################################################################################

# Find the Qt6WebEngineCore.dll file in the Autodesk Fusion directory
QT6_WEBENGINECORE=$(find "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" -name 'Qt6WebEngineCore.dll' -printf "%T+ %p\n" | sort -r | head -n 1 | sed -r 's/^[^ ]+ //')
QT6_WEBENGINECORE_DIR=$(dirname "$QT6_WEBENGINECORE")

# Download the patched Qt6WebEngineCore.dll
curl -L "$QT6_WEBENGINECORE_URL" -o "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/Qt6WebEngineCore.dll.7z"

# Old method required 7-Zip on the host system for extracting files.
#7za e -y "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/Qt6WebEngineCore.dll.7z" -o"$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/downloads/"

# Install 7-Zip inside the Wine prefix via winetricks.
# This method does NOT require 7-Zip on the host system and is more stable/reliable than previous approaches.
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q 7zip

# Excract the compressed Qt6WebEngineCore.dll.7z file
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine \
    "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/Program Files/7-Zip/7z.exe" x "C:\\users\\$USER\\Downloads\\Qt6WebEngineCore.dll.7z" -o"C:\\users\\$USER\\Downloads\\"

# Backup the original Qt6WebEngineCore.dll file of Autodesk Fusion
cp -f "$QT6_WEBENGINECORE_DIR/Qt6WebEngineCore.dll" "$QT6_WEBENGINECORE_DIR/Qt6WebEngineCore.dll.bak"

# Copy the patched Qt6WebEngineCore.dll file to the Autodesk Fusion directory
cp -f "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/Qt6WebEngineCore.dll" "$QT6_WEBENGINECORE_DIR/Qt6WebEngineCore.dll"

# Download the patched siappdll.dll file
curl -L "$SIAPPDLL_URL" -o "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/siappdll.dll"

# Backup the original siappdll.dll file of Autodesk Fusion
cp -f "$QT6_WEBENGINECORE_DIR/siappdll.dll" "$QT6_WEBENGINECORE_DIR/siappdll.dll.bak"

# Copy the patched siappdll.dll file to the Autodesk Fusion directory
cp -f "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/siappdll.dll" "$QT6_WEBENGINECORE_DIR/siappdll.dll"

###############################################################################################################################################################

# Continue ... Plugins, ...




###############################################################################################################################################################

# The FusionLauncher.exe.ini file is required in the latest production folder to start Autodesk Fusion.
# If it is missing, an error will occur. Copy this file from the oldest generated folder to the newest folder.

# For example:
#$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/Program Files/Autodesk/webdeploy/production/old-folder
#$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/Program Files/Autodesk/webdeploy/production/newer-folder

# Path to the production folders
PROD_DIR="$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/Program Files/Autodesk/webdeploy/production"

# List all production folders null-terminated, sort them, and write them to the array
mapfile -d '' FOLDERS < <(find "$PROD_DIR" -maxdepth 1 -mindepth 1 -type d -print0 | sort -z)

# Check if there are enough folders
if [ "${#FOLDERS[@]}" -lt 2 ]; then
    echo "Not enough production folders found."
    exit 1
fi

# Oldest folder = first item, newest folder = last item
OLD_FOLDER="${FOLDERS[0]}"
NEW_FOLDER="${FOLDERS[-1]}"

# Path to the .ini file
INI_FILE="$OLD_FOLDER/FusionLauncher.exe.ini"

# Check if the file exists
if [ ! -f "$INI_FILE" ]; then
    echo "FusionLauncher.exe.ini not found in $OLD_FOLDER"
    exit 1
fi

# Copy file
cp "$INI_FILE" "$NEW_FOLDER/"
echo "Copied FusionLauncher.exe.ini from $OLD_FOLDER to $NEW_FOLDER"

###############################################################################################################################################################

# Download the Firefox ESR Installer
curl -L "$FIREFOX_ESR_INSTALLER_URL" -o "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/FirefoxESRInstaller.exe"

# --- Run of the installer: allow up to 2 minutes ---
timeout 120 flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine $HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/FirefoxESRInstaller.exe /silent /install

# Change Registry: Set Firefox ESR as default browser in Wine Flatpak
timeout 60 flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Clients\\StartMenuInternet" /ve /d "Firefox" /f
timeout 60 flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Clients\\StartMenuInternet\\Firefox\\shell\\open\\command" /ve /d "\"$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/Program Files/Mozilla Firefox/firefox.exe\" \"%1\"" /f
   
# Optional: Check if Firefox is set correctly  
# Execute the query with a timeout and save the output
OUTPUT=$(timeout 60 flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg query "HKLM\\Software\\Clients\\StartMenuInternet")

# Display the output in a controlled manner
if [ $? -eq 124 ]; then
    echo "Command timed out after 60 seconds."
else
    echo "Registry query result:"
    echo "$OUTPUT"
fi

# HTTP & HTTPS - When the user click on login in Autodesk Fusion > open the installed Firefox ESR Wine version ...

# HTTP global
timeout 60 flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKLM\\Software\\Classes\\http\\shell\\open\\command" /ve /t REG_SZ /d "\"C:\\Program Files\\Mozilla Firefox\\firefox.exe\" \"%1\"" /f

# HTTPS global
timeout 60 flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKLM\\Software\\Classes\\https\\shell\\open\\command" /ve /t REG_SZ /d "\"C:\\Program Files\\Mozilla Firefox\\firefox.exe\" \"%1\"" /f


# Still in Progress ...
# Register adskidmgr:// callback to AdskIdentityManager.exe
#ADSK_EXE=$(find "$PROD_DIR" -maxdepth 1 -type d | sort | tail -1)/"Autodesk Identity Manager/AdskIdentityManager.exe"
#flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add  "HKLM\\Software\\Classes\\adskidmgr\\shell\\open\\command" /ve /t REG_SZ  /d "\"$ADSK_EXE\" \"%1\"" /f

#flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKLM\\Software\\Classes\\adskidmgr" /ve /t REG_SZ /d "URL:adskidmgr Protocol" /f
#flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKLM\\Software\\Classes\\adskidmgr" /v "URL Protocol" /t REG_SZ /d "" /f

###############################################################################################################################################################

#cd $HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/Program Files/Autodesk/webdeploy/production/PRODUCTION-ID
#flatpak run --env=WINEDEBUG=-all --env=WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360 org.winehq.Wine FusionLauncher.exe

# Path to FusionLauncher.exe
FUSION_EXE="$NEW_FOLDER/FusionLauncher.exe"

# Create a Desktop shortcut ...
# ...


# Optional: Run Fusion inside Flatpak Wine
#flatpak run --env=WINEDEBUG=-all --env=WINEPREFIX="$WINEPREFIX" org.winehq.Wine "$FUSION_EXE"

###############################################################################################################################################################


# Open the Autodesk Login Page in Firefox ESR (Flatpak Wine)
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine "C:\\Program Files\\Mozilla Firefox\\firefox.exe" "https://signin.autodesk.com/idmgr/login"

# Workaround after the login in the web browser (installed on your Host system or as flatpak app) your must copy the callback code an replace the XXXXXXXXXX with it and run this command in a seperate terminal window
# flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine xdg-open "https://signin.autodesk.com/idmgr/callback#code=XXXXXXXXXX"
