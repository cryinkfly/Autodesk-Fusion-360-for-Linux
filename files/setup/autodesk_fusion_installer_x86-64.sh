#!/usr/bin/env bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This file install Autodesk Fusion on your system.                                  #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2025                                                                          #
# Time/Date:    15:15/31.08.2025                                                                   #
# Version:      2.0.4-Alpha                                                                        #
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

REPO_URL="https://raw.githubusercontent.com/Lolig4/Autodesk-Fusion-360-for-Linux/main"

# URL to download translations po. files <-- Still in progress!!!
UPDATER_TRANSLATIONS_URL="$REPO_URL/files/setup/locale/update-locale.sh"
declare -A TRANSLATION_URLS=(
    ["cs_CZ"]="$REPO_URL/files/setup/locale/cs_CZ/LC_MESSAGES/autodesk_fusion.po"
    ["de_DE"]="$REPO_URL/files/setup/locale/de_DE/LC_MESSAGES/autodesk_fusion.po"
    ["en_US"]="$REPO_URL/files/setup/locale/en_US/LC_MESSAGES/autodesk_fusion.po"
    ["es_ES"]="$REPO_URL/files/setup/locale/es_ES/LC_MESSAGES/autodesk_fusion.po"
    ["fr_FR"]="$REPO_URL/files/setup/locale/fr_FR/LC_MESSAGES/autodesk_fusion.po"
    ["it_IT"]="$REPO_URL/files/setup/locale/it_IT/LC_MESSAGES/autodesk_fusion.po"
    ["ja_JP"]="$REPO_URL/files/setup/locale/ja_JP/LC_MESSAGES/autodesk_fusion.po"
    ["ko_KR"]="$REPO_URL/files/setup/locale/ko_KR/LC_MESSAGES/autodesk_fusion.po"
    ["pl_PL"]="$REPO_URL/files/setup/locale/pl_PL/LC_MESSAGES/autodesk_fusion.po"
    ["pt_BR"]="$REPO_URL/files/setup/locale/pt_BR/LC_MESSAGES/autodesk_fusion.po"
    ["tr_TR"]="$REPO_URL/files/setup/locale/tr_TR/LC_MESSAGES/autodesk_fusion.po"
    ["zh_CN"]="$REPO_URL/files/setup/locale/zh_CN/LC_MESSAGES/autodesk_fusion.po"
    ["zh_TW"]="$REPO_URL/files/setup/locale/zh_TW/LC_MESSAGES/autodesk_fusion.po"
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
QT6_WEBENGINECORE_URL="$REPO_URL/files/extras/patched-dlls/Qt6WebEngineCore-06-2025.7z"

# URL to download the patched siappdll.dll file
SIAPPDLL_URL="$REPO_URL/files/extras/patched-dlls/siappdll.dll"

##############################################################################################################################################################################
# CHECK THE REQUIRED PACKAGES FOR THE INSTALLER:                                                                                                                             #
##############################################################################################################################################################################

function check_required_packages() {
    # Extracting the Linux distribution ID and version
    DISTRO=$(grep "^ID=" /etc/*-release | cut -d'=' -f2 | tr -d '"')
    VERSION=$(grep "^VERSION_ID=" /etc/*-release | cut -d'=' -f2 | tr -d '"')
    DISTRO_VERSION="$DISTRO $VERSION"

    # Example required commands, now including "xrandr" and "bc"
    REQUIRED_COMMANDS=("curl" "lsb_release" "glxinfo" "pkexec" "wget" "xdg-open" "ls" "cat" "echo" "awk" "7z" "cabextract" "samba" "wbinfo" "systemctl" "bc" "xrandr" "mokutil")

    # Array to store missing commands
    MISSING_COMMANDS=()

    # Check for required commands
    for cmd in "${REQUIRED_COMMANDS[@]}"; do
        echo -e "${YELLOW}Checking for required command: ${cmd} ...${NOCOLOR}"
        if command -v "$cmd" &>/dev/null; then
            case "$cmd" in
                7z)
                    if ! 7z &>/dev/null; then
                        echo -e "${RED}The required command (${cmd}) is not available!${NOCOLOR}"
                        MISSING_COMMANDS+=("$cmd")
                    else
                        echo -e "${GREEN}The required command (${cmd}) is available!${NOCOLOR}"
                    fi
                    ;;
                cabextract)
                    if ! cabextract --version &>/dev/null; then
                        echo -e "${RED}The required command (${cmd}) is not available!${NOCOLOR}"
                        MISSING_COMMANDS+=("$cmd")
                    else
                        echo -e "${GREEN}The required command (${cmd}) is available!${NOCOLOR}"
                    fi
                    ;;
                samba)
                    if ! samba --version &>/dev/null; then
                        echo -e "${RED}The required command (${cmd}) is not available!${NOCOLOR}"
                        MISSING_COMMANDS+=("$cmd")
                    else
                        echo -e "${GREEN}The required command (${cmd}) is available!${NOCOLOR}"
                    fi
                    ;;
                wbinfo)
                    if ! wbinfo --version &>/dev/null; then
                        echo -e "${RED}The required command (${cmd}) is not available!${NOCOLOR}"
                        MISSING_COMMANDS+=("$cmd")
                    else
                        echo -e "${GREEN}The required command (${cmd}) is available!${NOCOLOR}"
                    fi
                    ;;
                systemctl)
                    if ! systemctl is-active --quiet spacenavd; then
                        echo -e "${RED}The service spacenavd is not active!${NOCOLOR}"
                        MISSING_COMMANDS+=("spacenavd (service)")
                    else
                        echo -e "${GREEN}The service spacenavd is active!${NOCOLOR}"
                    fi
                    ;;
                xrandr)
                    if ! xrandr &>/dev/null; then
                        echo -e "${RED}The required command (${cmd}) is not available!${NOCOLOR}"
                        MISSING_COMMANDS+=("$cmd")
                    else
                        echo -e "${GREEN}The required command (${cmd}) is available!${NOCOLOR}"
                    fi
                    ;;

                mokutil)
                    if ! mokutil --list-enrolled &>/dev/null; then
                        echo -e "${RED}The required command (${cmd}) is not available!${NOCOLOR}"
                        MISSING_COMMANDS+=("$cmd")
                    else
                        echo -e "${GREEN}The required command (${cmd}) is available!${NOCOLOR}"
                    fi
                    ;;
                *)
                    echo -e "${GREEN}The required command (${cmd}) is available!${NOCOLOR}"
                    ;;
            esac
        else
            echo -e "${RED}The required command (${cmd}) is not available!${NOCOLOR}"
            MISSING_COMMANDS+=("$cmd")
        fi
    done

    # If there are missing commands, install them
    if [ ${#MISSING_COMMANDS[@]} -gt 0 ]; then
        install_required_packages
    else
        echo -e "${GREEN}All required commands are available!${NOCOLOR}"
    fi

    # Check if Firefox is installed
    firefox_version=$(get_firefox_version)

    # Check if Firefox is installed via Snap and prompt user to install DEB version
    check_install_firefox_deb
}

##############################################################################################################################################################################
# INSTALLATION OF THE REQUIRED PACKAGES FOR THE INSTALLER:                                                                                                                   #
##############################################################################################################################################################################

function install_required_packages {
    echo -e "$(gettext "${YELLOW}The installer will install the required packages for the installation!")${NOCOLOR}"
    echo -e "$(gettext "${RED}Missing package: ${cmd}")${NOCOLOR}"
    sleep 2
        if [[ $DISTRO_VERSION == *"arch"* ]] || [[ $DISTRO_VERSION == *"manjaro"* ]] || [[ $DISTRO_VERSION == *"endeavouros"* ]] || [[ $DISTRO_VERSION == *"cachyos"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo pacman -S gawk cabextract coreutils curl lsb-release mesa-demos mesa-utils p7zip polkit samba wget libspnav xdg-utils bc xorg-xrandr mokutil --noconfirm
            sudo systemctl enable spacenavd
            sudo systemctl start spacenavd
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"debian"* ]] || [[ $DISTRO_VERSION == *"ubuntu"* ]] \
        || [[ $DISTRO_VERSION == *"mint"* ]] || [[ $DISTRO_VERSION == *"pop"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo apt-get install -y gawk cabextract coreutils curl lsb-release mesa-utils p7zip p7zip-full p7zip-rar policykit-1 samba spacenavd winbind wget xdg-utils bc x11-xserver-utils
            sudo systemctl enable spacenavd
            sudo systemctl start spacenavd
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"fedora"* ]] || [[ $DISTRO_VERSION == *"nobara"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo dnf install -y cabextract coreutils curl gawk lsb_release mesa-demos p7zip p7zip-plugins polkit samba-dc samba-winbind samba-winbind-clients spacenavd wget xdg-utils bc xrandr
            sudo systemctl enable spacenavd
            sudo systemctl start spacenavd
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"gentoo"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo emerge -q app-admin/samba app-misc/spacenavd app-arch/cabextract app-arch/p7zip net-misc/curl net-misc/wget sys-apps/coreutils sys-apps/gawk sys-apps/lsb-release sys-auth/polkit x11-apps/mesa-progs x11-misc/xdg-utils sys-apps/bc x11-apps/xrandr
            sudo rc-update add spacenavd default
            sudo /etc/init.d/spacenavd start
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"nixos"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo nix-env -iA gawk nixos.cabextract nixos.coreutils nixos.curl nixos.lsb_release nixos.mesa-utils nixos.p7zip nixos.polkit nixos.samba nixos.spacenavd nixos.wget nixos.winbind nixos.xdg_utils nixos.bc nixos.xrandr
            sudo systemctl enable spacenavd
            sudo systemctl start spacenavd
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"opensuse"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo zypper install -y cabextract coreutils curl gawk lsb-release Mesa-demo-x p7zip-full polkit samba samba-client samba-winbind spacenavd wget wine xdg-utils bc xrandr
            sudo systemctl enable spacenavd
            sudo systemctl start spacenavd
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"red"*"hat"*"enterprise"* ]] || [[ $DISTRO_VERSION == *"alma"* ]] || [[ $DISTRO_VERSION == *"rocky"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            if command -v dnf &> /dev/null; then # Use dnf for newer distributions
                sudo dnf install -y cabextract coreutils curl gawk lsb_release mesa-demos p7zip p7zip-plugins polkit samba-dc samba-winbind samba-winbind-clients spacenavd wget xdg-utils bc xrandr
            else  # Use yum for older distributions
                sudo yum install -y cabextract coreutils curl gawk lsb_release mesa-demos p7zip p7zip-plugins polkit samba-dc samba-winbind samba-winbind-clients spacenavd wget xdg-utils bc xrandr
            fi
            sudo systemctl enable spacenavd
            sudo systemctl start spacenavd
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"solus"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo eopkg -y install gawk cabextract coreutils curl lsb-release mesa-utils p7zip p7zip-plugins spacenavd polkit wget winbind xdg-utils bc xrandr
            sudo systemctl enable spacenavd
            sudo systemctl start spacenavd
            echo -e "$(gettext "${GREEN}All required packages for the installer are installed!")${NOCOLOR}"
            sleep 2
        elif [[ $DISTRO_VERSION == *"void"* ]]; then
            echo -e "$(gettext "${YELLOW}All required packages for the installer will be installed!")${NOCOLOR}"
            sleep 2
            sudo xbps-install -Sy gawk cabextract coreutils curl lsb-release mesa-demos p7zip-full polkit samba-winbind spacenavd wget xdg-utils bc xrandr
            sudo ln -s /usr/sbin/spacenavd /etc/sv/spacenavd
            sudo sv enable spacenavd
            sudo sv start spacenavd
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
            create_data_structure
            check_secure_boot
            check_ram
            check_gpu_driver
            check_gpu_vram
            check_disk_space
            download_files
            check_and_install_wine
            wine_autodesk_fusion_install
            autodesk_fusion_patch_qt6webenginecore
            autodesk_fusion_patch_siappdll
            wine_autodesk_fusion_install_extensions
            autodesk_fusion_shortcuts_load
            autodesk_fusion_safe_logfile
            reset_window_not_responding_dialog
            xdg-open "https://cryinkfly.com/sponsors/"
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
# CHECK IF SECURE BOOT IS DEACTIVATED ON A LINUX SYSTEM FOR LOADING DRIVER MODULES (FOR EXAMPLE: NVIDIA GPU DRIVER):                                                          #
##############################################################################################################################################################################

# Function to check if Secure Boot is activated
function check_secure_boot {
    if ! command -v mokutil &> /dev/null; then
        echo "${RED} mokutil command not found. Please install it to check Secure Boot status.${NOCOLOR}"
        exit 1
    fi

    # Check if Secure Boot is enabled
    if mokutil --sb-state | grep -q 'Secure Boot enabled'; then
        echo "Secure Boot is enabled."
        SECURE_BOOT="1"
    else
        echo "Secure Boot is not enabled."
        SECURE_BOOT="0"
    fi
}

##############################################################################################################################################################################
# CHECKING THE MINIMUM RAM (RANDOM ACCESS MEMORY) REQUIREMENT:                                                                                                               #
##############################################################################################################################################################################

function check_ram {
    # Get total RAM space in kilobytes
    GET_RAM_KILOBYTES=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    
    # Check if the total memory is greater than 4000 Megabytes
    if awk "BEGIN {exit !($GET_RAM_KILOBYTES > 4000 * 1024)}"; then
        CONVERT_RAM_GIGABYTES=$(awk "BEGIN {printf \"%.2f\", $GET_RAM_KILOBYTES / 1024 / 1024}")
        echo -e "$(gettext "${GREEN}The total RAM (Random Access Memory) is greater than 4 GByte ($CONVERT_RAM_GIGABYTES GByte) and Autodesk Fusion will run more stable later!${NOCOLOR}")"
    else
        CONVERT_RAM_GIGABYTES=$(awk "BEGIN {printf \"%.2f\", $GET_RAM_KILOBYTES / 1024 / 1024}")
        echo -e "$(gettext "${RED}The total RAM (Random Access Memory) is not greater than 4 GByte ($CONVERT_RAM_GIGABYTES GByte) and Autodesk Fusion may run unstable later with insufficient RAM memory!${NOCOLOR}")"
        read -p "$(gettext "${YELLOW}Are you sure you want to continue with the installation? (y/n)${NOCOLOR}")" yn
        case $yn in 
            y|Y ) 
                echo -e "$(gettext "${YELLOW}Continuing with the installation...${NOCOLOR}")"
                ;;
            n|N ) 
                echo -e "$(gettext "${RED}The installer has been terminated!${NOCOLOR}")"
                exit
                ;;
            * ) 
                echo -e "$(gettext "${RED}Invalid input! The installer was terminated.${NOCOLOR}")"
                rm -rf "$SELECTED_DIRECTORY"
                exit 1
                ;;
        esac
    fi
}

##############################################################################################################################################################################
# CHECK GPU DRIVER FOR THE INSTALLER:                                                                                                                                        #
##############################################################################################################################################################################

function check_gpu_driver {
    echo -e "$(gettext "${YELLOW}Checking the GPU drivers for the installer...${NOCOLOR}")"
    
    if [[ $SECURE_BOOT == "0" ]]; then
        # If Secure Boot is disabled, check NVIDIA GPU
        if nvidia-smi &>/dev/null; then
            NVIDIA_PRESENT=true
            NVIDIA_VRAM=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader,nounits | head -n1)
            echo -e "$(gettext "${GREEN}NVIDIA GPU detected with ${NVIDIA_VRAM}MB VRAM${NOCOLOR}")"
        fi
    fi

    INTEL_AMD_GPU=$(glxinfo | grep "OpenGL vendor string" | cut -d: -f2 | tr -d ' ')
    INTEL_AMD_VRAM=$(glxinfo | grep -i "Video memory" | grep -Eo '[0-9]+MB' | grep -Eo '[0-9]+' | head -n1)

    if [[ $INTEL_AMD_GPU == "AMD" ]]; then
        AMD_PRESENT=true
        AMD_VRAM=$(glxinfo | grep -i "Video memory" | grep -Eo '[0-9]+MB' | grep -Eo '[0-9]+' | head -n1)
        echo -e "$(gettext "${GREEN}${INTEL_AMD_GPU} GPU recognized with ${AMD_VRAM}MB VRAM${NOCOLOR}")"
    elif [[ $INTEL_AMD_GPU == "Intel" ]]; then
        INTEL_PRESENT=true
        INTEL_VRAM=$(glxinfo | grep -i "Video memory" | grep -Eo '[0-9]+MB' | grep -Eo '[0-9]+' | head -n1)
        echo -e "$(gettext "${GREEN}${INTEL_AMD_GPU} GPU recognized with ${INTEL_VRAM}MB VRAM${NOCOLOR}")"
    fi

    if [[ $SECURE_BOOT == "1" && $NVIDIA_PRESENT ]]; then
        # If Secure Boot is enabled and the NVIDIA GPU is detected, the NVIDIA GPU should use OpenGL.
        GPU_DRIVER="OpenGL"
        GET_VRAM_MEGABYTES=$NVIDIA_VRAM
        echo -e "$(gettext "${GREEN}Secure Boot is enabled. The OpenGL GPU driver is being used for the NVIDIA GPU.${NOCOLOR}")"
    elif [[ $SECURE_BOOT == "0" ]]; then
        # If Secure Boot is disabled, handle GPU selection
        if [[ $NVIDIA_PRESENT && ($INTEL_PRESENT || $AMD_PRESENT) ]]; then
            echo -e "$(gettext "${YELLOW}MMultiple GPUs detected. Please select which one to use (default is DXVK):${NOCOLOR}")"
            echo "1) NVIDIA"
            echo "2) ${INTEL_AMD_GPU}"
            read -p "Enter your choice (1 or 2): " gpu_choice
            
            case $gpu_choice in
                1)
                    GPU_DRIVER="DXVK"
                    GET_VRAM_MEGABYTES=$NVIDIA_VRAM
                    echo -e "$(gettext "${GREEN}NVIDIA GPU selected. The DXVK GPU driver will be used for installation.${NOCOLOR}")"
                    ;;
                2)
                    GPU_DRIVER="OpenGL"
                    GET_VRAM_MEGABYTES=$INTEL_AMD_VRAM
                    echo -e "$(gettext "${GREEN}The OpenGL GPU fallback driver is used for the installation.${NOCOLOR}")"
                    ;;
                *)
                    GPU_DRIVER="OpenGL"
                    GET_VRAM_MEGABYTES=$INTEL_VRAM
                    ;;
            esac
        elif [[ $NVIDIA_PRESENT ]]; then
            GPU_DRIVER="DXVK"
            GET_VRAM_MEGABYTES=$NVIDIA_VRAM
            echo -e "$(gettext "${GREEN}The DXVK GPU driver is used for the installation.${NOCOLOR}")"
        elif [[ $AMD_PRESENT ]]; then
            GPU_DRIVER="DXVK"
            GET_VRAM_MEGABYTES=$AMD_VRAM
            echo -e "$(gettext "${GREEN}The DXVK GPU driver is used for the installation.${NOCOLOR}")"
        elif [[ $INTEL_PRESENT ]]; then
            GPU_DRIVER="OpenGL"
            GET_VRAM_MEGABYTES=$INTEL_VRAM
            echo -e "$(gettext "${GREEN}The OpenGL GPU fallback driver is used for the installation.${NOCOLOR}")"
        else
            echo -e "$(gettext "${RED}No GPU driver detected on your system!${NOCOLOR}")"
            GET_VRAM_MEGABYTES=0
        fi
    else
        echo -e "$(gettext "${RED}No GPU driver detected on your system!${NOCOLOR}")"
        GET_VRAM_MEGABYTES=0
    fi

    sleep 2

    # Get the current display resolution of the main monitor if more than one is connected.
    MONITOR_RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')

    # If the $MONITOR_RESOLUTION value is empty, set it to "1920x1080"
    if [ -z "$MONITOR_RESOLUTION" ]; then
        MONITOR_RESOLUTION="1920x1080"
    fi

    # Output the resolution
    echo -e "$(gettext "${GREEN}Main monitor resolution: $MONITOR_RESOLUTION ${NOCOLOR}")"

    sleep 2
}

##############################################################################################################################################################################
# CHECKING THE MINIMUM VRAM (VIDEO RAM) REQUIREMENT:                                                                                                                         #
##############################################################################################################################################################################

function check_gpu_vram {
    # Get the total memory of the graphics card in megabytes from check_gpu_driver

    if [ -z "$GET_VRAM_MEGABYTES" ]; then
        echo -e "$(gettext "${RED}Could not determine VRAM size.${NOCOLOR}")"
        exit 1
    fi
    
    # Check if the total memory is greater than 1000 Megabytes
    if awk -v vram="$GET_VRAM_MEGABYTES" 'BEGIN {exit !(vram > 1000)}'; then
        CONVERT_RAM_GIGABYTES=$(awk "BEGIN {printf \"%.2f\", $GET_VRAM_MEGABYTES / 1000}")
        echo -e "$(gettext "${GREEN}The total VRAM (Video RAM) is greater than 1 GByte (${CONVERT_RAM_GIGABYTES} GByte) and Autodesk Fusion will run more stable later!${NOCOLOR}")"
    else
        CONVERT_RAM_GIGABYTES=$(awk "BEGIN {printf \"%.2f\", $GET_VRAM_MEGABYTES / 1000}")
        echo -e "$(gettext "${RED}The total VRAM (Video RAM) is not greater than 1 GByte (${CONVERT_RAM_GIGABYTES} GByte) and Autodesk Fusion may run unstable later with insufficient VRAM memory!${NOCOLOR}")"
        read -p "$(gettext "${YELLOW}Are you sure you want to continue with the installation? (y/n)${NOCOLOR}")" yn
        case $yn in 
            y|Y ) echo -e "$(gettext "${GREEN}Continuing with the installation...${NOCOLOR}")";;
            n|N ) echo -e "$(gettext "${RED}The installer has been terminated!${NOCOLOR}")";
                  exit;;
            * ) echo -e "$(gettext "${RED}Invalid input. The installer has been terminated!${NOCOLOR}")";
                rm -rf "$SELECTED_DIRECTORY"
                exit 1;;
        esac
    fi
}

##############################################################################################################################################################################
# CHECKING THE MINIMUM DISK SPACE (DEFAULT: HOME-PARTITION) REQUIREMENT:                                                                                                     #
##############################################################################################################################################################################

function check_disk_space {
    # Get the free disk space in the selected directory
    GET_DISK_SPACE=$(df -h "$SELECTED_DIRECTORY" 2>/dev/null | awk 'NR==2 {print $4}')

    if [[ -z "$GET_DISK_SPACE" ]]; then
        echo -e "${RED}Failed to retrieve disk space information. Ensure the directory exists and try again.${NOCOLOR}"
        exit 1
    fi

    echo -e "$(gettext "${GREEN}The free disk memory size is: $GET_DISK_SPACE${NOCOLOR}")"

    # Extract numerical value and unit, and replace comma with dot
    DISK_SPACE_NUM=$(echo "$GET_DISK_SPACE" | sed 's/[A-Za-z]//g' | sed 's/,/./g')
    DISK_SPACE_UNIT=$(echo "$GET_DISK_SPACE" | sed 's/[0-9.,]//g')

    # Convert to gigabytes
    case $DISK_SPACE_UNIT in
        G) DISK_SPACE_GB=$DISK_SPACE_NUM ;;
        M) DISK_SPACE_GB=$(echo "scale=2; $DISK_SPACE_NUM / 1024" | bc) ;;
        T) DISK_SPACE_GB=$(echo "scale=2; $DISK_SPACE_NUM * 1024" | bc) ;;
        *) DISK_SPACE_GB=0 ;;
    esac

    # Check if the free disk space is greater than 10GB
    if (( $(echo "$DISK_SPACE_GB > 10" | bc -l) )); then
        echo -e "$(gettext "${GREEN}The free disk memory size is greater than 10GB.${NOCOLOR}")"
    else
        echo -e "$(gettext "${YELLOW}There is not enough disk free memory to continue installing Fusion on your system!${NOCOLOR}")"
        echo -e "$(gettext "${YELLOW}Make more space in your selected disk or select a different hard drive.${NOCOLOR}")"
        echo -e "$(gettext "${RED}The installer has been terminated!${NOCOLOR}")"
        exit 1
    fi
}

##############################################################################################################################################################################
# CHECK FIREFOX VERSION FOR THE INSTALLER:                                                                                                                                   #
##############################################################################################################################################################################

function get_firefox_version {
    if command -v firefox &>/dev/null; then
        firefox --version | grep -oP '\d+\.\d+(\.\d+)?'
    else
        echo "Firefox is not installed."
    fi
}

function is_snap_firefox_installed {
    if snap list | grep -q firefox; then
        return 0
    else
        return 1
    fi
}

function check_install_firefox_deb {
    # Function to check if Firefox is installed via Snap
    function is_snap_firefox_installed {
        snap list firefox &> /dev/null
        return $?
    }

    # Check if Firefox is installed via Snap
    if is_snap_firefox_installed; then
        echo "The installed version of Firefox is from Snap."
        echo "It is recommended to install the DEB version for better performance and compatibility."

        # Prompt user for action
        read -p "Do you want to uninstall the Snap version of Firefox and install the DEB version? (y/n): " choice

        if [[ "$choice" =~ ^[Yy]$ ]]; then
            echo "Proceeding with the uninstallation of the Snap version and installation of the DEB version..."

            # Uninstall Firefox Snap
            sudo snap remove -y firefox

            # Create an APT keyring directory if it doesn't exist
            sudo install -d -m 0755 /etc/apt/keyrings

            # Import the Mozilla APT repo signing key
            wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

            # Add Mozilla APT repo to sources.list
            echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee /etc/apt/sources.list.d/mozilla.list > /dev/null

            # Set package priority to ensure DEB version is default
            echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla

            # Update and install Firefox DEB version
            sudo apt update && sudo apt install -y firefox

            echo "Firefox DEB version installed successfully."
        else
            echo "No changes made. Firefox Snap version remains installed."
        fi
    else
        echo "The installed version of Firefox is not from Snap."
    fi
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
    # Download the patched siappdll.dll file
    curl -L "$SIAPPDLL_URL" -o "$SELECTED_DIRECTORY/downloads/siappdll.dll"
}

# Download an extension if it doesn't exist or is older than 7 days
function download_extensions_files {
    echo -e "$(gettext "${YELLOW}Downloading the tested extensions for Autodesk Fusion on Linux ...${NOCOLOR}")"
    download_extension "Ceska_lokalizace_pro_Autodesk_Fusion.exe" \
        "https://www.cadstudio.cz/dl/Ceska_lokalizace_pro_Autodesk_Fusion_360.exe"
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
        if [ "$WINE_VERSION_MAJOR_RELEASE" -gt 9 ] || ([ "$WINE_VERSION_MAJOR_RELEASE" -eq 9 ] && [ "$WINE_VERSION_MINOR_RELEASE" -ge 8 ]); then
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
        if [[ $DISTRO_VERSION == *"Arch"*"Linux"* ]] || [[ $DISTRO_VERSION == *"Manjaro"*"Linux"* ]] || [[ $DISTRO_VERSION == *"EndeavourOS"* ]] || [[ $DISTRO_VERSION == *"CachyOS"* ]]; then
            echo "Installing Wine for Arch Linux ..."
            if grep -q '^\[multilib\]$' /etc/pacman.conf; then
                echo "Multilib is already enabled!"
                pkexec bash -c '
                    pacman -R wine wine-mono wine_gecko winetricks --noconfirm
                    pacman -Syu --needed wine wine-mono wine_gecko winetricks'
            else
                echo "Enabling Multilib ..."
                pkexec sh -c '
                    echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
                    pacman -R wine wine-mono wine_gecko winetricks --noconfirm
                    pacman -Syu --needed wine wine-mono wine_gecko winetricks'
            fi
        elif [[ $DISTRO_VERSION == *"Debian"*"11"* ]]; then
            echo "Installing Wine for Debian 11 ..."
            pkexec bash -c '
                apt-get --allow-releaseinfo-change update
                dpkg --add-architecture i386
                rm /etc/apt/sources.list.d/wine* /etc/apt/sources.list.d/*wine* 2>/dev/null
                apt-key list | grep -A 2 "wine" | grep "pub" | awk "{print \$2}" | cut -d"/" -f2 | xargs -r apt-key del
                mkdir -pm755 /etc/apt/keyrings
                wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
                wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bullseye/winehq-bullseye.sources
                apt-get update
                apt-get remove wine* --purge
                apt-get autoremove -y
                apt-get install -y --install-recommends winehq-staging'
        elif [[ $DISTRO_VERSION == *"Debian"*"12"* ]]; then
            echo "Installing Wine for Debian 12 ..."
            pkexec bash -c '
                apt-get --allow-releaseinfo-change update
                dpkg --add-architecture i386
                rm /etc/apt/sources.list.d/wine* /etc/apt/sources.list.d/*wine* 2>/dev/null
                apt-key list | grep -A 2 "wine" | grep "pub" | awk "{print \$2}" | cut -d"/" -f2 | xargs -r apt-key del
                mkdir -pm755 /etc/apt/keyrings
                wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
                wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources
                apt-get update
                apt-get remove wine* --purge
                apt-get autoremove -y
                apt-get install -y --install-recommends winehq-staging'
        elif [[ $DISTRO_VERSION == *"Debian"*"Testing"* ]] || [[ $DISTRO_VERSION == *"Debian"*"testing"* ]]; then
            echo "Installing Wine for Debian testing ..."
            pkexec bash -c '
                apt-get --allow-releaseinfo-change update
                dpkg --add-architecture i386
                rm /etc/apt/sources.list.d/wine* /etc/apt/sources.list.d/*wine* 2>/dev/null
                apt-key list | grep -A 2 "wine" | grep "pub" | awk "{print \$2}" | cut -d"/" -f2 | xargs -r apt-key del
                mkdir -pm755 /etc/apt/keyrings
                wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
                wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources
                apt-get update
                apt-get remove wine* --purge
                apt-get autoremove -y
                apt-get install -y --install-recommends winehq-staging'
        elif [[ $DISTRO_VERSION == *"Ubuntu"*"20.04"* ]] || [[ $DISTRO_VERSION == *"Linux"*"Mint"*"20"* ]] || [[ $DISTRO_VERSION == *"Pop"*"OS"*"20.04"* ]] || [[ $DISTRO_VERSION == *"pop"*"20.04"* ]]; then
            echo "Installing Wine for Ubuntu 20.04 ..."
            pkexec bash -c '
                dpkg --add-architecture i386
                rm /etc/apt/sources.list.d/wine* /etc/apt/sources.list.d/*wine* 2>/dev/null
                apt-key list | grep -A 2 "wine" | grep "pub" | awk "{print \$2}" | cut -d"/" -f2 | xargs -r apt-key del
                mkdir -pm755 /etc/apt/keyrings
                wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
                wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/focal/winehq-focal.sources
                apt-get update
                apt-get remove wine* --purge
                apt-get autoremove -y
                apt-get install -y --install-recommends winehq-staging'
        elif [[ $DISTRO_VERSION == *"Ubuntu"*"22.04"* ]] || [[ $DISTRO_VERSION == *"Linux"*"Mint"*"21"* ]] || [[ $DISTRO_VERSION == *"Pop"*"22.04"* ]]; then
            echo "Installing Wine for Ubuntu 22.04 ..."
            pkexec bash -c '
                dpkg --add-architecture i386
                rm /etc/apt/sources.list.d/wine* /etc/apt/sources.list.d/*wine* 2>/dev/null
                apt-key list | grep -A 2 "wine" | grep "pub" | awk "{print \$2}" | cut -d"/" -f2 | xargs -r apt-key del
                mkdir -pm755 /etc/apt/keyrings
                wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
                wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources
                apt-get update
                apt-get remove wine* --purge
                apt-get autoremove -y
                apt-get install -y --install-recommends winehq-staging'
        elif [[ $DISTRO_VERSION == *"Ubuntu"*"24.04"* ]] || [[ $DISTRO_VERSION == *"Linux"*"Mint"*"22"* ]] || [[ $DISTRO_VERSION == *"Pop"*"24.04"* ]]; then
            echo "Installing Wine for Ubuntu 24.04 ..."
            pkexec bash -c '
                dpkg --add-architecture i386
                rm /etc/apt/sources.list.d/wine* /etc/apt/sources.list.d/*wine* 2>/dev/null
                apt-key list | grep -A 2 "wine" | grep "pub" | awk "{print \$2}" | cut -d"/" -f2 | xargs -r apt-key del
                mkdir -pm755 /etc/apt/keyrings
                wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
                wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources
                apt-get update
                apt-get remove wine* --purge
                apt-get autoremove -y
                apt-get install -y --install-recommends winehq-staging'
        elif [[ $DISTRO_VERSION == *"Fedora"* && $DISTRO_VERSION == *"40"* ]] || [[ $DISTRO_VERSION == *"Nobara"* ]]; then
            echo "Installing Wine for Fedora 40 ..."
            echo -e "$(gettext "${YELLOW}Multiple Wine repos detected. Please choose which to use:${NOCOLOR}")"
            echo "1) WineHQ Repository"
            echo "2) openSUSE-Wine-OBS Repository"
            read -p "Enter your choice (1 or 2): " wine_repo_choice

            case $wine_repo_choice in
                1)
                    echo -e "$(gettext "${GREEN}WineHQ Repository selected. The WineHQ Repository will be used for the installation.${NOCOLOR}")"
                    pkexec bash -c '
                        dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/40/winehq.repo
                        dnf remove -y wine wine-*
                        dnf install -y winehq-staging'
                    ;;
                2)
                    echo -e "$(gettext "${GREEN}openSUSE-Wine-OBS Repository selected. The openSUSE-Wine-OBS Repository will be used for the installation.${NOCOLOR}")"
                    pkexec bash -c '
                        rpm --import https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_40/repodata/repomd.xml.key
                        dnf config-manager --add-repo https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_40/
                        dnf remove -y wine wine-*
                        dnf install -y winehq-staging'
                    ;;
                *)
                    echo -e "$(gettext "${RED}Invalid choice. The WineHQ Repository will be used for the installation.${NOCOLOR}")"
                    pkexec bash -c '
                        dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/40/winehq.repo
                        dnf remove -y wine wine-*
                        dnf install -y winehq-staging'
                    ;;
            esac
        elif [[ $DISTRO_VERSION == *"Fedora"*"Rawhide"* ]]; then
            echo "Installing Wine for Fedora rawhide ..."
            pkexec bash -c '
                dnf config-manager --add-repo https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_Rawhide/
                dnf remove wine wine-*
                dnf install -y winehq-staging'
        elif [[ $DISTRO_VERSION == *"Gentoo"* ]]; then
            echo "Installing Wine for Gentoo ..."
            pkexec emerge -av app-emulation/wine
        elif [[ $DISTRO_VERSION == *"openSUSE"*"15.6"* ]]; then
            echo "Installing Wine for openSUSE 15.6 ..."
            pkexec bash -c '
                repos=$(zypper repos --uri | grep wine | awk '{print $1}')
                # Remove each identified repository
                for repo in $repos; do
                    echo "Removing repository: $repo"
                    zypper removerepo "$repo"
                done
                zypper addrepo -cfp 90 "https://download.opensuse.org/repositories/Emulators:/Wine/15.6/" wine
                zypper refresh
                zypper remove wine wine-* winetricks --no-confirm
                zypper install -y wine'
        elif [[ $DISTRO_VERSION == *"openSUSE"*"Tumbleweed"* ]]; then
            echo "Installing Wine for openSUSE tumbleweed ..."
            pkexec bash -c '
                repos=$(zypper repos --uri | grep wine | awk '{print $1}')
                # Remove each identified repository
                for repo in $repos; do
                    echo "Removing repository: $repo"
                    zypper removerepo "$repo"
                done
                zypper addrepo -cfp 90 "https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/" wine
                zypper refresh
                zypper remove wine wine-* winetricks --no-confirm
                zypper install -y wine'
        elif [[ $DISTRO_VERSION == *"Red"*"Hat"*"Enterprise"*"Linux"* ]] || [[ $DISTRO_VERSION == *"Alma"*"Linux"* ]] || [[ $DISTRO_VERSION == *"Rocky"*"Linux"* ]]; then
            echo "Installing Wine for RHEL 8, 9, ..."
            if command -v dnf &> /dev/null; then # Use dnf for newer distributions
                pkexec bash -c '
                    dnf -y groupinstall 'Development Tools'
                    dnf -y install gcc libX11-devel freetype-devel zlib-devel libxcb-devel libxslt-devel
                    curl -L https://dl.winehq.org/wine/source/9.x/wine-9.15.tar.xz -o /tmp/wine-9.15.tar.xz
                    tar -xvf /tmp/wine-9.15.tar.xz -C /tmp/
                    ./tmp/wine-9.15/configure --enable-win64
                    make -C /tmp/wine-9.15
                    make -C /tmp/wine-9.15 install'
            else  # Use yum for older distributions
                pkexec bash -c '
                    yum -y groupinstall 'Development Tools'
                    yum install gcc libX11-devel freetype-devel zlib-devel libxcb-devel libxslt-devel
                    curl -L https://dl.winehq.org/wine/source/9.x/wine-9.15.tar.xz -o /tmp/wine-9.15.tar.xz
                    tar -xvf /tmp/wine-9.15.tar.xz -C /tmp/
                    ./tmp/wine-9.15/configure --enable-win64
                    make -C /tmp/wine-9.15
                    make -C /tmp/wine-9.15 install'
            fi
        elif [[ $DISTRO_VERSION == *"Solus"* ]]; then
            echo "Installing Wine for Solus ..."
            pkexec eopkg install -y winehq-staging
        elif [[ $DISTRO_VERSION == *"Void"* ]]; then
            echo "Installing Wine for Void Linux ..."
            pkexec xbps-install -Syu --yes wine
        elif [[ $DISTRO_VERSION == *"NixOS"* ]] || [[ $DISTRO_VERSION == *"nixos"* ]]; then
            echo "Installing Wine for NixOS ..."
            pkexec nix-env -iA nixos.wine nixos.winetricks --yes
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
    curl -L $REPO_URL/files/setup/resource/graphics/autodesk_fusion.svg -o "$SELECTED_DIRECTORY/resources/graphics/autodesk_fusion.svg"
    cat > "$HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk Fusion.desktop" << EOF
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
Categories=Education;Engineering;Graphics;Science
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
    cat > $HOME/.local/share/applications/adskidmgr-opener.desktop << EOL
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
    curl -L $REPO_URL/files/setup/data/autodesk_fusion_launcher.sh -o "$SELECTED_DIRECTORY/bin/autodesk_fusion_launcher.sh"
    chmod +x "$SELECTED_DIRECTORY/bin/autodesk_fusion_launcher.sh"
}

###############################################################################################################################################################

function dxvk_opengl_1 {
    if [[ $GPU_DRIVER = "DXVK" ]]; then
        WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" sh "$SELECTED_DIRECTORY/bin/winetricks" -q dxvk
        curl -L $REPO_URL/files/setup/resource/video_driver/dxvk/DXVK.reg -o "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Downloads/DXVK.reg"
        # Add the "return"-option. Here you can read more about it -> https://github.com/koalaman/shellcheck/issues/592
        cd "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/users/$USER/Downloads" || return
        WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" wine regedit.exe DXVK.reg
    fi
}

function dxvk_opengl_2 {
    if [[ $GPU_DRIVER = "DXVK" ]]; then
        curl -L $REPO_URL/files/setup/resource/video_driver/dxvk/NMachineSpecificOptions.xml -o "NMachineSpecificOptions.xml"
    else
        curl -L $REPO_URL/files/setup/resource/video_driver/opengl/NMachineSpecificOptions.xml -o "NMachineSpecificOptions.xml"
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
    QT6_WEBENGINECORE=$(find "$SELECTED_DIRECTORY/wineprefixes/default" -name 'Qt6WebEngineCore.dll' -printf "%T+ %p\n" | sort -r | head -n 1 | sed -r 's/^[^ ]+ //')
    QT6_WEBENGINECORE_DIR=$(dirname "$QT6_WEBENGINECORE")
    clear
    echo "$QT6_WEBENGINECORE_DIR"

    echo -e "${YELLOW}The old Qt6WebEngineCore.dll file is located in the following directory: $QT6_WEBENGINECORE_DIR${NOCOLOR}"

    # Check if the Qt6WebEngineCore.dll file exists before attempting to backup
    if [ -f "$QT6_WEBENGINECORE_DIR/Qt6WebEngineCore.dll" ]; then
        # Backup the Qt6WebEngineCore.dll file
        cp -f "$QT6_WEBENGINECORE_DIR/Qt6WebEngineCore.dll" "$QT6_WEBENGINECORE_DIR/Qt6WebEngineCore.dll.bak"
        echo -e "${GREEN}The Qt6WebEngineCore.dll file is backed up as Qt6WebEngineCore.dll.bak!${NOCOLOR}"
    else
        echo -e "${RED}The Qt6WebEngineCore.dll file does not exist. No backup was made.${NOCOLOR}"
    fi

    # Patch the Qt6WebEngineCore.dll file
    echo -e "${YELLOW}Patching the Qt6WebEngineCore.dll file for Autodesk Fusion ...${NOCOLOR}"
    sleep 2

    # Copy the patched Qt6WebEngineCore.dll file to the Autodesk Fusion directory
    cp -f "$SELECTED_DIRECTORY/downloads/Qt6WebEngineCore.dll" "$QT6_WEBENGINECORE_DIR/Qt6WebEngineCore.dll"
    echo -e "${GREEN}The Qt6WebEngineCore.dll file is patched successfully!${NOCOLOR}"
}  

###############################################################################################################################################################

# Add/Patch the siappdll.dll to fix the SpaceMouse issue

function autodesk_fusion_patch_siappdll {
    echo -e "${YELLOW}Patching the siappdll.dll file for Autodesk Fusion ...${NOCOLOR}"
    sleep 2
    
    # Check if the siappdll.dll file exists before attempting to backup
    if [ -f "$QT6_WEBENGINECORE_DIR/siappdll.dll" ]; then
        # Backup the siappdll.dll file
        cp -f "$QT6_WEBENGINECORE_DIR/siappdll.dll" "$QT6_WEBENGINECORE_DIR/siappdll.dll.bak"
        echo -e "${GREEN}The siappdll.dll file is backed up as siappdll.dll.bak!${NOCOLOR}"
    else
        echo -e "${RED}The siappdll.dll file does not exist. No backup was made.${NOCOLOR}"
    fi

    # Copy the patched siappdll.dll file to the Autodesk Fusion directory
    cp -f "$SELECTED_DIRECTORY/downloads/siappdll.dll" "$QT6_WEBENGINECORE_DIR/siappdll.dll"
    echo -e "${GREEN}The siappdll.dll file is patched successfully!${NOCOLOR}"
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
    sleep 5s
    # Install 7-Zip inside the Wine prefix via winetricks.
    # This method does NOT require 7-Zip on the host system and is more stable/reliable than previous approaches.
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" sh "$SELECTED_DIRECTORY/bin/winetricks" -q 7zip
    WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" wine "$SELECTED_DIRECTORY/wineprefixes/default/drive_c/Program Files/7-Zip/7z.exe" x "C:\\users\\$USER\\Downloads\\Qt6WebEngineCore.dll.7z" -o"C:\\users\\$USER\\Downloads\\"
    # Disabled by Default - Configure the correct virtual desktop resolution
    # WINEPREFIX="$SELECTED_DIRECTORY/wineprefixes/default" sh "$SELECTED_DIRECTORY/bin/winetricks" -q vd="$MONITOR_RESOLUTION"
    # Download and install WebView2 to handle Login attempts, required even though we redirect to your default browser
    # sleep 5s
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
