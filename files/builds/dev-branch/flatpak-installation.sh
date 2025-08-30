# This script will install Autodesk Fusion in a Flatpak-Runtime!

# URL's to download Fusion360Installer.exe files
#AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe" <-- Old Link!!!
AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Admin%20Install.exe"
#AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Client%20Downloader.exe"

# URL to download Microsoft Edge WebView2.Exec
WEBVIEW2_INSTALLER_URL="https://github.com/aedancullen/webview2-evergreen-standalone-installer-archive/releases/download/109.0.1518.78/MicrosoftEdgeWebView2RuntimeInstallerX64.exe"

# URL to download the patched Qt6WebEngineCore.dll file
# QT6_WEBENGINECORE_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/Qt6WebEngineCore.dll.7z" -> OLD Qt6WebEngineCore.dll
T6_WEBENGINECORE_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/Qt6WebEngineCore-06-2025.7z"

# URL to download the patched siappdll.dll file
SIAPPDLL_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/siappdll.dll"

# Debian based systems:
# apt install p7zip-full cabextract winbind

flatpak install flathub org.winehq.Wine/x86_64/stable-24.08 -y # Issue solved: Similar refs found for ‘org.winehq.Wine’ in remote ‘flathub’ ...
flatpak update org.winehq.Wine -y # Upgrade to the Latest Version 

flatpak run org.winehq.Wine --version #Check version of wine

flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q sandbox
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q sandbox atmlib gdiplus arial corefonts cjkfonts dotnet452 msxml4 msxml6 vcrun2017 fontsmooth=rgb winhttp win10
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q cjkfonts
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q win10

#DXVK for DirectX 9/11/...
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q dxvk
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "d3d10core" /t REG_SZ /d "native" /f
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "d3d11" /t REG_SZ /d "native" /f
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "d3d9" /t REG_SZ /d "builtin" /f
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "dxgi" /t REG_SZ /d "native" /f

flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "adpclientservice.exe" /t REG_SZ /d "" /f
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "AdCefWebBrowser.exe" /t REG_SZ /d "builtin" /f
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "msvcp140" /t REG_SZ /d "native" /f
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "mfc140u" /t REG_SZ /d "native" /f
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "bcp47langs" /t REG_SZ /d "" /f

flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q 7zip
curl -L "$WEBVIEW2_INSTALLER_URL" -o "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/steve/Downloads/MicrosoftEdgeWebView2RuntimeInstallerX64.exe"
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine $HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/steve/Downloads/MicrosoftEdgeWebView2RuntimeInstallerX64.exe /silent /install

cat > $HOME/.local/share/applications/adskidmgr-opener.desktop << EOL
[Desktop Entry]
Type=Application
Name=adskidmgr Scheme Handler
Exec=sh -c 'env WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" wine "$(find $HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/ -name "AdskIdentityManager.exe" | head -1 | xargs -I '{}' echo {})" "%u"'
StartupNotify=false
MimeType=x-scheme-handler/adskidmgr;
EOL

#Set the permissions for the .desktop file to read-only
chmod 444 $HOME/.local/share/applications/adskidmgr-opener.desktop
    
#Set the mimetype handler for the Identity Manager
xdg-mime default adskidmgr-opener.desktop x-scheme-handler/adskidmgr

curl -L "$AUTODESK_FUSION_INSTALLER_URL" -o "$HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/steve/Downloads/Fusion360ClientInstaller.exe"
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine $HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/steve/Downloads/Fusion360ClientInstaller.exe --quiet
flatpak kill org.winehq.Wine
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine $HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/users/steve/Downloads/Fusion360ClientInstaller.exe --quiet

cd $HOME/.var/app/org.winehq.Wine/data/wineprefixes/fusion360/drive_c/Program Files/Autodesk/webdeploy/production/PRODUCTION-ID
flatpak run --env=WINEDEBUG=-all --env=WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360 org.winehq.Wine FusionLauncher.exe

#Continue ...
