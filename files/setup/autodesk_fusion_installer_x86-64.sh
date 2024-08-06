#!/usr/bin/env bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This file install Autodesk Fusion on your system.                                  #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2024                                                                          #
# Time/Date:    14:00/06.08.2024                                                                   #
# Version:      2.0.0-Alpha                                                                        #
####################################################################################################

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
SELECTED_DIRECTORY="$2"
SELECTED_EXTENSIONS="$3"

if [ -z "$SELECTED_DIRECTORY" ] || [ "$SELECTED_DIRECTORY" == "--default" ]; then
    SELECTED_DIRECTORY="$HOME/.autodesk_fusion"
fi

# if selected_extensions is set to --full, then all extensions will be installed
if [ "$SELECTED_EXTENSIONS" == "--full" ]; then
    SELECTED_EXTENSIONS="CzechlocalizationforF360,HP3DPrintersforAutodesk®Fusion®,MarkforgedforAutodesk®Fusion®,OctoPrintforAutodesk®Fusion360™,UltimakerDigitalFactoryforAutodeskFusion360™"
else
    SELECTED_EXTENSIONS=""
fi

# URL to download translations po. files <-- Still in progress!!!
UPDATER_TRANSLATIONS_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/update-locale.sh"
declare -A TRANSLATION_URLS=(
    ["cs_CZ"]="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/cs_CZ/LC_MESSAGES/autodesk_fusion.po"
    ["de_DE"]="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/de_DE/LC_MESSAGES/autodesk_fusion.po"
    ["en_US"]="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/en_US/LC_MESSAGES/autodesk_fusion.po"
    ["es_ES"]="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/es_ES/LC_MESSAGES/autodesk_fusion.po"
    ["fr_FR"]="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/fr_FR/LC_MESSAGES/autodesk_fusion.po"
    ["it_IT"]="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/it_IT/LC_MESSAGES/autodesk_fusion.po"
    ["ja_JP"]="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/ja_JP/LC_MESSAGES/autodesk_fusion.po"
    ["ko_KR"]="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/ko_KR/LC_MESSAGES/autodesk_fusion.po"
    ["pl_PL"]="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/pl_PL/LC_MESSAGES/autodesk_fusion.po"
    ["pt_BR"]="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/pt_BR/LC_MESSAGES/autodesk_fusion.po"
    ["tr_TR"]="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/tr_TR/LC_MESSAGES/autodesk_fusion.po"
    ["zh_CN"]="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/zh_CN/LC_MESSAGES/autodesk_fusion.po"
    ["zh_TW"]="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/locale/zh_TW/LC_MESSAGES/autodesk_fusion.po"
)

# URL to download winetricks
WINETRICKS_URL="https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"

# URL to download Fusion360Installer.exe files
#AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe" <-- Old Link!!!
AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Admin%20Install.exe"
#AUTODESK_FUSION_INSTALLER_URL="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Client%20Downloader.exe"

# URL to download Microsoft Edge WebView2.Exec
WEBVIEW2_INSTALLER_URL="https://github.com/aedancullen/webview2-evergreen-standalone-installer-archive/releases/download/109.0.1518.78/MicrosoftEdgeWebView2RuntimeInstallerX64.exe"

# URL to download the patched Qt6WebEngineCore.dll file
QT6_WEBENGINECORE_URL="https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/patched-dlls/Qt6WebEngineCore.dll.7z"

##############################################################################################################################################################################
# CHECK THE REQUIRED PACKAGES FOR THE INSTALLER:                                                                                                                             #
##############################################################################################################################################################################

