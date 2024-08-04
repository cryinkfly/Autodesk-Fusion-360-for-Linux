#!/usr/bin/env bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you can install Autodesk Fusion 360 on Linux.                       #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2024                                                                          #
# Time/Date:    23:00/01.08.2024                                                                   #
# Version:      2.0.0                                                                              #
####################################################################################################


###############################################################################################################################################################
# THE INITIALIZATION OF DEPENDENCIES STARTS HERE:                                                                                                             #
###############################################################################################################################################################

# Get the current used Linux distribution and version without lsb_release
distribution=$(grep "^ID=" /etc/*-release | cut -d'=' -f2 | tr -d '"')
version=$(grep "^VERSION_ID=" /etc/*-release | cut -d'=' -f2 | tr -d '"')
echo "Linux distribution: $distribution"
echo "Linux version: $version"

# Get the values of the passed arguments and assign them to variables
echo "$1"
echo "$2"
echo "$3"
selected_option="$1"
selected_directory="$2"
selected_extensions="$3"
echo "Selected option: $selected_option"
echo "Selected directory: $selected_directory"
echo "Selected extensions: $selected_extensions"

# URL to download winetricks
winetricks_url="https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks"

# URL to download Fusion360Installer.exe files
#fusion360_installer_url="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe" <-- Old Link!!!
fusion360_installer_url="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Admin%20Install.exe"
fusion360_installer_client_url="https://dl.appstreaming.autodesk.com/production/installers/Fusion%20Client%20Downloader.exe"

# URL to download Microsoft Edge WebView2.Exec
webview2_installer_url="https://github.com/aedancullen/webview2-evergreen-standalone-installer-archive/releases/download/109.0.1518.78/MicrosoftEdgeWebView2RuntimeInstallerX64.exe"

###############################################################################################################################################################

# Write a function to check which option is selected for example: f360-installer.sh $1 = "abort" $2
function check_option() {
    case "$1" in
        "abort")
            echo "Aborting the installation process ..."
            rm -rf "$selected_directory"
            ;;
        "install_part1")
            echo "Step 1: Preparing files for installation ..."
            deactivate_window_not_responding_dialog
            create_data_structure
            sleep 5
            ;;
        "install_part2")
            echo "Step 2: Setting up Wine for installation ..."
            check_and_install_wine
            check_gpu_driver
            sleep 5
            ;;
        "install_part3")
            echo "Step 3: Installing Autodesk Fusion ..."
            wine_fusion360_config
            sleep 5
            ;;
        "install_part4")
            echo "Step 4: Installing Autodesk Fusion extensions ..."
            check_and_install_extensions
            sleep 5
            ;;
        "install_part5")
            echo "Step 5: Completing the installation ..."
            fusion360_shortcuts_load
            logfile_wineprefix
            reset_window_not_responding_dialog
            sleep 5
            ;;
        *)
            echo "Invalid option selected. Please select either 'abort' or 'install'."
            ;;
    esac
}

###############################################################################################################################################################

function deactivate_window_not_responding_dialog() {
    # Check if desktop environment is GNOME
    if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
        # Disable the "Window not responding" Dialog in GNOME for 30 minutes:
        gsettings set org.gnome.mutter check-alive-timeout 1800000
    fi
}

function reset_window_not_responding_dialog() {
    # Check if desktop environment is GNOME
    if [ "$XDG_CURRENT_DESKTOP" = "GNOME" ]; then
        # Reset the "Window not responding" Dialog in GNOME
        gsettings reset org.gnome.mutter check-alive-timeout
    fi
}

###############################################################################################################################################################

function create_data_structure() {
    mkdir -p "$selected_directory/bin" \
        "$selected_directory/logs" \
        "$selected_directory/locale" \
        "$selected_directory/config" \
        "$selected_directory/graphics" \
        "$selected_directory/downloads" \
        "$selected_directory/extensions" \
        "$selected_directory/styles" \
        "$selected_directory/wineprefixes/default"

    # Download the newest winetricks version:
    curl -o "$selected_directory/bin/winetricks" "$winetricks_url" 
    chmod +x "$selected_directory/bin/winetricks"

    # Search for an existing installer of Autodesk Fusion 360
    fusion360_installer="$selected_directory/downloads/Fusion360installer.exe"
    if [ -f "$fusion360_installer" ]; then
        echo "The Autodesk Fusion 360 installer exists!"
        if find "$fusion360_installer" -mtime +7 | grep -q .; then
            rm -rf "$fusion360_installer"
            curl -L "$fusion360_installer_url" -o "$fusion360_installer"
        fi
    else
        echo "The Autodesk Fusion 360 installer doesn't exist and will be downloaded for you!"
        curl -L "$fusion360_installer_url" -o "$fusion360_installer"
    fi

    # Search for an existing installer of Autodesk Fusion 360 (Client)
    fusion360_installer_client="$selected_directory/downloads/Fusion360Clientinstaller.exe"
    if [ -f "$fusion360_installer_client" ]; then
        echo "The Autodesk Fusion 360 installer exists!"
        if find "$fusion360_installer_client" -mtime +7 | grep -q .; then
            rm -rf "$fusion360_installer_client"
            curl -L "$fusion360_installer_client_url" -o "$fusion360_installer_client"
        fi
    else
        echo "The Autodesk Fusion 360 installer doesn't exist and will be downloaded for you!"
        curl -L "$fusion360_installer_client_url" -o "$fusion360_installer_client"
    fi
    
    # Search for an existing installer of WEBVIEW2
    webview2_installer="$selected_directory/downloads/WebView2installer.exe"
    if [ -f "$webview2_installer" ]; then
        echo "The WebView2installer installer exists!"
        if find "$webview2_installer" -mtime +7 | grep -q .; then
            rm -rf "$webview2_installer"
            curl -L "$webview2_installer_url" -o "$webview2_installer"
        fi
    else
        echo "The WebView2installer installer doesn't exist and will be downloaded for you!"
        curl -L "$webview2_installer_url" -o "$webview2_installer"
    fi

    # Download all tested extensions for Autodesk Fusion 360 on Linux
    download_all_extensions
}

# Download an extension if it doesn't exist or is older than 7 days
function download_all_extensions {
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
}

function download_extension {
    local file_name="$1"
    local file_url="$2"
    local extension_path="$selected_directory/extensions/$file_name"
    
    if [ -f "$extension_path" ]; then
        if find "$extension_path" -mtime +7 | grep -q .; then
            curl -L "$file_url" -o "$extension_path"
        fi
    else
        curl -L "$file_url" -o "$extension_path"
    fi
}

###############################################################################################################################################################

# Check if Wine is installed or which version is installed and install it if it doesn't exist and install the required components
# Wine version 9.8 is required for Autodesk Fusion 360
function check_and_install_wine() {
    # Check if wine is installed
    if [ -x "$(command -v wine)" ]; then
        echo "Wine is installed!"
        wine_version="$(wine --version  | cut -d ' ' -f1 | sed -e 's/wine-//' -e 's/-rc.*//')"
        wine_version_major_release="$(echo $wine_version | cut -d '.' -f1)"
        wine_version_minor_release="$(echo $wine_version | cut -d '.' -f2)"
        
        # Check if the installed wine version is at least 9.8 or higher (wine_version_series and wine_version_series_release)
        if [ "$wine_version_major_release" -ge 9 ] && [ "$wine_version_minor_release" -ge 8 ]; then
            echo "Wine version $wine_version is installed!"
            wine_status=1
        else
            echo "Wine version $wine_version is installed, but this version is too old and will be updated for you!"
            wine_status=0
        fi

    else
        echo "Wine is not installed on your system and will be installed for you!"
        wine_status=0
    fi

    # Check wine status 0 and install Wine version 
    if [ "$wine_status" -eq 0 ]; then
        if [[ $distribution == "arch" || $distribution == "manjaro" || $distribution == "endeavouros" ]]; then
            echo "Installing Wine for Arch Linux ..."
            if grep -q '^\[multilib\]$' /etc/pacman.conf; then
                echo "Multilib is already enabled!"
                pkexec pacman -Syu --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
            else
                echo "Enabling Multilib ..."
                pkexec sh -c 'echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf && pacman -Syu --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp'
            fi
        elif [[ $distribution == "debian" && $version == "11" ]]; then
            echo "Installing Wine for Debian 11 ..."
            pkexec bash -c 'sudo apt-get --allow-releaseinfo-change update &&
            sudo dpkg --add-architecture i386 &&
            sudo apt-add-repository -r "deb https://dl.winehq.org/wine-builds/debian/ bullseye main" &&
            curl -s https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add - &&
            sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/debian/ bullseye main" &&
            sudo apt-get update &&
            sudo apt-get install -y p7zip p7zip-full p7zip-rar curl winbind cabextract wget &&
            sudo apt-get install -y --install-recommends winehq-staging'
        elif [[ $distribution == "debian" && $version == "12" ]]; then
            echo "Installing Wine for Debian 12 ..."
            pkexec bash -c 'sudo apt-get --allow-releaseinfo-change update &&
            sudo dpkg --add-architecture i386 &&
            sudo apt-add-repository -r "deb https://dl.winehq.org/wine-builds/debian/ bookworm main" &&
            curl -s https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add - &&
            sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/debian/ bookworm main" &&
            sudo apt-get update &&
            sudo apt-get install -y p7zip p7zip-full p7zip-rar curl winbind cabextract wget &&
            sudo apt-get install -y --install-recommends winehq-staging'
        elif [[ $distribution == "debian" && $version == "testing" ]]; then
            echo "Installing Wine for Debian testing ..."
            pkexec bash -c 'sudo apt-get --allow-releaseinfo-change update &&
            sudo dpkg --add-architecture i386 &&
            sudo apt-add-repository -r "deb https://dl.winehq.org/wine-builds/debian/ testing main" &&
            curl -s https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add - &&
            sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/debian/ testing main" &&
            sudo apt-get update &&
            sudo apt-get install -y p7zip p7zip-full p7zip-rar curl winbind cabextract wget &&
            sudo apt-get install -y --install-recommends winehq-staging'
        elif [[ $distribution == "ubuntu" && $version == "20.04" ]]; then
            echo "Installing Wine for Ubuntu 20.04 ..."
            pkexec bash -c 'sudo dpkg --add-architecture i386 &&
            wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add - &&
            sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ focal main" &&
            sudo apt-get update &&
            sudo apt-get install -y p7zip p7zip-full p7zip-rar curl winbind cabextract wget &&
            sudo apt-get install -y --install-recommends winehq-staging'
        elif [[ $distribution == "ubuntu" && $version == "22.04" ]]; then
            echo "Installing Wine for Ubuntu 22.04 ..."
            pkexec bash -c 'sudo dpkg --add-architecture i386 &&
            wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add - &&
            sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ jammy main" &&
            sudo apt-get update &&
            sudo apt-get install -y p7zip p7zip-full p7zip-rar curl winbind cabextract wget &&
            sudo apt-get install -y --install-recommends winehq-staging'
        elif [[ $distribution == "ubuntu" && $version == "24.04" ]]; then
            echo "Installing Wine for Ubuntu 24.04 ..."
            pkexec bash -c 'sudo dpkg --add-architecture i386 &&
            wget -qO - https://dl.winehq.org/wine-builds/winehq.key | sudo apt-key add - &&
            sudo apt-add-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ impish main" &&
            sudo apt-get update &&
            sudo apt-get install -y p7zip p7zip-full p7zip-rar curl winbind cabextract wget &&
            sudo apt-get install -y --install-recommends winehq-staging'
        elif [[ $distribution == "fedora" && $version == "40" ]]; then
            echo "Installing Wine for Fedora 40 ..."
            # show a password prompt for the user to enter the root password with pkexec
            pkexec bash -c "dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/40/winehq.repo && dnf install -y p7zip p7zip-plugins curl wget winehq-staging cabextract"
        elif [[ $distribution == "fedora" && $version == "rawhide" ]]; then
            echo "Installing Wine for Fedora rawhide ..."
            pkexec bash -c "dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/rawhide/winehq.repo && dnf install -y p7zip p7zip-plugins curl wget winehq-staging cabextract"
        elif [[ $distribution == "gentoo" ]]; then
            echo "Installing Wine for Gentoo ..."
            pkexec emerge -av p7zip curl wget wine cabextract
        elif [[ $distribution == "opensuse" && $version == "15.6" ]]; then
            echo "Installing Wine for openSUSE 15.6 ..."
            pkexec bash -c 'sudo zypper addrepo -cfp 90 "https://dl.winehq.org/wine-builds/opensuse/15.6" wine &&
            sudo zypper refresh &&
            sudo zypper -y install p7zip p7zip-plugins curl wget winehq-staging cabextract'
        elif [[ $distribution == "opensuse" && $version == "tumbleweed" ]]; then
            echo "Installing Wine for openSUSE tumbleweed ..."
            pkexec bash -c 'sudo zypper addrepo -cfp 90 "https://dl.winehq.org/wine-builds/opensuse/tumbleweed" wine &&
            sudo zypper refresh &&
            sudo zypper install -y p7zip p7zip-plugins curl wget winehq-staging cabextract'
        elif [[ $distribution == "rhel" && $version == "8" ]]; then
            echo "Installing Wine for RHEL 8 ..."
            pkexec bash -c 'sudo subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms &&
            sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm &&
            sudo dnf upgrade &&
            sudo dnf install -y p7zip p7zip-plugins curl wget winehq-staging cabextract'
        elif [[ $distribution == "rhel" && $version == "9" ]]; then
            echo "Installing Wine for RHEL 9 ..."
            pkexec bash -c 'sudo subscription-manager repos --enable codeready-builder-for-rhel-9-x86_64-rpms &&
            sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm &&
            sudo dnf upgrade &&
            sudo dnf install -y p7zip p7zip-plugins curl wget winehq-staging cabextract'
        elif [[ $distribution == "solus" ]]; then
            echo "Installing Wine for Solus ..."
            pkexec eopkg install -y p7zip p7zip-plugins curl wget winehq-staging cabextract
        elif [[ $distribution == "void" ]]; then
            echo "Installing Wine for Void Linux ..."
            pkexec xbps-install -Syu --yes p7zip p7zip-plugins curl wget wine cabextract
        elif [[ $distribution == "nixos" ]]; then
            echo "Installing Wine for NixOS ..."
            pkexec nix-env -iA nixos.p7zip nixos.curl nixos.wget nixos.wine nixos.cabextract nixos.samba nixos.ppp nixos.winetricks --yes
        # Add more distributions and versions here ...
        # elif ...
        else
            echo "Error: Your Linux distribution and version are not supported."
        fi
    fi
}

