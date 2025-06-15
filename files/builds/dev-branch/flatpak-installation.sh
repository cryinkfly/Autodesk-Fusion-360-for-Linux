# This script will install Autodesk Fusion in a Flatpak-Runtime!

flatpak install flathub org.winehq.Wine -y #OR: flatpak install --user flathub org.winehq.Wine -y
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q sandbox
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" --command="winetricks" org.winehq.Wine -q sandbox atmlib gdiplus arial corefonts cjkfonts dotnet452 msxml4 msxml6 vcrun2017 fontsmooth=rgb winhttp win10
WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" sh "winetricks" -q cjkfonts
WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" sh "winetricks" -q win10

flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "adpclientservice.exe" /t REG_SZ /d "" /f
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "AdCefWebBrowser.exe" /t REG_SZ /d "builtin" /f
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "msvcp140" /t REG_SZ /d "native" /f
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "mfc140u" /t REG_SZ /d "native" /f
flatpak run --env="WINEPREFIX=/home/$USER/.var/app/org.winehq.Wine/data/wineprefixes/fusion360" org.winehq.Wine reg add "HKCU\\Software\\Wine\\DllOverrides" /v "bcp47langs" /t REG_SZ /d "" /f

#Continue ...
