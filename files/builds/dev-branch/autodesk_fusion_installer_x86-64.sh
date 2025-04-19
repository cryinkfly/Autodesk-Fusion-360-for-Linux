#!/usr/bin/env bash

###############################################################################################################################################################
# THE INITIALIZATION OF DEPENDENCIES STARTS HERE:                                                                                                             #
###############################################################################################################################################################

# CONFIGURATION OF THE COLOR SCHEME:
RED=$'\033[0;31m'
YELLOW=$'\033[0;33m'
GREEN=$'\033[0;32m'
NOCOLOR=$'\033[0m'

# GET THE VALUES OF THE PASSED ARGUMENTS AND ASSIGN THEM TO VARIABLES:
SELECTED_OPTION="$1"
SELECTED_DRIVER="$2"
SELECTED_EXTENSIONS="$3"
# For example: ./autodesk_fusion_installer_x86-64.sh --install --dxvk --full

SELECTED_DIRECTORY="$HOME/.autodesk/autodesk_fusion"

# URL to download winetricks
WINETRICKS_URL="https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"

# URL to download Fusion360Installer.exe files
# AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe" <-- Old Link!!!
AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Admin%20Install.exe"
# AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Client%20Downloader.exe"  <-- Alternative Link!!!

# URL to download Microsoft Edge WebView2.Exec
# WEBVIEW2_INSTALLER_URL="https://github.com/aedancullen/webview2-evergreen-standalone-installer-archive/releases/download/109.0.1518.78/MicrosoftEdgeWebView2RuntimeInstallerX64.exe"  <-- Old Link!!!
WEBVIEW2_INSTALLER_URL="https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/76eb3dc4-7851-45b7-a392-460523b0e2bb/MicrosoftEdgeWebView2RuntimeInstallerX64.exe"

# URL to download the patched Qt6WebEngineCore.dll file
QT6_WEBENGINECORE_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/Qt6WebEngineCore.dll.7z"

# URL to download the patched siappdll.dll file
SIAPPDLL_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/siappdll.dll"

###############################################################################################################################################################
# ALL FUNCTIONS ARE HERE:                                                                                                                                     #
###############################################################################################################################################################

function check_if_wine_exists {
    if command -v wine &> /dev/null; then
        echo -e "$(gettext "${GREEN}✅ Wine is installed. The installer will be continued.${NOCOLOR}")"
    else
        echo -e "$(gettext "${RED}❌ Wine is not installed. The installer will be terminated.${NOCOLOR}")"
        exit 1
    fi
}

function create_data_structure {
    local dirs=(
        "$SELECTED_DIRECTORY"
        "$SELECTED_DIRECTORY/cache"
        "$SELECTED_DIRECTORY/cache/DLLs"
        "$SELECTED_DIRECTORY/cache/extensions"
        "$SELECTED_DIRECTORY/logs"
        "$SELECTED_DIRECTORY/wineprefix/autodesk_fusion"
    )

    mkdir -p "${dirs[@]}"
}