###############################################################################################################################################################

function check_gpu_driver() {
    # Check for Nvidia GPU
    if lspci | grep -i 'vga.*nvidia' &> /dev/null; then
        echo "Nvidia GPU detected"
        if cat /proc/driver/nvidia/version &> /dev/null; then
            echo "Nvidia driver installed"
            cat /proc/driver/nvidia/version
            gpu_driver="DXVK"
        else
            echo "Nvidia GPU detected"
        fi
    elif lspci | grep -i 'vga.*amd\|vga.*ati' &> /dev/null; then
        echo "AMD GPU detected"
        if lsmod | grep -i amdgpu &> /dev/null; then
            echo "AMD driver installed"
            modinfo amdgpu | grep -i version
            gpu_driver="OpenGL"
        else
            echo "AMD GPU detected"
        fi
    elif lspci | grep -i 'vga.*intel' &> /dev/null; then
        echo "Intel GPU detected"
        if lsmod | grep -i i915 &> /dev/null; then
            echo "Intel driver installed"
            modinfo i915 | grep -i version
            gpu_driver="OpenGL"
        else
            echo "Intel GPU detected"
        fi
    else
        echo "No supported GPU detected"
        gpu_driver="OpenGL"
    fi
}

###############################################################################################################################################################

# Helper function for the following function. The AdskIdentityManager.exe can be installed 
# into a variable alphanumeric folder.
# This function finds that folder alphanumeric folder name.
function determine_variable_folder_name_for_identity_manager {
    echo "Searching for the variable location of the Fusion 360 identity manager..."
    ident_man_path=$(find "$selected_directory/wineprefixes/default" -name 'AdskIdentityManager.exe')
    # Get the dirname of the identity manager's alphanumeric folder.
    # With the full path of the identity manager, go 2 folders up and isolate the folder name.
    ident_man_variable_directory=$(basename "$(dirname "$(dirname "$ident_man_path")")")
}