function check_required_packages {
    DISTRO=$(grep "^ID=" /etc/*-release | cut -d'=' -f2 | tr -d '"')
    VERSION=$(grep "^VERSION_ID=" /etc/*-release | cut -d'=' -f2 | tr -d '"')    
    DISTRO_VERSION="$DISTRO $VERSION"
    REQUIRED_COMMANDS=("curl" "lsb-release" "glxinfo" "pkexec")
    COREUTILS_NEEDED=("ls" "cat" "echo") # Example coreutils commands

    # Check for individual coreutils commands
    for cmd in "${COREUTILS_NEEDED[@]}"; do
        if ! command -v "${cmd}" &>/dev/null; then
                echo -e "$(gettext "${RED}A required coreutils command (${cmd}) is not installed!")${NOCOLOR}"
            install_required_packages
            return
        fi
    done

    # Check for other required commands
    for cmd in "${REQUIRED_COMMANDS[@]}"; do
        echo -e "$(gettext "${YELLOW}Checking for required package: ${cmd} ...")${NOCOLOR}"
        if ! command -v "${cmd}" &>/dev/null; then
            echo -e "$(gettext "${RED}The required package (${cmd}) is not installed!")${NOCOLOR}"
            install_required_packages
            return
        fi
    done

    clear
}

##############################################################################################################################################################################
# INSTALLATION OF THE REQUIRED PACKAGES FOR THE INSTALLER:                                                                                                                   #
##############################################################################################################################################################################

function install_required_packages {
    echo -e "$(gettext "${YELLOW}The installer will install the required packages for the installation!")${NOCOLOR}"
    echo -e "$(gettext "${RED}Missing package: ${cmd}")${NOCOLOR}"
    sleep 2
        if [[ $DISTRO_VERSION == *"Arch"*"Linux"* ]] || [[ $DISTRO_VERSION == *"Manjaro"*"Linux"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo pacman -S curl lsb-release coreutils mesa-demos polkit
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"Debian"*"10"* ]] || [[ $DISTRO_VERSION == *"Debian"*"11"* ]] || [[ $DISTRO_VERSION == *"Debian"*"Sid"* ]] || [[ $DISTRO_VERSION == *"Ubuntu"*"18.04"* ]] \
        || [[ $DISTRO_VERSION == *"Linux Mint"*"19"* ]] || [[ $DISTRO_VERSION == *"Ubuntu"*"20.04"* ]] || [[ $DISTRO_VERSION == *"Linux Mint"*"20"* ]] \
        || [[ $DISTRO_VERSION == *"Ubuntu"*"22.04"* ]] || [[ $DISTRO_VERSION == *"Linux Mint"*"21"* ]] || [[ $DISTRO_VERSION == *"Linux Mint"*"22"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo apt-get install -y curl lsb-release coreutils mesa-utils policykit-1 
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"Fedora"*"37"* ]] || [[ $DISTRO_VERSION == *"Fedora"*"38"* ]] || [[ $DISTRO_VERSION == *"Fedora"*"Rawhide"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo dnf install -y curl lsb-release coreutils mesa-utils polkit
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"Gentoo"*"Linux"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo emerge -q net-misc/curl sys-apps/lsb-release sys-apps/coreutils x11-apps/mesa-progs sys-auth/polkit
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"nixos"* ]] || [[ $DISTRO_VERSION == *"NixOS"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo nix-env -iA nixos.curl nixos.lsb_release nixos.coreutils nixos.mesa-utils nixos.polkit
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"openSUSE"*"15.5"* ]] || [[ $DISTRO_VERSION == *"openSUSE"*"15.6"* ]] || [[ $DISTRO_VERSION == *"openSUSE"*"Tumbleweed"* ]] || [[ $DISTRO_VERSION == *"opensuse"*"tumbleweed"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo zypper install -y curl lsb-release coreutils Mesa-demo-x polkit
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"Red Hat Enterprise Linux"*"8"* ]] || [[ $DISTRO_VERSION == *"Red Hat Enterprise Linux"*"9"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo dnf install -y curl lsb-release coreutils mesa-utils policykit-1
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"Solus"*"Linux"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo eopkg -y install curl lsb-release coreutils mesa-utils polkit
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"Void"*"Linux"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo xbps-install -Sy curl lsb-release coreutils mesa-demos polkit
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        else
            echo -e "$(gettext "${RED}The installer doesn't support your current Linux distribution $distro_version at this time!")${NOCOLOR}"; 
            echo -e "$(gettext "${RED}The installer has been terminated!")${NOCOLOR}"
            sleep 2
            exit;
        fi
}

##############################################################################################################################################################################
# DOWNLOAD THE TRANSLATIONS FOR THE INSTALLER:                                                                                                                              #
##############################################################################################################################################################################

# <-- Still in progress!!!
function download_translations {
    curl -o "./locale/update-locale.sh" "$UPDATER_TRANSLATIONS_URL"
    chmod +x "./locale/update-locale.sh"

    # Curl the translations for the installer
    for locale in "${!TRANSLATION_URLS[@]}"; do
        local TRANSLATION_FILE_URL="${TRANSLATION_URLS[$locale]}"
        local TRANSLATION_FILE_DIRECTORY="./locale/$locale/LC_MESSAGES/autodesk_fusion.po"
        
        mkdir -p "$(dirname "$TRANSLATION_FILE_DIRECTORY")"
        curl -L "$TRANSLATION_FILE_URL" -o "$TRANSLATION_FILE_DIRECTORY"
    done

    source "./locale/update-locale.sh"

    # SET THE TEXTDOMAIN FOR THE INSTALLER:
    TEXTDOMAIN="autodesk_fusion"
    TEXTDOMAINDIR="./locale"

    # Load translations
    export TEXTDOMAIN
    export TEXTDOMAINDIR
}

##############################################################################################################################################################################
# CHECK THE OPTIONS FOR THE INSTALLER:                                                                                                                                       #
##############################################################################################################################################################################

function check_option() {
    case "$1" in
        "--uninstall")
            clear
            echo "$(gettext "${YELLOW}Starting the uninstallation process ...${NOCOLOR}")"
            # Show a list of two options with:
            # 1. Are you sure you want to uninstall Autodesk Fusion and all its components?
            # 2. Uninstall only a specific Wineprefix of Autodesk Fusion



            read -p "$(gettext "${GREEN}Do you really want to uninstall Autodesk Fusion?${NOCOLOR}") [y/n] " yn
            case $yn in
                [Yy]* ) echo "$(gettext "${YELLOW}1. Uninstall Autodesk Fusion with all Wineprefixes and components${NOCOLOR}")"
                        echo "$(gettext "${YELLOW}2. Uninstall only a specific Wineprefix of Autodesk Fusion${NOCOLOR}")"
                        read -p "$(gettext "${GREEN}Please select an option: ${NOCOLOR}")" uninstall_option

                        case $uninstall_option in
                            1) echo "$(gettext "${RED}Uninstall Autodesk Fusion with all Wineprefixes and components${NOCOLOR}")"
                               rm -rf "$SELECTED_DIRECTORY";
                               rm -rf "$HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk Fusion.desktop";
                               echo "$(gettext "${GREEN}Autodesk Fusion has been uninstalled successfully!${NOCOLOR}")"
                               exit;;
                            2) echo "$(gettext "${GREEN}Listing all Wineprefixes of Autodesk Fusion in the ${SELECTED_DIRECTORY}/wineprefixes/ directory${NOCOLOR}")"
                               # Initialize counter
                               COUNTER=1
                               for wp in "$SELECTED_DIRECTORY/wineprefixes/"*; do
                                  # Display the counter and wineprefix name
                                  echo "$(gettext "${YELLOW}${COUNTER}. $(basename "$wp")${NOCOLOR}")"
                                  # Increment the counter
                                  COUNTER=$((COUNTER + 1))
                               done
                               read -p "$(gettext "${RED}Enter the number of the Wineprefix you want to uninstall or type 'exit' to cancel the process: ${NOCOLOR}")" DEL_SELECTED_WINEPREFIX
                               case $DEL_SELECTED_WINEPREFIX in
                                   exit) echo "$(gettext "${GREEN}The uninstallation process has been canceled!${NOCOLOR}")"
                                         exit;;
                                   *) DEL_SELECTED_WINEPREFIX=$(ls "$SELECTED_DIRECTORY/wineprefixes/" | sed -n "${DEL_SELECTED_WINEPREFIX}p")
                                      echo "$(gettext "${YELLOW}Uninstalling the selected Wineprefix ...${NOCOLOR}")"
                                      rm -rf "$SELECTED_DIRECTORY/wineprefixes/$DEL_SELECTED_WINEPREFIX";
                                      echo "$(gettext "${GREEN}The selected Wineprefix has been uninstalled successfully!${NOCOLOR}")"
                                      exit;;
                               esac;;  
                            *) echo "$(gettext "${RED}Please select a valid option!${NOCOLOR}")"
                               exit;;
                        esac;;  
                [Nn]* ) echo -e "$(gettext "${GREEN}The uninstallation process has been canceled!")${NOCOLOR}"; 
                        exit;;
                * ) echo -e "$(gettext "${YELLOW}Please answer with yes or no!${NOCOLOR}")";
                    exit;;
            esac
            ;;
        "--install")
            echo -e "$(gettext "${GREEN}Starting the installation process ...${NOCOLOR}")"
            sleep 2
            echo -e "$(gettext "${GREEN}Linux distribution: ${YELLOW}$DISTRO_VERSION${NOCOLOR}")"
            sleep 2
            echo -e "$(gettext "${GREEN}Selected option: ${YELLOW}$SELECTED_OPTION${NOCOLOR}")"
            sleep 2
            echo -e "$(gettext "${GREEN}Selected directory: ${YELLOW}$SELECTED_DIRECTORY${NOCOLOR}")"
            sleep 2
            echo -e "$(gettext "${GREEN}Selected extensions: ${YELLOW}$SELECTED_EXTENSIONS${NOCOLOR}")"
            sleep 2
            deactivate_window_not_responding_dialog
            check_ram
            check_gpu_driver
            check_disk_space
            create_data_structure
            download_files
            check_and_install_wine
            wine_autodesk_fusion_install
            autodesk_fusion_patch_qt6webenginecore
            wine_autodesk_fusion_check_extensions
            wine_autodesk_fusion_install_extensions
            autodesk_fusion_shortcuts_load
            autodesk_fusion_safe_logfile
            reset_window_not_responding_dialog
            xdg-open "https://cryinkfly.com/sponsoring/"
            run_wine_autodesk_fusion
            exit;;
        *)
            echo -e "$(gettext "${RED}Invalid option! Please use the --install or --uninstall flag!")${NOCOLOR}";
            exit;;
    esac
}

##############################################################################################################################################################################
# DEACTIVATE THE WINDOW NOT RESPONDING DIALOG:                                                                                                                               #
##############################################################################################################################################################################

function deactivate_window_not_responding_dialog() {
    # Check if desktop environment is GNOME
    if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
        # Disable the "Window not responding" Dialog in GNOME for 30 minutes:
        echo -e "$(gettext "${YELLOW}The 'Window not responding' Dialog in GNOME will be disabled for 30 minutes!")${NOCOLOR}"
        gsettings set org.gnome.mutter check-alive-timeout 1800000
    fi
}

##############################################################################################################################################################################
# CHECKING THE MINIMUM RAM (RANDOM ACCESS MEMORY) REQUIREMENT:                                                                                                               #
##############################################################################################################################################################################

function check_ram {
    GET_RAM_KILOBYTES=$(grep MemTotal /proc/meminfo | awk '{print $2}') # Get total RAM space in kilobytes
    CONVERT_RAM_GIGABYTES=$(echo "scale=2; $GET_RAM_KILOBYTES / 1024 / 1024" | bc) # Convert kilobytes to gigabytes
    if (( $(echo "$CONVERT_RAM_GIGABYTES > 4" | bc -l) )); then # Check if RAM is greater than 4 GB
        echo -e "$(gettext "${GREEN}The total RAM (Random Access Memory) is greater than 4 GByte ($CONVERT_RAM_GIGABYTES GByte) and Autodesk Fusion will run more stable later!${NOCOLOR}")"
    else
        echo -e "$(gettext "${RED}The total RAM (Random Access Memory) is not greater than 4 GByte ($CONVERT_RAM_GIGABYTES GByte) and Autodesk Fusion may run unstable later with insufficient RAM memory!${NOCOLOR}")"
        read -p "$(gettext "${YELLOW}Are you sure you want to continue with the installation? (y/n)${NOCOLOR}")" yn
            case $yn in 
	            y ) ...;;
                n ) echo -e "$(gettext "${RED}The installer has been terminated!${NOCOLOR}")";
                     exit;;
                * ) echo -e "$(gettext "${RED}The installer was terminated for inexplicable reasons!${NOCOLOR}")";
                    exit 1;;
            esac
    fi
}

##############################################################################################################################################################################
# CHECK GPU DRIVER FOR THE INSTALLER:                                                                                                                                        #
##############################################################################################################################################################################

function check_gpu_driver {
    echo -e "$(gettext "${YELLOW}Checking the GPU driver for the installer ...${NOCOLOR}")"
    if glxinfo | grep -q "OpenGL vendor string: NVIDIA"; then
        echo -e "$(gettext "${GREEN}The NVIDIA GPU driver is installed!${NOCOLOR}")"
        sleep 2
        echo -e "$(gettext "${GREEN}The DXVK GPU driver will be used for the installation!${NOCOLOR}")"
        GPU_DRIVER="DXVK"
        sleep 2
        check_gpu_vram
    elif glxinfo | grep -q "OpenGL vendor string: AMD"; then
        echo -e "$(gettext "${GREEN}The AMD GPU driver is installed!${NOCOLOR}")"
        sleep 2
        echo -e "$(gettext "${GREEN}The OpenGL GPU driver will be used for the installation!${NOCOLOR}")"
        GPU_DRIVER="OpenGL"
        sleep 2
        check_gpu_vram
    elif glxinfo | grep -q "OpenGL vendor string: Intel"; then
        echo -e "$(gettext "${GREEN}The Intel GPU driver is installed!${NOCOLOR}")"
        sleep 2
        echo -e "$(gettext "${GREEN}The OpenGL GPU driver will be used for the installation!${NOCOLOR}")"
        GPU_DRIVER="OpenGL"
        sleep 2
        check_gpu_vram
    else
        echo -e "$(gettext "${red}The GPU driver is not installed or not found on your system!${NOCOLOR}")"
        sleep 2
        echo -e "$(gettext "${GREEN}The OpenGL GPU driver will be used for the installation!${NOCOLOR}")"
        GPU_DRIVER="OpenGL"
        sleep 2
        check_gpu_vram
    fi
}

##############################################################################################################################################################################
# CHECKING THE MINIMUM VRAM (VIDEO RAM) REQUIREMENT:                                                                                                                         #
##############################################################################################################################################################################

function check_gpu_vram {
    # Get the total memory of the graphics card
    GET_VRAM_MEGABYTES=$(dmesg | grep -o -P -i "(?<=vram:).*(?=M 0x)")
    # Check if the total memory is greater than 1 GByte
    if [ "$GET_VRAM_MEGABYTES" -gt 1024 ]; then
        echo -e "$(gettext "${GREEN}The total VRAM (Video RAM) is greater than 1 GByte ($CONVERT_RAM_GIGABYTES GByte) and Autodesk Fusion will run more stable later!${NOCOLOR}")"
    else
        echo -e "$(gettext "${RED}The total VRAM (Video RAM) is not greater than 1 GByte ($CONVERT_RAM_GIGABYTES GByte) and Autodesk Fusion may run unstable later with insufficient VRAM memory!${NOCOLOR}")"
        read -p "$(gettext "${YELLOW}Are you sure you want to continue with the installation? (y/n)${NOCOLOR}")" yn
        case $yn in 
            y ) ...;;
            n ) echo -e "$(gettext "${RED}The installer has been terminated!${NOCOLOR}")";
                exit;;
            * ) echo -e "$(gettext "${RED}The installer was terminated for inexplicable reasons!${NOCOLOR}")";
                exit 1;;
        esac
    fi
}

##############################################################################################################################################################################
# CHECKING THE MINIMUM DISK SPACE (DEFAULT: HOME-PARTITION) REQUIREMENT:                                                                                                     #
##############################################################################################################################################################################

function check_disk_space {
    # Get the free disk memory size in GB
    GET_DISK_SPACE=$(df -h $SELECTED_DIRECTORY | awk '{print $4}' | tail -1)
    echo -e "$(gettext "${GREEN}The free disk memory size is: $GET_DISK_SPACE${NOCOLOR}")"
    if [[ $GET_DISK_SPACE > 10G ]]; then # Check if the selected disk memory is greater than 10GB
        echo -e "$(gettext "${GREEN}The free disk memory size is greater than 10GB.${NOCOLOR}")"
    else
        echo -e "$(gettext "${YELLOW}There is not enough disk free memory to continue installing Fusion on your system!${NOCOLOR}")"
        echo -e "$(gettext "${YELLOW}Make more space in your selected disk or select a different hard drive.${NOCOLOR}")"
        echo -e "$(gettext "${RED}The installer has been terminated!${NOCOLOR}")"
        exit;
    fi
}

##############################################################################################################################################################################
# CREATE THE DATA STRUCTURE FOR THE INSTALLER:                                                                                                                               #
##############################################################################################################################################################################

function create_data_structure() {
    mkdir -p "$SELECTED_DIRECTORY/bin" \
        "$SELECTED_DIRECTORY/config" \
        "$SELECTED_DIRECTORY/downloads/extensions" \
        "$SELECTED_DIRECTORY/logs" \
        "$SELECTED_DIRECTORY/locale" \
        "$SELECTED_DIRECTORY/resources/graphics" \
        "$SELECTED_DIRECTORY/resources/styles" \
        "$SELECTED_DIRECTORY/wineprefixes/default"
}

##############################################################################################################################################################################
# DOWNLOAD THE REQUIRED FILES FOR THE INSTALLER:                                                                                                                             #
##############################################################################################################################################################################

function download_files() {
    echo -e "$(gettext "${GREEN}Downloading the required files for the installation ...${NOCOLOR}")"
    sleep 2
    # Download the newest winetricks version:
    echo -e "$(gettext "${YELLOW}Downloading the newest winetricks version ...${NOCOLOR}")"
    curl -L "$WINETRICKS_URL" -o "$SELECTED_DIRECTORY/bin/winetricks"
    chmod +x "$SELECTED_DIRECTORY/bin/winetricks"
    # Search for an existing installer of Autodesk Fusion and download it if it doesn't exist or is older than 7 days
    AUTODESK_FUSION_INSTALLER="$SELECTED_DIRECTORY/downloads/FusionClientInstaller.exe"
    if [ -f "$AUTODESK_FUSION_INSTALLER" ]; then
        echo -e "$(gettext "${GREEN}The Autodesk Fusion installer exists!${NOCOLOR}")"
        if find "$AUTODESK_FUSION_INSTALLER" -mtime +7 | grep -q .; then
            echo -e "$(gettext "${YELLOW}The Autodesk Fusion installer exists but is older than 7 days and will be updated!")${NOCOLOR}"
            rm -rf "$AUTODESK_FUSION_INSTALLER"
            curl -L "$AUTODESK_FUSION_INSTALLER_URL" -o "$AUTODESK_FUSION_INSTALLER"
        fi
    else
        echo -e "$(gettext "${YELLOW}The Autodesk Fusion installer doesn't exist and will be downloaded for you!${NOCOLOR}")"
        curl -L "$AUTODESK_FUSION_INSTALLER_URL" -o "$AUTODESK_FUSION_INSTALLER"
    fi
    # Search for an existing installer of WEBVIEW2 and download it if it doesn't exist or is older than 7 days
    WEBVIEW2_INSTALLER="$SELECTED_DIRECTORY/downloads/WebView2installer.exe"
    if [ -f "$WEBVIEW2_INSTALLER" ]; then
        echo -e "$(gettext "${GREEN}The WebView2installer installer exists!${NOCOLOR}")"
        if find "$WEBVIEW2_INSTALLER" -mtime +7 | grep -q .; then
            echo -e "$(gettext "${YELLOW}The WebView2installer installer exists but is older than 7 days and will be updated!")${NOCOLOR}"
            rm -rf "$WEBVIEW2_INSTALLER"
            curl -L "$WEBVIEW2_INSTALLER_URL" -o "$WEBVIEW2_INSTALLER"
        fi
    else
        echo -e "$(gettext "${YELLOW}The WebView2installer installer doesn't exist and will be downloaded for you!${NOCOLOR}")"
        curl -L "$WEBVIEW2_INSTALLER_URL" -o "$WEBVIEW2_INSTALLER"
    fi
    # Download all tested extensions for Autodesk Fusion 360 on Linux
    download_extensions_files
    # Download the patched Qt6WebEngineCore.dll file
    curl -L "$QT6_WEBENGINECORE_URL" -o "$SELECTED_DIRECTORY/downloads/Qt6WebEngineCore.dll.7z"
    # Extract the patched t6WebEngineCore.dll.7z file
    7z x "$SELECTED_DIRECTORY/downloads/Qt6WebEngineCore.dll.7z" -o"$SELECTED_DIRECTORY/downloads/"
}

# Download an extension if it doesn't exist or is older than 7 days
function download_extensions_files {
    echo -e "$(gettext "${YELLOW}Downloading the tested extensions for Autodesk Fusion on Linux ...${NOCOLOR}")"
    download_extension "Ceska_lokalizace_pro_Autodesk_Fusion.exe" \
        "https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/Ceska_lokalizace_pro_Autodesk_Fusion.exe"
    download_extension "HP_3DPrinters_for_Fusion360-win64.msi" \
        "https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/HP_3DPrinters_for_Fusion360-win64.msi"
    download_extension "Markforged_for_Fusion360-win64.msi" \
        "https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/Markforged_for_Fusion360-win64.msi"
    download_extension "OctoPrint_for_Fusion360-win64.msi" \
        "https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/OctoPrint_for_Fusion360-win64.msi"
    download_extension "Ultimaker_Digital_Factory-win64.msi" \
        "https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/Ultimaker_Digital_Factory-win64.msi"
    echo -e "$(gettext "${GREEN}All tested extensions for Autodesk Fusion on Linux are downloaded!${NOCOLOR}")"
}

function download_extension {
    local EXTENSION_FILE_NAME="$1"
    local EXTENSION_FILE_URL="$2"
    local EXTENSION_FILE_DIRECTORY="$SELECTED_DIRECTORY/downloads/extensions/$EXTENSION_FILE_NAME"
    
    if [ -f "$EXTENSION_FILE_DIRECTORY" ]; then
        if find "$EXTENSION_FILE_DIRECTORY" -mtime +7 | grep -q .; then
            curl -L "$EXTENSION_FILE_URL" -o "$EXTENSION_FILE_DIRECTORY"
        fi
    else
        curl -L "$EXTENSION_FILE_URL" -o "$EXTENSION_FILE_DIRECTORY"
    fi
}

##############################################################################################################################################################################
# CHECK AND INSTALL WINE FOR THE INSTALLER:                                                                                                                                  #
##############################################################################################################################################################################

function check_and_install_wine() {
    # Check if wine is installed
    if [ -x "$(command -v wine)" ]; then
        echo "Wine is installed!"
        WINE_VERSION="$(wine --version  | cut -d ' ' -f1 | sed -e 's/wine-//' -e 's/-rc.*//')"
        WINE_VERSION_MAJOR_RELEASE="$(echo $WINE_VERSION | cut -d '.' -f1)"
        WINE_VERSION_MINOR_RELEASE="$(echo $WINE_VERSION | cut -d '.' -f2)"
        
        # Check if the installed wine version is at least 9.8 or higher (wine_version_series and wine_version_series_release)
        if [ "$WINE_VERSION_MAJOR_RELEASE" -ge 9 ] && [ "$WINE_VERSION_MINOR_RELEASE" -ge 8 ]; then
            echo "Wine version $WINE_VERSION is installed!"
            WINE_STATUS=1
        else
            echo "Wine version $WINE_VERSION is installed, but this version is too old and will be updated for you!"
            WINE_STATUS=0
        fi

    else
        echo "Wine is not installed on your system and will be installed for you!"
        WINE_STATUS=0
    fi

    # Check wine status 0 and install Wine version 
    if [ "$WINE_STATUS" -eq 0 ]; then
        DISTRO_VERSION=$(lsb_release -ds) # Check which Linux Distro is used! <-- Still in progress!!!
        if [[ $DISTRO_VERSION == *"Arch"*"Linux"* ]] || [[ $DISTRO_VERSION == *"Manjaro"*"Linux"* ]] || [[ $DISTRO_VERSION == *"EndeavourOS"* ]]; then
            echo "Installing Wine for Arch Linux ..."
            if grep -q '^\[multilib\]$' /etc/pacman.conf; then
                echo "Multilib is already enabled!"
                pkexec pacman -Syu --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
            else
                echo "Enabling Multilib ..."
                pkexec sh -c 'echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf && pacman -Syu --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp'
            fi
        elif [[ $DISTRO_VERSION == *"Debian"*"11"* ]]; then
            echo "Installing Wine for Debian 11 ..."
            pkexec bash -c 'sudo apt-get --allow-releaseinfo-change update
            sudo dpkg --add-architecture i386
            sudo apt-add-repository -r "deb https://dl.winehq.org/wine-builds/debian/ bullseye main"
            curl -s https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
            sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/debian/ bullseye main"
            sudo apt-get update
            sudo apt-get install -y p7zip p7zip-full p7zip-rar winbind cabextract
            sudo apt-get install -y --install-recommends winehq-staging'
        elif [[ $DISTRO_VERSION == *"Debian"*"12"* ]]; then
            echo "Installing Wine for Debian 12 ..."
            pkexec bash -c 'sudo apt-get --allow-releaseinfo-change update
            sudo dpkg --add-architecture i386
            sudo apt-add-repository -r "deb https://dl.winehq.org/wine-builds/debian/ bookworm main"
            curl -s https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
            sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/debian/ bookworm main"
            sudo apt-get update
            sudo apt-get install -y p7zip p7zip-full p7zip-rar winbind cabextract
            sudo apt-get install -y --install-recommends winehq-staging'
        elif [[ $DISTRO_VERSION == *"Debian"*"Testing"* ]] || [[ $DISTRO_VERSION == *"Debian"*"testing"* ]]; then
            echo "Installing Wine for Debian testing ..."
            pkexec bash -c 'sudo apt-get --allow-releaseinfo-change update
            sudo dpkg --add-architecture i386
            sudo apt-add-repository -r "deb https://dl.winehq.org/wine-builds/debian/ testing main"
            curl -s https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
            sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/debian/ testing main"
            sudo apt-get update
            sudo apt-get install -y p7zip p7zip-full p7zip-rar winbind cabextract
            sudo apt-get install -y --install-recommends winehq-staging'
        elif [[ $DISTRO_VERSION == *"Ubuntu"*"20.04"* ]]; then
            echo "Installing Wine for Ubuntu 20.04 ..."
            pkexec bash -c 'sudo dpkg --add-architecture i386
            curl -s https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
            sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ focal main"
            sudo apt-get update
            sudo apt-get install -y p7zip p7zip-full p7zip-rar winbind cabextract
            sudo apt-get install -y --install-recommends winehq-staging'
        elif [[ $DISTRO_VERSION == *"Ubuntu"*"22.04"* ]]; then
            echo "Installing Wine for Ubuntu 22.04 ..."
            pkexec bash -c 'sudo dpkg --add-architecture i386
            curl -s https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
            sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ jammy main"
            sudo apt-get update &&
            sudo apt-get install -y p7zip p7zip-full p7zip-rar winbind cabextract
            sudo apt-get install -y --install-recommends winehq-staging'
        elif [[ $DISTRO_VERSION == *"Ubuntu"*"24.04"* ]]; then
            echo "Installing Wine for Ubuntu 24.04 ..."
            pkexec bash -c 'sudo dpkg --add-architecture i386
            curl -s https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add -
            sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ impish main"
            sudo apt-get update &&
            sudo apt-get install -y p7zip p7zip-full p7zip-rar winbind cabextract
            sudo apt-get install -y --install-recommends winehq-staging'
        elif [[ $DISTRO_VERSION == *"Fedora"*"40"* ]]; then
            echo "Installing Wine for Fedora 40 ..."
            # show a password prompt for the user to enter the root password with pkexec
            pkexec bash -c "dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/40/winehq.repo && dnf install -y p7zip p7zip-plugins winehq-staging cabextract"
        elif [[ $DISTRO_VERSION == *"Fedora"*"Rawhide"* ]]; then
            echo "Installing Wine for Fedora rawhide ..."
            pkexec bash -c "dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/rawhide/winehq.repo && dnf install -y p7zip p7zip-plugins winehq-staging cabextract"
        elif [[ $DISTRO_VERSION == *"Gentoo"* ]]; then
            echo "Installing Wine for Gentoo ..."
            pkexec emerge -av p7zip wine cabextract
        elif [[ $DISTRO_VERSION == *"openSUSE"*"15.6"* ]]; then
            echo "Installing Wine for openSUSE 15.6 ..."
            pkexec bash -c 'sudo zypper addrepo -cfp 90 "https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.6/" wine
            sudo zypper refresh
            sudo zypper install -y p7zip-full wine cabextract'
        elif [[ $DISTRO_VERSION == *"openSUSE"*"Tumbleweed"* ]]; then
            echo "Installing Wine for openSUSE tumbleweed ..."
            pkexec bash -c 'sudo zypper addrepo -cfp 90 "https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/" wine
            sudo zypper refresh
            sudo zypper install -y p7zip-full wine cabextract'
        elif [[ $DISTRO_VERSION == *"Red Hat Enterprise Linux"*"8"* ]]; then
            echo "Installing Wine for RHEL 8 ..."
            pkexec bash -c 'sudo subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms
            sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
            sudo dnf upgrade
            sudo dnf install -y p7zip p7zip-plugins winehq-staging cabextract'
        elif [[ $DISTRO_VERSION == *"Red Hat Enterprise Linux"*"9"* ]]; then
            echo "Installing Wine for RHEL 9 ..."
            pkexec bash -c 'sudo subscription-manager repos --enable codeready-builder-for-rhel-9-x86_64-rpms
            sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
            sudo dnf upgrade
            sudo dnf install -y p7zip p7zip-plugins winehq-staging cabextract'
        elif [[ $DISTRO_VERSION == *"Solus"* ]]; then
            echo "Installing Wine for Solus ..."
            pkexec eopkg install -y p7zip p7zip-plugins winehq-staging cabextract
        elif [[ $DISTRO_VERSION == *"Void"* ]]; then
            echo "Installing Wine for Void Linux ..."
            pkexec xbps-install -Syu --yes p7zip p7zip-plugins wine cabextract
        elif [[ $DISTRO_VERSION == *"NixOS"* ]] || [[ $DISTRO_VERSION == *"nixos"* ]]; then
            echo "Installing Wine for NixOS ..."
            pkexec nix-env -iA nixos.p7zip nixos.wine nixos.cabextract nixos.samba nixos.ppp nixos.winetricks --yes
        # Add more distributions and versions here ...
        # elif ...
        else
            echo "Error: Your Linux distribution and version are not supported."
        fi
    fi
}


##############################################################################################################################################################################
# HELPER FUNCTION FOR THE LOGIN CALLBACKS TO THE IDENTITY MANAGER:                                                                                                           #
##############################################################################################################################################################################

# Helper function for the following function. The AdskIdentityManager.exe can be installed 
# into a variable alphanumeric folder.
# This function finds that folder alphanumeric folder name.
function determine_variable_folder_name_for_identity_manager {
    echo "Searching for the variable location of the Autodesk Fusion identity manager..."
    IDENT_MAN_PATH=$(find "$SELECTED_DIRECTORY/wineprefixes/default" -name 'AdskIdentityManager.exe')
    # Get the dirname of the identity manager's alphanumeric folder.
    # With the full path of the identity manager, go 2 folders up and isolate the folder name.
    IDENT_MAN_VARIABLE_DIRECTORY=$(basename "$(dirname "$(dirname "$IDENT_MAN_PATH")")")
}

########################################################################################

# Load the icons and .desktop-files:
function autodesk_fusion_shortcuts_load {
    # Create a .desktop file (launcher.sh) for Autodesk Fusion!
    curl -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/resource/graphics/autodesk_fusion.svg -o "$SELECTED_DIRECTORY/resources/graphics/autodesk_fusion.svg"
    cat >> "$HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk Fusion.desktop" << EOF
[Desktop Entry]
Name=Autodesk Fusion
GenericName=CAD Application
GenericName[cs]=Aplikace CAD
GenericName[de]=CAD-Anwendung
GenericName[es]=Aplicación CAD
GenericName[fr]=Application CAO
GenericName[it]=Applicazione CAD
GenericName[ja]=CADアプリケーション
GenericName[ko]=CAD 응용
GenericName[zh_CN]=计算机辅助设计应用
Comment=Autodesk Fusion is a cloud-based 3D modeling, CAD, CAM, and PCB software platform for product design and manufacturing.
Comment[cs]=Autodesk Fusion je cloudová platforma pro 3D modelování, CAD, CAM a PCB určená k navrhování a výrobě produktů.
Comment[de]=Autodesk Fusion ist eine cloudbasierte Softwareplattform für Modellierung, CAD, CAM, CAE und Leiterplatten in 3D für Produktdesign und Fertigung.
Comment[es]=Autodesk Fusion es una plataforma de software de modelado 3D, CAD, CAM y PCB basada en la nube destinada al diseño y la fabricación de productos.
Comment[fr]=Autodesk Fusion est une plate-forme logicielle 3D cloud de modélisation, de CAO, de FAO, d’IAO et de conception de circuits imprimés destinée à la conception et à la fabrication de produits.
Comment[it]=Autodesk Fusion è una piattaforma software di modellazione 3D, CAD, CAM, CAE e PCB basata sul cloud per la progettazione e la realizzazione di prodotti.
Comment[ja]=Autodesk Fusion、製品の設計と製造のためのクラウドベースの3Dモデリング、CAD、CAM、およびPCBソフトウェアプラットフォームです。
Comment[ko]=Autodesk Fusion 제품 설계 및 제조를 위한 클라우드 기반 3D 모델링, CAD, CAM 및 PCB 소프트웨어 플랫폼입니다.
Comment[zh_CN]=Autodesk Fusion 是一个基于云的 3D 建模、CAD、CAM 和 PCB 软件平台，用于产品设计和制造。
Exec=$SELECTED_DIRECTORY/bin/autodesk_fusion_launcher.sh
Type=Application
Categories=Education;Engineering;
StartupNotify=true
Icon=$SELECTED_DIRECTORY/resources/graphics/autodesk_fusion.svg
Terminal=false
Path=$SELECTED_DIRECTORY/bin
EOF

    # Set the permissions for the .desktop file to read-only
    chmod 444 "$HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk Fusion.desktop"

    # Execute function
    determine_variable_folder_name_for_identity_manager

    #Create mimetype link to handle web login call backs to the Identity Manager
    cat >> $HOME/.local/share/applications/adskidmgr-opener.desktop << EOL
[Desktop Entry]
Type=Application
Name=adskidmgr Scheme Handler
Exec=sh -c 'env WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" wine "$(find $SELECTED_DIRECTORY/wineprefixes/default/ -name "AdskIdentityManager.exe" | head -1 | xargs -I '{}' echo {})" "%u"'
StartupNotify=false
MimeType=x-scheme-handler/adskidmgr;
EOL

    #Set the permissions for the .desktop file to read-only
    chmod 444 $HOME/.local/share/applications/adskidmgr-opener.desktop
    
    #Set the mimetype handler for the Identity Manager
    xdg-mime default adskidmgr-opener.desktop x-scheme-handler/adskidmgr

    #Disable Debug messages on regular runs, we dont have a terminal, so speed up the system by not wasting time prining them into the Void
    sed -i 's/=env WINEPREFIX=/=env WINEDEBUG=-all env WINEPREFIX=/g' "$HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk Fusion.desktop"

    # Download some script files for Autodesk Fusion 360!
    curl -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/data/autodesk_fusion_launcher.sh -o "$SELECTED_DIRECTORY/bin"
    chmod +x "$SELECTED_DIRECTORY/bin/autodesk_fusion_launcher.sh"
}

###############################################################################################################################################################

function dxvk_opengl_1 {
    if [[ $GPU_DRIVER = "DXVK" ]]; then
        WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" sh "$SELECTED_DIRECTORY/bin/winetricks" -q dxvk
        curl -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/resource/video_driver/dxvk/DXVK.reg -o "$SELECTED_DIRECTORY/drive_c/users/$USER/Downloads/DXVK.reg"
        # Add the "return"-option. Here you can read more about it -> https://github.com/koalaman/shellcheck/issues/592
        cd "$SELECTED_DIRECTORY/drive_c/users/$USER/Downloads" || return
        WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" wine regedit.exe DXVK.reg
    fi
}

function dxvk_opengl_2 {
    if [[ $GPU_DRIVER = "DXVK" ]]; then
        curl -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/resource/video_driver/dxvk/NMachineSpecificOptions.xml -o "NMachineSpecificOptions.xml"
    else
        curl -L https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/resource/video_driver/opengl/NMachineSpecificOptions.xml -o "NMachineSpecificOptions.xml"
    fi
}

###############################################################################################################################################################

# Execute the installation of Autodesk Fusion
function autodesk_fusion_run_install_client {
    cd "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Downloads"
    #WINEPREFIX="$selected_directory/wineprefixes/default" timeout -k 5m 1m wine "$selected_directory/wineprefixes/default/drive_c/users/$USER/Downloads/Fusion360Clientinstaller.exe" --quiet
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" timeout -k 10m 9m wine "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Downloads/FusionClientInstaller.exe" --quiet
    sleep 5s
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" timeout -k 5m 1m wine "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Downloads/FusionClientInstaller.exe" --quiet
}

###############################################################################################################################################################

# Patch the Qt6WebEngineCore.dll to fix the login issue and other issues
function autodesk_fusion_patch_qt6webenginecore {
    # Find the Qt6WebEngineCore.dll file in the Autodesk Fusion directory
    QT6_WEBENGINECORE=$(find "$SELECTED_DIRECTORY/wineprefixes/default" -name 'Qt6WebEngineCore.dll' -printf "%T+ %p\n" | sort -r 2>&1 | head -n 1 | sed -r 's/.+0000000000 (.+)/\1/')
    # Backup the Qt6WebEngineCore.dll file
    cp "$QT6_WEBENGINECORE" "$QT6_WEBENGINECORE.bak"
    # Patch the Qt6WebEngineCore.dll file
    echo -e "$(gettext "${YELLOW}Patching the Qt6WebEngineCore.dll file for Autodesk Fusion ...${NOCOLOR}")"
    sleep 2
    # Copy the patched Qt6WebEngineCore.dll file to the Autodesk Fusion directory
    cp "$SELECTED_DIRECTORY/downloads/Qt6WebEngineCore.dll" "$QT6_WEBENGINECORE"
    echo -e "$(gettext "${GREEN}The Qt6WebEngineCore.dll file is patched successfully!${NOCOLOR}")"
}      

###############################################################################################################################################################

# Wine configuration for Autodesk Fusion
function wine_autodesk_fusion_install() {
    # Note that the winetricks sandbox verb merely removes the desktop integration and Z: drive symlinks and is not a "true" sandbox.
    # It protects against errors rather than malice. It's useful for, e.g., keeping games from saving their settings in random subdirectories of your home directory.
    # But it still ensures that wine, for example, no longer has access permissions to Home!
    # For this reason, the EXE files must be located directly in the Wineprefix folder!

    mkdir -p "$SELECTED_DIRECTORY/wineprefixes/default"
    cd "$SELECTED_DIRECTORY/wineprefixes/default" || return
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" sh "$SELECTED_DIRECTORY/bin/winetricks" -q sandbox
    sleep 5s
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" sh "$SELECTED_DIRECTORY/bin/winetricks" -q sandbox
    sleep 5s
    # We must install some packages!
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" sh "$SELECTED_DIRECTORY/bin/winetricks" -q atmlib gdiplus arial corefonts cjkfonts dotnet452 msxml4 msxml6 vcrun2017 fontsmooth=rgb winhttp win10
    # We must install cjkfonts again then sometimes it doesn't work in the first time!
    sleep 5s
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" sh "$SELECTED_DIRECTORY/bin/winetricks" -q cjkfonts
    # We must set to Windows 10 or 11 again because some other winetricks sometimes set it back to Windows XP!
    sleep 5s
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" sh "$SELECTED_DIRECTORY/bin/winetricks" -q win11
    # Remove tracking metrics/calling home
    sleep 5s
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "adpclientservice.exe" /t REG_SZ /d "" /f
    # Navigation bar does not work well with anything other than the wine builtin DX9
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "AdCefWebBrowser.exe" /t REG_SZ /d builtin /f
    # Use Visual Studio Redist that is bundled with the application
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "msvcp140" /t REG_SZ /d native /f
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "mfc140u" /t REG_SZ /d native /f
    # Fixed the problem with the bcp47langs issue and now the login works again!
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" wine reg add "HKCU\Software\Wine\DllOverrides" /v "bcp47langs" /t REG_SZ /d "" /f
    # Download and install WebView2 to handle Login attempts, required even though we redirect to your default browser
    sleep 5s
    cp "$SELECTED_DIRECTORY/downloads/WebView2installer.exe" "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Downloads/WebView2installer.exe"
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" wine "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Downloads/WebView2installer.exe" /silent /install
    # Pre-create shortcut directory for latest re-branding Microsoft Edge WebView2
    mkdir -p "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/AppData/Roaming/Microsoft/Internet Explorer/Quick Launch/User Pinned/"
    dxvk_opengl_1
    cp "$SELECTED_DIRECTORY/downloads/FusionClientInstaller.exe" "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Downloads"
    autodesk_fusion_run_install_client
    mkdir -p "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options"
    cd "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options" || return
    dxvk_opengl_2
    mkdir -p "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/AppData/Local/Autodesk/Neutron Platform/Options"
    cd "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/AppData/Local/Autodesk/Neutron Platform/Options" || return
    dxvk_opengl_2
    mkdir -p "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options"
    cd "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options" || return
    dxvk_opengl_2
    cd "$SELECTED_DIRECTORY/bin" || return
}

###############################################################################################################################################################

# Check and install the selected extensions
function wine_autodesk_fusion_install_extensions() {
    if [[ "$SELECTED_EXTENSIONS" == *"CzechlocalizationforF360"* ]]; then
        autodesk_fusion_extension_czech_locale
    fi
    if [[ "$SELECTED_EXTENSIONS" == *"HP3DPrintersforAutodesk®Fusion®"* ]]; then
        autodesk_fusion_extension_hp_3dprinter_connector
    fi
    if [[ "$SELECTED_EXTENSIONS" == *"MarkforgedforAutodesk®Fusion®"* ]]; then
        autodesk_fusion_extension_markforged
    fi
    if [[ "$SELECTED_EXTENSIONS" == *"OctoPrintforAutodesk®Fusion360™"* ]]; then
        autodesk_fusion_extension_octoprint
    fi
    if [[ "$SELECTED_EXTENSIONS" == *"UltimakerDigitalFactoryforAutodeskFusion360™"* ]]; then
        autodesk_fusion_extension_ultimaker_digital_factory
    fi
}

function autodesk_fusion_extension_czech_locale {
    run_install_extension_client "Ceska_lokalizace_pro_Autodesk_Fusion.exe"
}

function autodesk_fusion_extension_hp_3dprinter_connector {
    run_install_extension_client "HP_3DPrinters_for_Fusion360-win64.msi"
}

function autodesk_fusion_extension_markforged {
    run_install_extension_client "Markforged_for_Fusion360-win64.msi"
}

function autodesk_fusion_extension_octoprint {
    run_install_extension_client "OctoPrint_for_Fusion360-win64.msi"
}

function autodesk_fusion_extension_ultimaker_digital_factory {
    run_install_extension_client "Ultimaker_Digital_Factory-win64.msi"
}

function run_install_extension_client {
    local EXTENSION_FILE="$1"
    cp "$SELECTED_DIRECTORY/extensions/$EXTENSION_FILE" "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Downloads"
    if [[ "$EXTENSION_FILE" == *.msi ]]; then
        cd "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Downloads" || return
        WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" wine msiexec /i "$EXTENSION_FILE"
    else
        cd "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Downloads" || return
        WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" wine "$EXTENSION_FILE"
    fi
}

###############################################################################################################################################################

function autodesk_fusion_safe_logfile() {
    # Log the Wineprefixes
    echo "$GPU_DRIVER" >> "$SELECTED_DIRECTORY/logs/wineprefixes.log"
    echo "$SELECTED_DIRECTORY" >> "$SELECTED_DIRECTORY/logs/wineprefixes.log"
    echo "$SELECTED_DIRECTORY/wineprefixes/default" >> "$SELECTED_DIRECTORY/logs/wineprefixes.log"
}

##############################################################################################################################################################################
# ACTIVATE THE WINDOW NOT RESPONDING DIALOG:                                                                                                                                 #
##############################################################################################################################################################################

function reset_window_not_responding_dialog() {
    # Check if desktop environment is GNOME
    if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
        # Reset the "Window not responding" Dialog in GNOME
        echo -e "$(gettext "${GREEN}The 'Window not responding' Dialog in GNOME will be reset!")${NOCOLOR}"
        gsettings reset org.gnome.mutter check-alive-timeout
    fi
}

##############################################################################################################################################################################
# RUN AUTODESK FUSION:                                                                                                                                                       #
##############################################################################################################################################################################

function run_wine_autodesk_fusion() {
    # Execute the Autodesk Fusion 360
    echo -e "$(gettext "${GREEN}Starting Autodesk Fusion 360 ...${NOCOLOR}")"
    sleep 2
    source "$SELECTED_DIRECTORY/bin/autodesk_fusion_launcher.sh"
}

##############################################################################################################################################################################

check_required_packages
download_translations
check_option "$SELECTED_OPTION"
