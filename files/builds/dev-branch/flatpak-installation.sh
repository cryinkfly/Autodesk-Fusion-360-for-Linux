# This script will install Autodesk Fusion in a Flatpak-Runtime!

# URL's to download Fusion360Installer.exe files
#AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe" <-- Old Link!!!
AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Admin%20Install.exe"
#AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Client%20Downloader.exe"

# URL to download Microsoft Edge WebView2.Exec
WEBVIEW2_INSTALLER_URL="https://github.com/aedancullen/webview2-evergreen-standalone-installer-archive/releases/download/109.0.1518.78/MicrosoftEdgeWebView2RuntimeInstallerX64.exe"

# URL to download the patched Qt6WebEngineCore.dll file
QT6_WEBENGINECORE_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/Qt6WebEngineCore.dll.7z"

# URL to download the patched siappdll.dll file
SIAPPDLL_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/siappdll.dll"

# Debian based systems:
# apt install p7zip-full cabextract winbind

flatpak install flathub org.winehq.Wine -y #OR: flatpak install --user flathub org.winehq.Wine -y

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


#Continue ...