########################################################################################

# Load the icons and .desktop-files:
function fusion360_shortcuts_load {
    # Create a .desktop file (launcher.sh) for Autodesk Fusion 360!
    wget -Nc -P "$selected_directory/graphics" https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/resource/graphics/autodesk_fusion.svg
    rm "$HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk Fusion 360.desktop"
    cat >> "$HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/Autodesk Fusion 360.desktop" << EOF
[Desktop Entry]
Name=Autodesk Fusion 360
GenericName=CAD Application
GenericName[cs]=Aplikace CAD
GenericName[de]=CAD-Anwendung
GenericName[es]=Aplicación CAD
GenericName[fr]=Application CAO
GenericName[it]=Applicazione CAD
GenericName[ja]=CADアプリケーション
GenericName[ko]=CAD 응용
GenericName[zh_CN]=计算机辅助设计应用
Comment=Autodesk Fusion 360 is a cloud-based 3D modeling, CAD, CAM, and PCB software platform for product design and manufacturing.
Comment[cs]=Autodesk Fusion 360 je cloudová platforma pro 3D modelování, CAD, CAM a PCB určená k navrhování a výrobě produktů.
Comment[de]=Autodesk Fusion 360 ist eine cloudbasierte Softwareplattform für Modellierung, CAD, CAM, CAE und Leiterplatten in 3D für Produktdesign und Fertigung.
Comment[es]=Autodesk Fusion 360 es una plataforma de software de modelado 3D, CAD, CAM y PCB basada en la nube destinada al diseño y la fabricación de productos.
Comment[fr]=Autodesk Fusion 360 est une plate-forme logicielle 3D cloud de modélisation, de CAO, de FAO, d’IAO et de conception de circuits imprimés destinée à la conception et à la fabrication de produits.
Comment[it]=Autodesk Fusion 360 è una piattaforma software di modellazione 3D, CAD, CAM, CAE e PCB basata sul cloud per la progettazione e la realizzazione di prodotti.
Comment[ja]=Autodesk Fusion 360は、製品の設計と製造のためのクラウドベースの3Dモデリング、CAD、CAM、およびPCBソフトウェアプラットフォームです。
Comment[ko]=Autodesk Fusion 360은 제품 설계 및 제조를 위한 클라우드 기반 3D 모델링, CAD, CAM 및 PCB 소프트웨어 플랫폼입니다.
Comment[zh_CN]=Autodesk Fusion 360 是一个基于云的 3D 建模、CAD、CAM 和 PCB 软件平台，用于产品设计和制造。
Exec=$selected_directory/bin/autodesk_fusion_launcher.sh
Type=Application
Categories=Education;Engineering;
StartupNotify=true
Icon=$selected_directory/graphics/autodesk_fusion.svg
Terminal=false
Path=$selected_directory/bin
EOF

    # Execute function
    determine_variable_folder_name_for_identity_manager

    #Create mimetype link to handle web login call backs to the Identity Manager
    cat > $HOME/.local/share/applications/adskidmgr-opener.desktop << EOL
[Desktop Entry]
Type=Application
Name=adskidmgr Scheme Handler
Exec=sh -c 'env WINEPREFIX="$selected_directory/wineprefixes/default" wine "$(find $selected_directory/wineprefixes/default/ -name "AdskIdentityManager.exe" | head -1 | xargs -I '{}' echo {})" "%u"'
StartupNotify=false
MimeType=x-scheme-handler/adskidmgr;
EOL
    
    #Set the mimetype handler for the Identity Manager
    xdg-mime default adskidmgr-opener.desktop x-scheme-handler/adskidmgr

    #Disable Debug messages on regular runs, we dont have a terminal, so speed up the system by not wasting time prining them into the Void
    sed -i 's/=env WINEPREFIX=/=env WINEDEBUG=-all env WINEPREFIX=/g' "$HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/Autodesk Fusion 360.desktop"

    # Download some script files for Autodesk Fusion 360!
    wget -NP "$selected_directory/bin" https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/data/autodesk_fusion_launcher.sh
    chmod +x "$selected_directory/bin/autodesk_fusion_launcher.sh"
}

