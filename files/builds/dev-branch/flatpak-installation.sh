# This script will install Autodesk Fusion in a Flatpak-Runtime!

# ----------------------------------------------------------------------------------------------------------------- #

# URL's to download Fusion360Installer.exe files
#AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe" <-- Old Link!!!
AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Admin%20Install.exe"
#AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Client%20Downloader.exe"

# URL to download Microsoft Edge WebView2.Exec
WEBVIEW2_INSTALLER_URL="https://github.com/aedancullen/webview2-evergreen-standalone-installer-archive/releases/download/109.0.1518.78/MicrosoftEdgeWebView2RuntimeInstallerX64.exe"

# URL to download the patched Qt6WebEngineCore.dll file
# QT6_WEBENGINECORE_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/Qt6WebEngineCore.dll.7z" -> OLD Qt6WebEngineCore.dll
QT6_WEBENGINECORE_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/Qt6WebEngineCore-06-2025.7z"

# URL to download the patched siappdll.dll file
SIAPPDLL_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/siappdll.dll"

# ----------------------------------------------------------------------------------------------------------------- #

# Debian based systems:
# apt install p7zip-full cabextract winbind

# ----------------------------------------------------------------------------------------------------------------- #

flatpak install flathub org.winehq.Wine/x86_64/stable-24.08 -y # Issue solved: Similar refs found for ‘org.winehq.Wine’ in remote ‘flathub’ ...
flatpak update org.winehq.Wine -y # Upgrade to the Latest Version 

flatpak run org.winehq.Wine --version #Check version of wine

# ----------------------------------------------------------------------------------------------------------------- #

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

# ----------------------------------------------------------------------------------------------------------------- #

# Install 7zip inside the wineprefix fusion360
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q 7zip

# ----------------------------------------------------------------------------------------------------------------- #

# Download and install WebView2 to handle Login attempts, required even though we redirect to your default browser
curl -L "$WEBVIEW2_INSTALLER_URL" -o "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/MicrosoftEdgeWebView2RuntimeInstallerX64.exe"
flatpak run --env="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine $HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/MicrosoftEdgeWebView2RuntimeInstallerX64.exe /silent /install

# Pre-create shortcut directory for latest re-branding Microsoft Edge WebView2
mkdir -p "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/AppData/Roaming/Microsoft/Internet Explorer/Quick Launch/User Pinned/"

# ----------------------------------------------------------------------------------------------------------------- #

# Create mimetype link to handle web login call backs to the Identity Manager
cat > $HOME/.local/share/applications/adskidmgr-opener.desktop << EOL
[Desktop Entry]
Type=Application
Name=adskidmgr Scheme Handler
Exec=sh -c 'env WINEPREFIX="WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" wine "$(find $HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/ -name "AdskIdentityManager.exe" | head -1 | xargs -I '{}' echo {})" "%u"'
StartupNotify=false
MimeType=x-scheme-handler/adskidmgr;
EOL

# Set the permissions for the .desktop file to read-only
chmod 444 $HOME/.local/share/applications/adskidmgr-opener.desktop
    
# Set the mimetype handler for the Identity Manager
xdg-mime default adskidmgr-opener.desktop x-scheme-handler/adskidmgr

# ----------------------------------------------------------------------------------------------------------------- #

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

# ----------------------------------------------------------------------------------------------------------------- #

# Find the Qt6WebEngineCore.dll file in the Autodesk Fusion directory
QT6_WEBENGINECORE=$(find "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" -name 'Qt6WebEngineCore.dll' -printf "%T+ %p\n" | sort -r | head -n 1 | sed -r 's/^[^ ]+ //')
QT6_WEBENGINECORE_DIR=$(dirname "$QT6_WEBENGINECORE")

# Download the patched Qt6WebEngineCore.dll
curl -L "$QT6_WEBENGINECORE_URL" -o "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/Qt6WebEngineCore.dll.7z"

# Excract the compressed Qt6WebEngineCore.dll.7z file
7za e -y "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/Qt6WebEngineCore.dll.7z" -o"$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/$USER/Downloads/downloads/"

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

# ----------------------------------------------------------------------------------------------------------------- #

cd $HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/Program Files/Autodesk/webdeploy/production/PRODUCTION-ID
flatpak run --env=WINEDEBUG=-all --env=WINEPREFIX=$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360 org.winehq.Wine FusionLauncher.exe

# Continue ...