function download_files {
    # Download the newest winetricks version:
    echo -e "$(gettext "${YELLOW}Downloading the latest version of Winetricks...${NOCOLOR}")"
    curl -L "$WINETRICKS_URL" -o "$SELECTED_DIRECTORY/winetricks"
    chmod +x "$SELECTED_DIRECTORY/winetricks"
    echo -e "$(gettext "${GREEN}The latest winetricks version is downloaded and configured.${NOCOLOR}")"

    # Search for an existing installer of Autodesk Fusion
    AUTODESK_FUSION_INSTALLER="$SELECTED_DIRECTORY/cache/FusionClientInstaller.exe"
    if [ -f "$AUTODESK_FUSION_INSTALLER" ]; then
        echo -e "$(gettext "${GREEN}The latest Autodesk Fusion installer has been found.${NOCOLOR}")"
    else
        echo -e "$(gettext "${YELLOW}Downloading the latest version of the Autodesk Fusion installer.${NOCOLOR}")"
        curl -L "$AUTODESK_FUSION_INSTALLER_URL" -o "$AUTODESK_FUSION_INSTALLER"
        echo -e "$(gettext "${GREEN}The latest version of the Autodesk Fusion installer is downloaded.${NOCOLOR}")"
    fi

    # Search for an existing installer of WEBVIEW2
    WEBVIEW2_INSTALLER="$SELECTED_DIRECTORY/cache/WebView2installer.exe"
    if [ -f "$WEBVIEW2_INSTALLER" ]; then
        echo -e "$(gettext "${GREEN}The latest WebView2 installer has been found.${NOCOLOR}")"
    else
        echo -e "$(gettext "${YELLOW}Downloading the latest version of the WebView2 installer.${NOCOLOR}")"
        curl -L "$WEBVIEW2_INSTALLER_URL" -o "$WEBVIEW2_INSTALLER"
        echo -e "$(gettext "${GREEN}The latest version of the WebView2 installer is downloaded.${NOCOLOR}")"
    fi

    # Download all verified/tested extensions for Autodesk Fusion
    echo -e "$(gettext "${YELLOW}Downloading all verified/tested for Autodesk Fusion.${NOCOLOR}")"

    local extensions=(
        "Ceska_lokalizace_pro_Autodesk_Fusion.exe|https://www.cadstudio.cz/dl/Ceska_lokalizace_pro_Autodesk_Fusion_360.exe"
        "HP_3DPrinters_for_Fusion360-win64.msi|https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/HP_3DPrinters_for_Fusion360-win64.msi"
        "Markforged_for_Fusion360-win64.msi|https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/Markforged_for_Fusion360-win64.msi"
        "OctoPrint_for_Fusion360-win64.msi|https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/OctoPrint_for_Fusion360-win64.msi"
        "Ultimaker_Digital_Factory-win64.msi|https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/Ultimaker_Digital_Factory-win64.msi"
    )

    for entry in "${extensions[@]}"; do
        local EXTENSION_FILE_NAME="${entry%%|*}"
        local EXTENSION_FILE_URL="${entry##*|}"
        local EXTENSION_FILE_DIRECTORY="$SELECTED_DIRECTORY/cache/extensions/$EXTENSION_FILE_NAME"

        mkdir -p "$(dirname "$EXTENSION_FILE_DIRECTORY")"

        # Search for all existing installers of the extensions
        if [ -f "$EXTENSION_FILE_DIRECTORY" ]; then
            echo -e "$(gettext "${GREEN}The $EXTENSION_FILE_NAME has been found.${NOCOLOR}")"
        else
            echo -e "$(gettext "${YELLOW}Downloading the latest version of $EXTENSION_FILE_NAME.${NOCOLOR}")"
            curl -fL "$EXTENSION_FILE_URL" -o "$EXTENSION_FILE_DIRECTORY" || echo -e "$(gettext "${RED}Failed to download $EXTENSION_FILE_NAME${NOCOLOR}")"
        fi
    done

    echo -e "$(gettext "${GREEN}All tested extensions for Autodesk Fusion on Linux are downloaded!${NOCOLOR}")"

    # Download the patched Qt6WebEngineCore.dll file
    QT6_WEBENGINECORE_DLL="$SELECTED_DIRECTORY/cache/DLLs/Qt6WebEngineCore.dll.7z"
    if [ -f "$QT6_WEBENGINECORE_DLL" ]; then
        echo -e "$(gettext "${GREEN}The latest patched Qt6WebEngineCore.dll file has been found.${NOCOLOR}")"
    else
        echo -e "$(gettext "${YELLOW}Downloading the latest patched Qt6WebEngineCore.dll file.${NOCOLOR}")"
        curl -L "$QT6_WEBENGINECORE_URL" -o "$QT6_WEBENGINECORE_DLL"
        echo -e "$(gettext "${GREEN}The latest patched Qt6WebEngineCore.dll file.${NOCOLOR}")"
    fi
        
    # Extract the patched the 6WebEngineCore.dll.7z file with overwrite option
    7za x -y -o"$SELECTED_DIRECTORY/cache/DLLs/" "$SELECTED_DIRECTORY/cache/DLLs/Qt6WebEngineCore.dll.7z"

    # Download the patched siappdll.dll file
    SIAPPDLL_DLL="$SELECTED_DIRECTORY/cache/DLLs/siappdll.dll"
    if [ -f "$SIAPPDLL_DLL" ]; then
        echo -e "$(gettext "${GREEN}The latest patched siappdll.dll file has been found.${NOCOLOR}")"
    else
        echo -e "$(gettext "${YELLOW}Downloading the latest patched siappdll.dll file.${NOCOLOR}")"
        curl -L "$SIAPPDLL_URL" -o "$SIAPPDLL_DLL"
        echo -e "$(gettext "${GREEN}The latest patched siappdll.dll file.${NOCOLOR}")"
    fi
}

function create_adskidmgr_opener {
    cat > "$HOME/.local/share/applications/adskidmgr-opener.desktop" << EOL
[Desktop Entry]
Type=Application
Name=adskidmgr Scheme Handler
Exec=sh -c 'env WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" wine "\$(find \$SELECTED_DIRECTORY/wineprefix/autodesk_fusion/ -name "AdskIdentityManager.exe" | head -1 | xargs -I "{}" echo {})" "%u"'
StartupNotify=false
MimeType=x-scheme-handler/adskidmgr;
EOL

    #Set the mimetype handler for the Identity Manager
    xdg-mime default adskidmgr-opener.desktop x-scheme-handler/adskidmgr
}