###############################################################################################################################################################

function dxvk_opengl_1 {
    if [[ $gpu_driver = "DXVK" ]]; then
        WINEPREFIX="$selected_directory/wineprefixes/default" sh "$selected_directory/bin/winetricks" -q dxvk
        curl -o DXVK.reg https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/resource/video_driver/dxvk/DXVK.reg -o "$selected_directory/drive_c/users/$USER/Downloads"
        # Add the "return"-option. Here you can read more about it -> https://github.com/koalaman/shellcheck/issues/592
        cd "$selected_directory/drive_c/users/$USER/Downloads" || return
        WINEPREFIX="$selected_directory/wineprefixes/default" wine regedit.exe DXVK.reg
    fi
}

function dxvk_opengl_2 {
    if [[ $gpu_driver = "DXVK" ]]; then
        curl -o NMachineSpecificOptions.xml https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/resource/video_driver/dxvk/NMachineSpecificOptions.xml
    else
        curl -o NMachineSpecificOptions.xml https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/setup/resource/video_driver/opengl/NMachineSpecificOptions.xml
    fi
}

###############################################################################################################################################################

# Execute the installation of Autodesk Fusion 360
function autodesk_fusion_install {
    cd "$selected_directory/wineprefixes/default/drive_c/users/$USER/Downloads"
    #WINEPREFIX="$selected_directory/wineprefixes/default" timeout -k 5m 1m wine "$selected_directory/wineprefixes/default/drive_c/users/$USER/Downloads/Fusion360Clientinstaller.exe" --quiet
    WINEPREFIX="$selected_directory/wineprefixes/default" timeout -k 2m 1m wine "$selected_directory/wineprefixes/default/drive_c/users/$USER/Downloads/Fusion360installer.exe" --quiet
    sleep 5s
    WINEPREFIX="$selected_directory/wineprefixes/default" timeout -k 2m 1m wine "$selected_directory/wineprefixes/default/drive_c/users/$USER/Downloads/Fusion360installer.exe" --quiet
}

###############################################################################################################################################################

# Wine configuration for Autodesk Fusion 360
function wine_fusion360_config() {
    # Note that the winetricks sandbox verb merely removes the desktop integration and Z: drive symlinks and is not a "true" sandbox.
    # It protects against errors rather than malice. It's useful for, e.g., keeping games from saving their settings in random subdirectories of your home directory.
    # But it still ensures that wine, for example, no longer has access permissions to Home!
    # For this reason, the EXE files must be located directly in the Wineprefix folder!

    mkdir -p "$selected_directory/wineprefixes/default"
    cd "$selected_directory/wineprefixes/default" || return
    WINEPREFIX="$selected_directory/wineprefixes/default" sh "$selected_directory/bin/winetricks" -q sandbox
    sleep 5s
    WINEPREFIX="$selected_directory/wineprefixes/default" sh "$selected_directory/bin/winetricks" -q sandbox
    sleep 5s
    # We must install some packages!
    WINEPREFIX="$selected_directory/wineprefixes/default" sh "$selected_directory/bin/winetricks" -q atmlib gdiplus arial corefonts cjkfonts dotnet452 msxml4 msxml6 vcrun2017 fontsmooth=rgb winhttp win10
    # We must install cjkfonts again then sometimes it doesn't work in the first time!
    sleep 5s
    WINEPREFIX="$selected_directory/wineprefixes/default" sh "$selected_directory/bin/winetricks" -q cjkfonts
    # We must set to Windows 10 or 11 again because some other winetricks sometimes set it back to Windows XP!
    sleep 5s
    WINEPREFIX="$selected_directory/wineprefixes/default" sh "$selected_directory/bin/winetricks" -q win11
    # Remove tracking metrics/calling home
    sleep 5s
    WINEPREFIX="$selected_directory/wineprefixes/default" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "adpclientservice.exe" /t REG_SZ /d "" /f
    # Navigation bar does not work well with anything other than the wine builtin DX9
    WINEPREFIX="$selected_directory/wineprefixes/default" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "AdCefWebBrowser.exe" /t REG_SZ /d builtin /f
    # Use Visual Studio Redist that is bundled with the application
    WINEPREFIX="$selected_directory/wineprefixes/default" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "msvcp140" /t REG_SZ /d native /f
    WINEPREFIX="$selected_directory/wineprefixes/default" wine REG ADD "HKCU\Software\Wine\DllOverrides" /v "mfc140u" /t REG_SZ /d native /f
    # Fixed the problem with the bcp47langs issue and now the login works again!
    WINEPREFIX="$selected_directory/wineprefixes/default" wine reg add "HKCU\Software\Wine\DllOverrides" /v "bcp47langs" /t REG_SZ /d "" /f
    # Download and install WebView2 to handle Login attempts, required even though we redirect to your default browser
    sleep 5s
    cp "$selected_directory/downloads/WebView2installer.exe" "$selected_directory/wineprefixes/default/drive_c/users/$USER/Downloads/WebView2installer.exe"
    WINEPREFIX="$selected_directory/wineprefixes/default" wine "$selected_directory/wineprefixes/default/drive_c/users/$USER/Downloads/WebView2installer.exe" /silent /install
    # Pre-create shortcut directory for latest re-branding Microsoft Edge WebView2
    mkdir -p "$selected_directory/wineprefixes/default/drive_c/users/$USER/AppData/Roaming/Microsoft/Internet Explorer/Quick Launch/User Pinned/"
    dxvk_opengl_1
    cp "$selected_directory/downloads/Fusion360installer.exe" "$selected_directory/wineprefixes/default/drive_c/users/$USER/Downloads"
    cp "$selected_directory/downloads/Fusion360Clientinstaller.exe" "$selected_directory/wineprefixes/default/drive_c/users/$USER/Downloads"
    autodesk_fusion_install
    mkdir -p "$selected_directory/wineprefixes/default/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options"
    cd "$selected_directory/wineprefixes/default/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options" || return
    dxvk_opengl_2
    mkdir -p "$selected_directory/wineprefixes/default/drive_c/users/$USER/AppData/Local/Autodesk/Neutron Platform/Options"
    cd "$selected_directory/wineprefixes/default/drive_c/users/$USER/AppData/Local/Autodesk/Neutron Platform/Options" || return
    dxvk_opengl_2
    mkdir -p "$selected_directory/wineprefixes/default/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options"
    cd "$selected_directory/wineprefixes/default/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options" || return
    dxvk_opengl_2
    cd "$selected_directory/bin" || return
}