function wineprefix_config {
    # Note that the winetricks sandbox verb merely removes the desktop integration and Z: drive symlinks and is not a "true" sandbox.
    # It protects against errors rather than malice. It's useful for, e.g., keeping games from saving their settings in random subdirectories of your home directory.
    # But it still ensures that wine, for example, no longer has access permissions to Home!
    # For this reason, the EXE files must be located directly in the Wineprefix folder!

    cd "$SELECTED_DIRECTORY" || return
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" sh "winetricks" -q sandbox # Activate the Sandbox-Mode!
    sleep 1s
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" sh "winetricks" -q atmlib gdiplus arial corefonts cjkfonts dotnet452 msxml4 msxml6 vcrun2017 fontsmooth=rgb winhttp win10
    # We must install cjkfonts again then sometimes it doesn't work in the first time!
    sleep 1s
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" sh "winetricks" -q cjkfonts
    # We must set to Windows 10 again because sometimes winetricks set it back to Windows XP!
    sleep 1s
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" sh "winetricks" -q win10
    # Configuring some DLL-Overrides
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "adpclientservice.exe" /t REG_SZ /d "" /f # Removed tracking metrics and disabled calling home!
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "AdCefWebBrowser.exe" /t REG_SZ /d builtin /f
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "msvcp140" /t REG_SZ /d native /f
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "mfc140u" /t REG_SZ /d native /f
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "bcp47langs" /t REG_SZ /d "" /f # Fixed bcp47langs issue, login is working now!
    # Optional - Configuring the correct virtual desktop resolution
    # WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" sh "winetricks" -q vd="MONITOR_RESOLUTION" # For example: 1920x1080
    # Install the latest version of WebView2 to handle Login attempts, required even though we redirect to your default browser!
    cp -f "$WEBVIEW2_INSTALLER" "$SELECTED_DIRECTORY/wineprefix/autodesk_fusion/drive_c/users/$USER/Downloads/WebView2installer.exe"
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" wine "$SELECTED_DIRECTORY/wineprefix/autodesk_fusion/drive_c/users/$USER/Downloads/WebView2installer.exe" /silent /install
    # Pre-create a shortcut directory for the latest re-branding Microsoft Edge WebView2
    mkdir -p "$SELECTED_DIRECTORY/wineprefix/autodesk_fusion/drive_c/users/$USER/AppData/Roaming/Microsoft/Internet Explorer/Quick Launch/User Pinned/"
    sleep 1s
    # Check the selected GPU driver (DXVK or OpenGL)
    if [ "$SELECTED_DRIVER" = "dxvk" ]; then
        WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" sh "winetricks" -q dxvk
        sleep 1s
        WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "d3d10core" /t REG_SZ /d native /f
        WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "d3d11" /t REG_SZ /d native /f
        WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "d3d9" /t REG_SZ /d builtin /f
        WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "dxgi" /t REG_SZ /d native /f
    else
        curl -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/resource/video_driver/opengl/NMachineSpecificOptions.xml -o "$SELECTED_DIRECTORY/cache/NMachineSpecificOptions.xml"
        mkdir -p "$SELECTED_DIRECTORY/wineprefix/autodesk_fusion/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options"
        cp -f "$SELECTED_DIRECTORY/cache/NMachineSpecificOptions.xml" "$SELECTED_DIRECTORY/wineprefix/autodesk_fusion/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options/NMachineSpecificOptions.xml"
}

function install_autodesk_fusion {
    cp -f "$AUTODESK_FUSION_INSTALLER" "$SELECTED_DIRECTORY/wineprefix/autodesk_fusion/drive_c/users/$USER/Downloads/FusionClientInstaller.exe"
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" wine "$SELECTED_DIRECTORY/wineprefix/autodesk_fusion/drive_c/users/$USER/Downloads/FusionClientInstaller.exe"  --quiet
    sleep 1s
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" wine "$SELECTED_DIRECTORY/wineprefix/autodesk_fusion/drive_c/users/$USER/Downloads/FusionClientInstaller.exe"  --quiet
}

function autodesk_fusion_dlls_config {
    # Find the newest Qt6WebEngineCore.dll file
    QT6_WEBENGINECORE=$(find "$SELECTED_DIRECTORY/wineprefix/autodesk_fusion" -type f -name 'Qt6WebEngineCore.dll' -printf '%T@ %p\n' 2>/dev/null | sort -nr | head -n1 | cut -d' ' -f2-)
    # Get the directory of the Qt6WebEngineCore.dll file
    QT6_WEBENGINECORE_DIR=$(dirname "$QT6_WEBENGINECORE")

    # Check if the Qt6WebEngineCore.dll file actually exists before backing it up
    if [ -f "$QT6_WEBENGINECORE" ]; then
        # Backup the Qt6WebEngineCore.dll file
        cp -f "$QT6_WEBENGINECORE" "$QT6_WEBENGINECORE_DIR/Qt6WebEngineCore.dll.bak"
        # Override the original Qt6WebEngineCore.dll with the patched version
        cp -f "$SELECTED_DIRECTORY/cache/DLLs/Qt6WebEngineCore.dll" "$QT6_WEBENGINECORE_DIR/Qt6WebEngineCore.dll"
    else
        # Override the original Qt6WebEngineCore.dll with the patched version
        cp -f "$SELECTED_DIRECTORY/cache/DLLs/Qt6WebEngineCore.dll" "$QT6_WEBENGINECORE_DIR/Qt6WebEngineCore.dll"
    fi
}

###############################################################################################################################################################
# THE PROGRAM STARTED HERE:                                                                                                                                   #
###############################################################################################################################################################

check_if_wine_exists
create_data_structure
download_files
create_adskidmgr_opener
wineprefix_config
install_autodesk_fusion
autodesk_fusion_dlls_config