###############################################################################################################################################################

# Check and install the selected extensions
function check_and_install_extensions() {
    if [[ "$selected_extensions" == *"CzechlocalizationforF360"* ]]; then
        extension_czech_locale
    fi
    if [[ "$selected_extensions" == *"HP3DPrintersforAutodesk®Fusion®"* ]]; then
        extension_hp_3dprinter_connector
    fi
    if [[ "$selected_extensions" == *"MarkforgedforAutodesk®Fusion®"* ]]; then
        extension_markforged
    fi
    if [[ "$selected_extensions" == *"OctoPrintforAutodesk®Fusion360™"* ]]; then
        extension_octoprint
    fi
    if [[ "$selected_extensions" == *"UltimakerDigitalFactoryforAutodeskFusion360™"* ]]; then
        extension_ultimaker_digital_factory
    fi
}

function extension_czech_locale {
    install_extension "Ceska_lokalizace_pro_Autodesk_Fusion.exe"
}

function extension_hp_3dprinter_connector {
    install_extension "HP_3DPrinters_for_Fusion360-win64.msi"
}

function extension_markforged {
    install_extension "Markforged_for_Fusion360-win64.msi"
}

function extension_octoprint {
    install_extension "OctoPrint_for_Fusion360-win64.msi"
}

function extension_ultimaker_digital_factory {
    install_extension "Ultimaker_Digital_Factory-win64.msi"
}

function install_extension {
    local extension_file="$1"
    cp "$selected_directory/extensions/$extension_file" "$selected_directory/wineprefixes/default/drive_c/users/$USER/Downloads"
    if [[ "$extension_file" == *.msi ]]; then
        cd "$selected_directory/wineprefixes/default/drive_c/users/$USER/Downloads" || return
        WINEPREFIX="$selected_directory/wineprefixes/default" wine msiexec /i "$extension_file"
    else
        cd "$selected_directory/wineprefixes/default/drive_c/users/$USER/Downloads" || return
        WINEPREFIX="$selected_directory/wineprefixes/default" wine "$extension_file"
    fi
}

###############################################################################################################################################################

function logfile_wineprefix() {
    # Log the Wineprefixes
    echo "$gpu_driver" >> "$selected_directory/logs/wineprefixes.log"
    echo "$selected_directory/wineprefixes/default" >> "$selected_directory/logs/wineprefixes.log"
}

########################################################################################
########################################################################################

# Check which option is selected and execute the corresponding function
check_option "$1"
