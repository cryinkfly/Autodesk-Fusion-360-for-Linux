#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file you can install Autodesk Fusion 360 on Linux.                       #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    06:30/08.06.2022                                                                   #
# Version:      1.7.9 -> 1.8.0                                                                     #
####################################################################################################

# Path: /$HOME/.fusion360/bin/install.sh

###############################################################################################################################################################
# DESCRIPTION IN DETAIL                                                                                                                                       #
###############################################################################################################################################################
# With the help of my setup wizard, you will be given a way to install Autodesk Fusion 360 with some extensions on                                            #
# Linux so that you don't have to use Windows or macOS for this program in the future!                                                                        #
#                                                                                                                                                             #
# Also, my setup wizard will guides you through the installation step by step and will install some required packages.                                        #
#                                                                                                                                                             #
# The next one is you have the option of installing the program directly on your system or you can install it on an external storage medium.                  #
#                                                                                                                                                             #
# But it's important to know, you must to purchase the licenses directly from the manufacturer of Autodesk Fusion 360, when you will work with them on Linux! #
###############################################################################################################################################################

###############################################################################################################################################################
# THE INITIALIZATION OF DEPENDENCIES STARTS HERE:                                                                                                             #
###############################################################################################################################################################

# Default-Path:
SP_PATH="$HOME/.fusion360"

# Reset the graphics driver value:
WP_DRIVER="DXVK"

# Reset the logfile-value for the installation of Autodesk Fusion 360!
SP_FUSION360_CHANGE=0

###############################################################################################################################################################

function SP_STRUCTURE {
  mkdir -p $SP_PATH/bin
  mkdir -p $SP_PATH/logs
  mkdir -p $SP_PATH/config
  mkdir -p $SP_PATH/graphics
  mkdir -p $SP_PATH/downloads
  mkdir -p $SP_PATH/extensions
  mkdir -p $SP_PATH/wineprefixes
  mkdir -p $SP_PATH/locale/cs-CZ
  mkdir -p $SP_PATH/locale/de-DE
  mkdir -p $SP_PATH/locale/en-US
  mkdir -p $SP_PATH/locale/es-ES
  mkdir -p $SP_PATH/locale/fr-FR
  mkdir -p $SP_PATH/locale/it-IT
  mkdir -p $SP_PATH/locale/ja-JP
  mkdir -p $SP_PATH/locale/ko-KR
  mkdir -p $SP_PATH/locale/zh-CN
  # Create a temporary folder with some information for the next step:
  mkdir -p /tmp/fusion360
  echo "English" > /tmp/fusion360/settings.txt
  echo "DXVK" >> /tmp/fusion360/settings.txt
  echo "English" > $SP_PATH/config/settings.txt
  echo "DXVK" >> $SP_PATH/config/settings.txt
}

###############################################################################################################################################################
# ALL LOG-FUNCTIONS ARE ARRANGED HERE:                                                                                                                        #
###############################################################################################################################################################

# Provides information about setup actions during installation.
function SP_LOGFILE_INSTALL {
  exec 5> $SP_PATH/logs/setupact.log
  BASH_XTRACEFD="5"
  set -x
}

###############################################################################################################################################################

# Check if already exists a Autodesk Fusion 360 installation on your system.
function SP_LOGFILE_WINEPREFIX_CHECK {
  SP_FUSION360_WINEPREFIX_CHECK="$SP_PATH/logs/wineprefixes.log" # Search for wineprefixes.log
  if [ -f "$SP_FUSION360_WINEPREFIX_CHECK" ]; then
    cp "$SP_FUSION360_WINEPREFIX_CHECK" "/tmp/fusion360/logs"
    SP_LOGFILE_WINEPREFIX_INFO # Add/Modify or Delete a exists Wineprefix of Autodesk Fusion 360.
  else
    SP_INSTALLDIR # Add a new Wineprefix of Autodesk Fusion 360.
  fi
}

###############################################################################################################################################################

# Create a WP-TYPE for the .desktop-files:
function SP_GET_WINEPREFIX_TYPE {
  if [[ $WP_DIRECTORY = "$SP_PATH/wineprefixes/default" ]]; then
    WP_TYPE="default"
  else
    # Create the directory (custom, custom-1, custom-2, ...)
    SP_ADD_CUSTOM_WINEPREFIX_TYPE
  fi
}

function SP_ADD_CUSTOM_WINEPREFIX_TYPE {
  WP_TYPE="custom"
  if [[ -e $WP_TYPE || -L $WP_TYPE ]] ; then
    i=0
    while [[ -e $WP_TYPE-$i || -L $WP_TYPE-$i ]] ; do
        let i++
    done
    WP_TYPE=$WP_TYPE-$i
  fi
}

###############################################################################################################################################################

function SP_LOGFILE_WINEPREFIX {
if [ $SP_FUSION360_CHANGE -eq 1 ]; then
  echo "FALSE" >> $SP_PATH/logs/wineprefixes.log
  echo "$WP_TYPE" >> $SP_PATH/logs/wineprefixes.log
  echo "$WP_DRIVER" >> $SP_PATH/logs/wineprefixes.log
  echo "$WP_DIRECTORY" >> $SP_PATH/logs/wineprefixes.log
fi
}

###############################################################################################################################################################

function SP_INSTALLDIR_CHECK {
# Check if this wineprefix already exist or not!
WP_PATH_CHECK=`cat /tmp/fusion360/logs/wineprefixes.log | awk 'NR == 1'`
if [[ $WP_PATH_CHECK = "$WP_DIRECTORY" ]]; then
    echo "FALSE"
    SP_INSTALLDIR_INFO
else
    echo "TRUE"
    SP_FUSION360_CHANGE=1
    SP_WINE_SETTINGS
fi
}

###############################################################################################################################################################
# ALL LOCALE-FUNCTIONS ARE ARRANGED HERE:                                                                                                                     #
###############################################################################################################################################################

# Load the index of locale files:
function SP_LOCALE_INDEX {
  wget -N -P $SP_PATH/locale https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/locale/locale.sh
  chmod +x $SP_PATH/locale/locale.sh
  . $SP_PATH/locale/locale.sh
  SP_LOCALE_EN
}

# Czech:
function SP_LOCALE_CS {
  . $SP_PATH/locale/cs-CZ/locale-cs.sh
}

# German:
function SP_LOCALE_DE {
  . $SP_PATH/locale/de-DE/locale-de.sh
}

# English:
function SP_LOCALE_EN {
  . $SP_PATH/locale/en-US/locale-en.sh
}

# Spanish:
function SP_LOCALE_ES {
  . $SP_PATH0/locale/es-ES/locale-es.sh
}

# French:
function SP_LOCALE_FR {
  . $SP_PATH/locale/fr-FR/locale-fr.sh
}


# Italian:
function SP_LOCALE_IT {
  . $SP_PATH/locale/it-IT/locale-it.sh
}

# Japanese:
function SP_LOCALE_JA {
  . $SP_PATH/locale/ja-JP/locale-ja.sh
}

# Korean:
function SP_LOCALE_KO {
  . $SP_PATH/locale/ko-KR/locale-ko.sh
}

# Chinese:
function SP_LOCALE_ZH {
  . $SP_PATH/locale/zh-CN/locale-zh.sh
}

###############################################################################################################################################################

function SP_LOCALE_SETTINGS {
SP_LOCALE=`cat /tmp/fusion360/settings.txt | awk 'NR == 1'`
if [[ $SP_LOCALE = "Czech" ]]; then
    echo "CS"
    SP_LOCALE_CS
elif [[ $SP_LOCALE = "English" ]]; then
    echo "EN"
    SP_LOCALE_EN
elif [[ $SP_LOCALE = "German" ]]; then
    echo "DE"
    SP_LOCALE_DE
elif [[ $SP_LOCALE = "Spanish" ]]; then
    echo "ES"
    SP_LOCALE_ES
elif [[ $SP_LOCALE = "French" ]]; then
    echo "FR"
    SP_LOCALE_FR
elif [[ $SP_LOCALE = "Italian" ]]; then
    echo "IT"
    SP_LOCALE_IT
elif [[ $SP_LOCALE = "Japanese" ]]; then
    echo "JP"
    SP_LOCALE_JP
elif [[ $SP_LOCALE = "Korean" ]]; then
    echo "KO"
    SP_LOCALE_KO
elif [[ $SP_LOCALE = "Chinese" ]]; then
    echo "ZH"
    SP_LOCALE_ZH
else 
   echo "EN"
   SP_LOCALE_EN
fi
}

###############################################################################################################################################################
# DONWLOAD WINETRICKS AND AUTODESK FUSION 360:                                                                                                                #
###############################################################################################################################################################

# Load the newest winetricks version:
function SP_WINETRICKS_LOAD {
  wget -N -P $SP_PATH/bin https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks
  chmod +x $SP_PATH/bin/winetricks
}

###############################################################################################################################################################

# Load newest Autodesk Fusion 360 installer version for the Setup Wizard!
function SP_FUSION360_INSTALLER_LOAD {
  # Search for a existing installer of Autodesk Fusion 360
  FUSION360_INSTALLER="$SP_PATH/downloads/Fusion360installer.exe"
  if [ -f "$FUSION360_INSTALLER" ]; then
    echo "The Autodesk Fusion 360 installer exist!"
  else
    echo "The Autodesk Fusion 360 installer doesn't exist and will be downloaded for you!"
    wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360installer.exe
    mv "Fusion360installer.exe" "$SP_PATH/downloads/Fusion360installer.exe"
  fi
}

###############################################################################################################################################################
# ALL FUNCTIONS FOR DESKTOP-FILES START HERE:                                                                                                                 #
###############################################################################################################################################################

# Load the icons and .desktop-files:
function SP_FUSION360_SHORTCUTS_LOAD {
  # Create a .desktop file (launcher.sh) for Autodesk Fusion 360!
  wget -N -P $SP_PATH/graphics https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/fusion360.svg
  rm $HOME/.local/share/applications/wine/Programs/Autodesk/Autodesk\ Fusion\ 360.desktop
  mkdir -p $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE
  echo "[Desktop Entry]" > $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Name=Autodesk Fusion 360 - $WP_TYPE" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "GenericName=CAD Application" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "GenericName[cs]=Aplikace CAD" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "GenericName[de]=CAD-Anwendung" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "GenericName[es]=Aplicación CAD" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "GenericName[fr]=Application CAO" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "GenericName[it]=Applicazione CAD" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "GenericName[ja]=CADアプリケーション" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "GenericName[ko]=CAD 응용" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "GenericName[zh_CN]=计算机辅助设计应用" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Comment=Autodesk Fusion 360 is a cloud-based 3D modeling, CAD, CAM, and PCB software platform for product design and manufacturing." >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Comment[cs]=Autodesk Fusion 360 je cloudová platforma pro 3D modelování, CAD, CAM a PCB určená k navrhování a výrobě produktů." >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Comment[de]=Autodesk Fusion 360 ist eine cloudbasierte Softwareplattform für Modellierung, CAD, CAM, CAE und Leiterplatten in 3D für Produktdesign und Fertigung." >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Comment[es]=Autodesk Fusion 360 es una plataforma de software de modelado 3D, CAD, CAM y PCB basada en la nube destinada al diseño y la fabricación de productos." >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Comment[fr]=Autodesk Fusion 360 est une plate-forme logicielle 3D cloud de modélisation, de CAO, de FAO, d’IAO et de conception de circuits imprimés destinée à la conception et à la fabrication de produits." >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Comment[it]=Autodesk Fusion 360 è una piattaforma software di modellazione 3D, CAD, CAM, CAE e PCB basata sul cloud per la progettazione e la realizzazione di prodotti." >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Comment[ja]=Autodesk Fusion 360は、製品の設計と製造のためのクラウドベースの3Dモデリング、CAD、CAM、およびPCBソフトウェアプラットフォームです。" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Comment[ko]=Autodesk Fusion 360은 제품 설계 및 제조를 위한 클라우드 기반 3D 모델링, CAD, CAM 및 PCB 소프트웨어 플랫폼입니다." >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Comment[zh_CN]=Autodesk Fusion 360 是一个基于云的 3D 建模、CAD、CAM 和 PCB 软件平台，用于产品设计和制造。" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Exec=$WP_DIRECTORY/box-run.sh" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Type=Application" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Categories=Education;Engineering;" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "StartupNotify=true" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Icon=$SP_PATH/graphics/fusion360.svg" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Terminal=false" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  echo "Path=$WP_DIRECTORY" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360.desktop
  # Create a .desktop file (uninstall.sh) for Autodesk Fusion 360!
  wget -N -P $SP_PATH/graphics https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/fusion360-uninstall.svg
  echo "[Desktop Entry]" > $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Name=Autodesk Fusion 360 (Uninstall) - $WP_TYPE" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Name[cs]=Autodesk Fusion 360 (Odinstalovat) - $WP_TYPE" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Name[de]=Autodesk Fusion 360 (Deinstallieren) - $WP_TYPE" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Name[es]=Autodesk Fusion 360 (Desinstalar) - $WP_TYPE" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Name[fr]=Autodesk Fusion 360 (Désinstaller) - $WP_TYPE" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Name[it]=Autodesk Fusion 360 (Disinstalla) - $WP_TYPE" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Name[ja]=Autodesk Fusion 360 (アンインストール) - $WP_TYPE" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Name[ko]=Autodesk Fusion 360 (제거) - $WP_TYPE" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Name[zh_CN]=Autodesk Fusion 360 (卸载) - $WP_TYPE" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Comment=With this program you can delete Autodesk Fusion 360 on your system!" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Comment[cs]=Pomocí tohoto programu můžete odstranit Autodesk Fusion 360 ze svého systému!" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Comment[de]=Mit diesem Programm können Sie Autodesk Fusion 360 auf Ihrem System löschen!" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Comment[es]=¡Con este programa puede eliminar Autodesk Fusion 360 en su sistema!" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Comment[fr]=Avec ce programme, vous pouvez supprimer Autodesk Fusion 360 sur votre système !" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Comment[it]=Con questo programma puoi eliminare Autodesk Fusion 360 sul tuo sistema!" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Comment[ja]=このプログラムを使用すると、システム上のAutodeskFusion360を削除できます。" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Comment[ko]=이 프로그램을 사용하면 시스템에서 Autodesk Fusion 360을 삭제할 수 있습니다!" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Comment[zh_CN]=使用此程序，您可以删除系统上的 Autodesk Fusion 360！" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Exec=bash ./uninstall.sh" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Type=Application" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Categories=Education;Engineering;" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "StartupNotify=true" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Icon=$SP_PATH/graphics/fusion360-uninstall.svg" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Terminal=false" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  echo "Path=$SP_PATH/bin" >> $HOME/.local/share/applications/wine/Programs/Autodesk/Fusion360/$WP_TYPE/fusion360uninstall.desktop
  # Create a link to the Wineprefixes Box:
  echo "WP_BOX='$WP_DIRECTORY'" > $WP_DIRECTORY/box-run.sh
  echo ". $SP_PATH/bin/launcher.sh" >> $WP_DIRECTORY/box-run.sh
  chmod +x $WP_DIRECTORY/box-run.sh 
  # Download some script files for Autodesk Fusion 360!
  wget -N -P $SP_PATH/bin https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/uninstall.sh
  chmod +x $SP_PATH/bin/uninstall.sh  
  wget -N -P $SP_PATH/bin https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/launcher.sh
  chmod +x $SP_PATH/bin/launcher.sh
  wget -N -P $SP_PATH/bin https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/update.sh
  chmod +x $SP_PATH/bin/update.sh
  wget -N -P $SP_PATH/bin https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/builds/stable-branch/bin/read-text.sh
  chmod +x $SP_PATH/bin/read-text.sh
}

###############################################################################################################################################################
# ALL FUNCTIONS FOR DXVK AND OPENGL START HERE:                                                                                                               #
###############################################################################################################################################################

function SP_DXVK_OPENGL_1 {
  if [[ $WP_DRIVER = "DXVK" ]]; then
    WINEPREFIX=$WP_DIRECTORY sh $SP_PATH/bin/winetricks -q dxvk
    wget -N -P $WP_DIRECTORY/drive_c/users/$USER/Downloads https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/driver/video/dxvk/DXVK.reg
    cd "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
    WINEPREFIX=$WP_DIRECTORY wine regedit.exe DXVK.reg
  fi
}

function SP_DXVK_OPENGL_2 {
  if [[ $WP_DRIVER = "DXVK" ]]; then
    wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/driver/video/dxvk/DXVK.xml
    mv "DXVK.xml" "NMachineSpecificOptions.xml"
  else
    wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/builds/stable-branch/driver/video/opengl/OpenGL.xml
    mv "OpenGL.xml" "NMachineSpecificOptions.xml"
  fi
}

###############################################################################################################################################################

function SP_DRIVER_SETTINGS {
WP_DRIVER=`cat /tmp/fusion360/settings.txt | awk 'NR == 2'`
}

###############################################################################################################################################################
# ALL FUNCTIONS FOR WINE AND WINETRICKS START HERE:                                                                                                           #
###############################################################################################################################################################

# Start Fusion360installer.exe - Part 1
function SP_FUSION360_INSTALL_START_1 {
  WINEPREFIX=$WP_DIRECTORY wine $WP_DIRECTORY/drive_c/users/$USER/Downloads/Fusion360installer.exe
}

# Stop Fusion360installer.exe - Part 1
function SP_FUSION360_INSTALL_STOP_1 {
  sleep 10m
  kill -9 $(ps aux |grep -i '\.exe' |awk '{print $2}'|tr '\n' ' ')
}

# Start Fusion360installer.exe - Part 2
function SP_FUSION360_INSTALL_START_2 {
  WINEPREFIX=$WP_DIRECTORY wine $WP_DIRECTORY/drive_c/users/$USER/Downloads/Fusion360installer.exe
}

# Stop Fusion360installer.exe - Part 2
function SP_FUSION360_INSTALL_STOP_2 {
  sleep 1m
  kill -9 $(ps aux |grep -i '\.exe' |awk '{print $2}'|tr '\n' ' ')
}

###############################################################################################################################################################

# Start Fusion360installer.exe - Part 1 (Refresh)
function SP_FUSION360_INSTALL_REFRESH_START_1 {
  WINEPREFIX=$WP_WINEPREFIXES_REFRESH wine $WP_WINEPREFIXES_REFRESH/drive_c/users/$USER/Downloads/Fusion360installer.exe
}

# Stop Fusion360installer.exe - Part 1 (Refresh)
function SP_FUSION360_INSTALL_REFRESH_STOP_1 {
  sleep 10m
  kill -9 $(ps aux |grep -i '\.exe' |awk '{print $2}'|tr '\n' ' ')
}

# Start Fusion360installer.exe - Part 2 (Refresh)
function SP_FUSION360_INSTALL_REFRESH_START_2 {
  WINEPREFIX=$WP_WINEPREFIXES_REFRESH wine $WP_WINEPREFIXES_REFRESH/drive_c/users/$USER/Downloads/Fusion360installer.exe
}

# Stop Fusion360installer.exe - Part 2 (Refresh)
function SP_FUSION360_INSTALL_REFRESH_STOP_2 {
  sleep 1m
  kill -9 $(ps aux |grep -i '\.exe' |awk '{print $2}'|tr '\n' ' ')
}

###############################################################################################################################################################

# Autodesk Fusion 360 will now be installed using Wine and Winetricks.
function SP_FUSION360_INSTALL {
  SP_WINETRICKS_LOAD
  SP_FUSION360_INSTALLER_LOAD
  # Note that the winetricks sandbox verb merely removes the desktop integration and Z: drive symlinks and is not a "true" sandbox.
  # It protects against errors rather than malice. It's useful for, e.g., keeping games from saving their settings in random subdirectories of your home directory. 
  # But it still ensures that wine, for example, no longer has access permissions to Home! 
  # For this reason, the EXE files must be located directly in the Wineprefix folder!
  WINEPREFIX=$WP_DIRECTORY sh $SP_PATH/bin/winetricks -q sandbox
  sleep 5s
  # We must install some packages!
  WINEPREFIX=$WP_DIRECTORY sh $SP_PATH/bin/winetricks -q atmlib gdiplus corefonts cjkfonts dotnet452 msxml4 msxml6 vcrun2017 fontsmooth=rgb winhttp win10
  sleep 5s
  # We must install cjkfonts again then sometimes it doesn't work in the first time!
  WINEPREFIX=$WP_DIRECTORY sh $SP_PATH/bin/winetricks -q cjkfonts
  sleep 5s
  SP_DXVK_OPENGL_1
  # We must copy the EXE-file directly in the Wineprefix folder (Sandbox-Mode)!
  cp "$SP_PATH/downloads/Fusion360installer.exe" "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  # This start and stop the installer automatically after a time! 
  # For more information check this link: https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/issues/232
  SP_FUSION360_INSTALL_PROGRESS
  mkdir -p "$WP_DIRECTORY/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options"
  cd "$WP_DIRECTORY/drive_c/users/$USER/AppData/Roaming/Autodesk/Neutron Platform/Options"
  SP_DXVK_OPENGL_2
  mkdir -p "$WP_DIRECTORY/drive_c/users/$USER/AppData/Local/Autodesk/Neutron Platform/Options"
  cd "$WP_DIRECTORY/drive_c/users/$USER/AppData/Local/Autodesk/Neutron Platform/Options"
  SP_DXVK_OPENGL_2
  mkdir -p "$WP_DIRECTORY/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options"
  cd "$WP_DIRECTORY/drive_c/users/$USER/Application Data/Autodesk/Neutron Platform/Options"
  SP_DXVK_OPENGL_2
  cd "SP_PATH/bin"
  SP_GET_WINEPREFIX_TYPE
  SP_FUSION360_SHORTCUTS_LOAD
  SP_FUSION360_EXTENSIONS
  SP_LOGFILE_WINEPREFIX
  SP_COMPLETED
}

function SP_FUSION360_REFRESH { 
  wget $SP_SERVER_21 -O Fusion360installer.exe
  mv "Fusion360installer.exe" "$SP_PATH/downloads/Fusion360installer.exe"
  rmdir "$WP_WINEPREFIXES_REFRESH/drive_c/users/$USER/Downloads/Fusion360installer.exe"
  cp "$SP_PATH/downloads/Fusion360installer.exe" "$WP_WINEPREFIXES_REFRESH/drive_c/users/$USER/Downloads"
  SP_FUSION360_INSTALL_PROGRESS_REFRESH
}

###############################################################################################################################################################
# ALL FUNCTIONS FOR SUPPORTED LINUX DISTRIBUTIONS START HERE:                                                                                                 #
###############################################################################################################################################################

function OS_ARCHLINUX {
  echo "Checking for multilib..."
  if ARCHLINUX_VERIFY_MULTILIB ; then
    echo "multilib found. Continuing..."
    pkexec sudo pacman -Sy --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
    SP_FUSION360_INSTALL
  else
    echo "Enabling multilib..."
    echo "[multilib]" | sudo tee -a /etc/pacman.conf
    echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a /etc/pacman.conf
    pkexec sudo pacman -Sy --needed wine wine-mono wine_gecko winetricks p7zip curl cabextract samba ppp
    SP_FUSION360_INSTALL
  fi
}

function ARCHLINUX_VERIFY_MULTILIB {
  if cat /etc/pacman.conf | grep -q '^\[multilib\]$' ; then
    true
  else
    false
  fi
}

###############################################################################################################################################################

function DEBIAN_BASED_1 {
  # Some systems require this command for all repositories to work properly and for the packages to be downloaded for installation!
  pkexec sudo apt-get --allow-releaseinfo-change update  
  # Added i386 support for wine!
  sudo dpkg --add-architecture i386
}

function DEBIAN_BASED_2 {
  sudo apt-get update
  sudo apt-get install p7zip p7zip-full p7zip-rar curl winbind cabextract wget
  sudo apt-get install --install-recommends winehq-staging
  SP_FUSION360_INSTALL
}

function OS_DEBIAN_10 {
  sudo apt-add-repository -r 'deb https://dl.winehq.org/wine-builds/debian/ buster main'
  wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10//Release.key -O Release.key -O- | sudo apt-key add -
  sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/ ./'
}

function OS_DEBIAN_11 {
  sudo apt-add-repository -r 'deb https://dl.winehq.org/wine-builds/debian/ bullseye main'
  wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_11//Release.key -O Release.key -O- | sudo apt-key add -
  sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_11/ ./'
}

function OS_UBUNTU_18 {
  sudo apt-add-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
  wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/Release.key -O Release.key -O- | sudo apt-key add -
  sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/ ./'
}

function OS_UBUNTU_20 {
  sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
  wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_20.04/Release.key -O Release.key -O- | sudo apt-key add -
  sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_20.04/ ./'
}

function OS_UBUNTU_22 {
  sudo add-apt-repository -r 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main'
  wget -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_22.04/Release.key -O Release.key -O- | sudo apt-key add -
  sudo apt-add-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_22.04/ ./'
}

###############################################################################################################################################################

function FEDORA_BASED_1 {
  pkexec sudo dnf update
  sudo dnf upgrade
  sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
}

function FEDORA_BASED_2 {
  sudo dnf install p7zip p7zip-plugins curl wget wine cabextract
  SP_FUSION360_INSTALL
}

function OS_FEDORA_35 {
  sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_35/Emulators:Wine:Fedora.repo
}

function OS_FEDORA_36 {
  sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/Emulators:/Wine:/Fedora/Fedora_36/Emulators:Wine:Fedora.repo
}

###############################################################################################################################################################

function OS_OPENSUSE_153 {
  pkexec su -c 'zypper up && zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.3/ wine && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.3/ wine && zypper install p7zip-full curl wget wine cabextract'
  SP_FUSION360_INSTALL
}

# Has not been published yet!
function OS_OPENSUSE_154 {
  pkexec su -c 'zypper up && zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.4/ wine && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.4/ wine && zypper install p7zip-full curl wget wine cabextract'
  SP_FUSION360_INSTALL
}

function OS_OPENSUSE_TW {
  pkexec su -c 'zypper up && zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/ wine && zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Tumbleweed/ wine && zypper install p7zip-full curl wget wine cabextract'
  SP_FUSION360_INSTALL
}

###############################################################################################################################################################

function OS_REDHAT_LINUX_8 {
  pkexec sudo subscription-manager repos --enable codeready-builder-for-rhel-8-x86_64-rpms
  sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
  sudo dnf upgrade
  sudo dnf install wine
  SP_FUSION360_INSTALL
}

function OS_REDHAT_LINUX_9 {
  pkexec sudo subscription-manager repos --enable codeready-builder-for-rhel-9-x86_64-rpms
  sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
  sudo dnf upgrade
  sudo dnf install wine
  SP_FUSION360_INSTALL
}

###############################################################################################################################################################

function OS_SOLUS_LINUX {
  pkexec sudo eopkg install -y wine winetricks p7zip curl cabextract samba ppp
  SP_FUSION360_INSTALL
}

###############################################################################################################################################################

function OS_VOID_LINUX {
  pkexec sudo xbps-install -Sy wine wine-mono wine-gecko winetricks p7zip curl cabextract samba ppp
  SP_FUSION360_INSTALL
}

###############################################################################################################################################################

function OS_GENTOO_LINUX {
  pkexec sudo emerge -nav virtual/wine app-emulation/winetricks app-emulation/wine-mono app-emulation/wine-gecko app-arch/p7zip app-arch/cabextract net-misc/curl net-fs/samba net-dialup/ppp
  SP_FUSION360_INSTALL
}

###############################################################################################################################################################
# ALL FUNCTIONS FOR THE EXTENSIONS START HERE:                                                                                                                #
###############################################################################################################################################################

# Install a extension: Airfoil Tools
function EXTENSION_AIRFOIL_TOOLS {
  cd "$SP_PATH/extensions"
  wget -N https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/raw/main/files/extensions/AirfoilTools_win64.msi &&
  cp AirfoilTools_win64.msi "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  cd "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  WINEPREFIX=$WP_DIRECTORY wine msiexec /i AirfoilTools_win64.msi
}

###############################################################################################################################################################

# Install a extension: Additive Assistant (FFF)
function EXTENSION_ADDITIVE_ASSISTANT {
  cd "$SP_PATH/extensions"
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/AdditiveAssistant.bundle-win64.msi &&
  cp AdditiveAssistant.bundle-win64.msi "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  cd "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  WINEPREFIX=$WP_DIRECTORY wine msiexec /i AdditiveAssistant.bundle-win64.msi
}

###############################################################################################################################################################

# Install a extension: Czech localization for F360
function EXTENSION_CZECH_LOCALE {
  SP_SEARCH_EXTENSION_CZECH_LOCALE &&
  cp $CZECH_LOCALE_EXTENSION "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  cd "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  WINEPREFIX=$WP_DIRECTORY wine msiexec /i $CZECH_LOCALE_EXTENSION
}

###############################################################################################################################################################

# Install a extension: HP 3D Printers for Autodesk® Fusion 360™
function EXTENSION_HP_3DPRINTER_CONNECTOR {
  cd "$SP_PATH/extensions"
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/HP_3DPrinters_for_Fusion360-win64.msi &&
  cp HP_3DPrinters_for_Fusion360-win64.msi "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  cd "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  WINEPREFIX=$WP_DIRECTORY wine msiexec /i HP_3DPrinters_for_Fusion360-win64.msi
}

###############################################################################################################################################################

# Install a extension: Helical Gear Generator
function EXTENSION_HELICAL_GEAR_GENERATOR {
  cd "$SP_PATH/extensions"
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/HelicalGear_win64.msi &&
  cp HelicalGear_win64.msi "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  cd "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  WINEPREFIX=$WP_DIRECTORY wine msiexec /i HelicalGear_win64.msi
}

###############################################################################################################################################################

# Install a extension: OctoPrint for Autodesk® Fusion 360™
function EXTENSION_OCTOPRINT {
  cd "$SP_PATH/extensions"
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/OctoPrint_for_Fusion360-win64.msi &&
  cp OctoPrint_for_Fusion360-win64.msi "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  cd "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  WINEPREFIX=$WP_DIRECTORY wine msiexec /i OctoPrint_for_Fusion360-win64.msi
}

###############################################################################################################################################################

# Install a extension: Parameter I/O
function EXTENSION_PARAMETER_IO {
  cd "$SP_PATH/extensions" 
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/ParameterIO_win64.msi &&
  cp ParameterIO_win64.msi "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  cd "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  WINEPREFIX=$WP_DIRECTORY wine msiexec /i ParameterIO_win64.msi
}

###############################################################################################################################################################

# Install a extension: RoboDK
function EXTENSION_ROBODK {
  cd "$SP_PATH/extensions"  
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/RoboDK.bundle-win64.msi &&
  cp RoboDK.bundle-win64.msi "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  cd "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  WINEPREFIX=$WP_DIRECTORY wine msiexec /i RoboDK.bundle-win64.msi
}

###############################################################################################################################################################

# Install a extension: Ultimaker Digital Factory for Autodesk Fusion 360™
function EXTENSION_ULTIMAKER_DIGITAL_FACTORY {
  cd "$SP_PATH/extensions"
  wget -N https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux/raw/main/files/extensions/Ultimaker_Digital_Factory-win64.msi &&
  cp Ultimaker_Digital_Factory-win64.msi "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  cd "$WP_DIRECTORY/drive_c/users/$USER/Downloads"
  WINEPREFIX=$WP_DIRECTORY wine msiexec /i Ultimaker_Digital_Factory-win64.msi
}

###############################################################################################################################################################
# ALL DIALOGS ARE ARRANGED HERE:                                                                                                                              #
###############################################################################################################################################################

function SP_WELCOME {
yad \
--form \
--separator="" \
--center \
--height=125 \
--width=750 \
--buttons-layout=center \
--title="$SP_TITLE" \
--field="<big>$SP_SUBTITLE</big>:LBL" \
--field="$SP_WELCOME_LABEL_1:LBL" \
--field="$SP_WELCOME_LABEL_2:LBL" \
--align=center \
--button=gtk-about!!"$SP_WELCOME_TOOLTIP_1":1 \
--button=gtk-preferences!!"$SP_WELCOME_TOOLTIP_2":2 \
--button=gtk-cancel:99 \
--button=gtk-ok:3

ret=$?

# Responses to above button presses are below:
if [[ $ret -eq 1 ]]; then
    xdg-open https://github.com/cryinkfly/Autodesk-Fusion-360-for-Linux
    SP_WELCOME
elif [[ $ret -eq 2 ]]; then
    SP_SETTINGS
    SP_LOCALE_SETTINGS
    SP_DRIVER_SETTINGS
    SP_WELCOME
elif [[ $ret -eq 3 ]]; then
    SP_LICENSE
fi
}

###############################################################################################################################################################

function SP_SETTINGS {
yad --title="$SP_TITLE" \
--form --separator="," --item-separator="," \
--borders=15 \
--width=550 \
--buttons-layout=center \
--align=center \
--field="<big><b>$SP_SETTINGS_TITLE</b></big>:LBL" \
--field=":LBL" \
--field="$SP_SETTINGS_LABEL_1:LBL" \
--field="$SP_LOCALE_LABEL:CB" \
--field="$WP_DRIVER_LABEL:CB" \
--field="$SP_SETTINGS_LABEL_2:LBL" \
"" "" "" "$SP_LOCALE_SELECT" "$WP_DRIVER_SELECT" "" | while read line; do
echo "`echo $line | awk -F',' '{print $4}'`" > /tmp/fusion360/settings.txt
echo "`echo $line | awk -F',' '{print $5}'`" >> /tmp/fusion360/settings.txt
cp "/tmp/fusion360/settings.txt" "$SP_PATH/config"
done
}

###############################################################################################################################################################

function SP_LICENSE {
SP_LICENSE_TEXT=$(cat $LICENSE)
SP_LICENSE_CHECK=$(yad \
--title="$SP_TITLE" \
--form \
--borders=15 \
--width=550 \
--height=450 \
--buttons-layout=center \
--align=center \
--field=":TXT" "$SP_LICENSE_TEXT" \
--field="$SP_LICENSE_CHECK_LABEL:CHK" )

if [[ $SP_LICENSE_CHECK = *"TRUE"* ]]; then
    echo "TRUE"
    SP_LOGFILE_WINEPREFIX_CHECK
else
    echo "FALSE"
    SP_WELCOME
fi
}

###############################################################################################################################################################

function SP_LOGFILE_WINEPREFIX_INFO {
yad \
--form \
--separator="" \
--center \
--height=125 \
--width=750 \
--buttons-layout=center \
--title="$SP_TITLE" \
--field="<big>$SP_LOGFILE_WINEPREFIX_INFO_TITLE</big>:LBL" \
--field="$SP_LOGFILE_WINEPREFIX_INFO_LABEL_1:LBL" \
--field="$SP_LOGFILE_WINEPREFIX_INFO_LABEL_2:LBL" \
--align=center \
--button=gtk-new!!"$SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_1":1 \
--button=gtk-refresh!!"$SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_2":2 \
--button=gtk-delete!!"$SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_3":3 \
--button=gtk-cancel:99

ret=$?

# Responses to above button presses are below:
if [[ $ret -eq 1 ]]; then
    SP_INSTALLDIR 
elif [[ $ret -eq 2 ]]; then
    # Get informations about the current wineprefix - Repair
    WP_WINEPREFIXES_STRING=$(yad --height=300 --separator="" --list --radiolist --column="$SELECT" --column="$WINEPREFIXES_TYPE" --column="$WINEPREFIXES_DRIVER" --column="$WINEPREFIXES_DIRECTORY" < /tmp/fusion360/logs/wineprefixes.log)
    WP_WINEPREFIXES_REFRESH=${WP_WINEPREFIXES_STRING/#TRUE}
    SP_FUSION360_REFRESH
elif [[ $ret -eq 3 ]]; then
    # Get informations about the current wineprefix - Delete
    . $SP_PATH/bin/uninstall.sh
fi
}

###############################################################################################################################################################

function SP_INSTALLDIR {
WP_DIRECTORY=$(yad --title="$SP_TITLE" \
--form --separator="" \
--borders=15 \
--width=550 \
--buttons-layout=center \
--align=center \
--field="<big><b>$SP_INSTALLDIR_TITLE</b></big>:LBL" \
--field=":LBL" \
--field="<b>$SP_INSTALLDIR_LABEL_1</b>:LBL" \
--field="$SP_INSTALLDIR_LABEL_2:CB" \
--field="<b>$SP_INSTALLDIR_LABEL_3</b>:LBL" \
"" "" "" "$SP_PATH/wineprefixes/default" "" )

# Continue with the installation ...
SP_INSTALLDIR_CHECK
}

###############################################################################################################################################################

function SP_INSTALLDIR_INFO {
yad \
--form \
--separator="" \
--center \
--height=125 \
--width=750 \
--buttons-layout=center \
--title="$SP_TITLE" \
--field="<big>$SP_INSTALLDIR_INFO_TITLE</big>:LBL" \
--field="$SP_INSTALLDIR_INFO_LABEL_1:LBL" \
--field="$SP_INSTALLDIR_INFO_LABEL_2:LBL" \
--align=center \
--button=gtk-cancel:99 \
--button=gtk-ok:1

ret=$?

# Responses to above button presses are below:
if [[ $ret -eq 1 ]]; then
    SP_INSTALLDIR 
fi
}

###############################################################################################################################################################

function SP_WINE_SETTINGS {
WINE_VERSION=$(yad --title="$SP_TITLE" \
--form --separator="" --item-separator="," \
--borders=15 \
--width=550 \
--buttons-layout=center \
--align=center \
--field="<big><b>$SP_WINE_SETTINGS_TITLE</b></big>:LBL" \
--field=":LBL" \
--field="<b>$SP_WINE_SETTINGS_LABEL_1</b>:LBL" \
--field="$SP_WINE_SETTINGS_LABEL_2:CB" \
--field="<b>$SP_WINE_SETTINGS_LABEL_3</b>:LBL" \
"" "" "" "$SP_WINE_VERSION_SELECT" "" )

# Czech:
if [[ $WINE_VERSION = "Verze vína (Staging)" ]]; then
    echo "Install Wine on your system!"
    SP_OS_SETTINGS
# German:    
elif [[ $WINE_VERSION = "Wine Version (Entwicklungsversion)" ]]; then
    echo "Install Wine on your system!"
    SP_OS_SETTINGS
# English:    
elif [[ $WINE_VERSION = "Wine Version (Staging)" ]]; then
    echo "Install Wine on your system!"
    SP_OS_SETTINGS
# Spanish:    
elif [[ $WINE_VERSION = "Versión Vino (Puesta en Escena)" ]]; then
    echo "Install Wine on your system!"
    SP_OS_SETTINGS
# French:    
elif [[ $WINE_VERSION = "Version Vin (Mise en scène)" ]]; then
    echo "Install Wine on your system!"
    SP_OS_SETTINGS
# Italian:    
elif [[ $WINE_VERSION = "Versione vino (messa in scena)" ]]; then
    echo "Install Wine on your system!"
    SP_OS_SETTINGS
# Japanese:    
elif [[ $WINE_VERSION = "ワインバージョン（ステージング）" ]]; then
    echo "Install Wine on your system!"
    SP_OS_SETTINGS
# Korean:    
elif [[ $WINE_VERSION = "와인 버전(스테이징)" ]]; then
    echo "Install Wine on your system!"
    SP_OS_SETTINGS
# Chinese:    
elif [[ $WINE_VERSION = "葡萄酒版（分期）" ]]; then
    echo "Install Wine on your system!"
    SP_OS_SETTINGS
else
    echo "Wine version (6.23 or higher) is already installed on the system!"
    SP_FUSION360_INSTALL
fi
}

###############################################################################################################################################################

function SP_OS_SETTINGS {
SP_OS=$(yad --title="$SP_TITLE" \
--form --separator="" --item-separator="," \
--borders=15 \
--width=550 \
--buttons-layout=center \
--align=center \
--field="<big><b>$SP_OS_TITLE</b></big>:LBL" \
--field=":LBL" \
--field="$SP_OS_LABEL_1:LBL" \
--field="$SP_OS_LABEL_2:CB" \
"" "" "" "$SP_OS_SELECT" )

if [[ $SP_OS = "Arch Linux" ]]; then
    echo "Arch Linux"
    OS_ARCHLINUX
elif [[ $SP_OS = "Debian 10" ]]; then
    echo "Debian 10"
    DEBIAN_BASED_1
    OS_DEBIAN_10
    DEBIAN_BASED_1
elif [[ $SP_OS = "Debian 11" ]]; then
    echo "Debian 11"
    DEBIAN_BASED_1
    OS_DEBIAN_11
    DEBIAN_BASED_1
elif [[ $SP_OS = "EndeavourOS" ]]; then
    echo "EndeavourOS"
    OS_ARCHLINUX
elif [[ $SP_OS = "Fedora 36" ]]; then
    echo "Fedora 36"
    FEDORA_BASED_1
    OS_FEDORA_36
    FEDORA_BASED_1
elif [[ $SP_OS = "Linux Mint 19.x" ]]; then
    echo "Linux Mint 19.x"
    DEBIAN_BASED_1
    OS_UBUNTU_18
    DEBIAN_BASED_2
elif [[ $SP_OS = "Linux Mint 20.x" ]]; then
    echo "Linux Mint 20.x"
    DEBIAN_BASED_1
    OS_UBUNTU_20
    DEBIAN_BASED_1
elif [[ $SP_OS = "Linux Mint 21.x" ]]; then
    echo "Linux Mint 21.x"
    DEBIAN_BASED_1
    OS_UBUNTU_22
    DEBIAN_BASED_1
elif [[ $SP_OS = "Manjaro Linux" ]]; then
    echo "Manjaro Linux"
    OS_ARCHLINUX
elif [[ $SP_OS = "openSUSE Leap 15.3" ]]; then
    echo "openSUSE Leap 15.3"
    OS_OPENSUSE_153
elif [[ $SP_OS = "openSUSE Leap 15.4" ]]; then
    echo "openSUSE Leap 15.4"
    OS_OPENSUSE_154
elif [[ $SP_OS = "openSUSE Tumbleweed" ]]; then
    echo "openSUSE Tumbleweed"
    OS_OPENSUSE_TW
elif [[ $SP_OS = "Red Hat Enterprise Linux 8.x" ]]; then
    echo "Red Hat Enterprise Linux 8.x"
    OS_REDHAT_LINUX_8
elif [[ $SP_OS = "Red Hat Enterprise Linux 9.x" ]]; then
    echo "Red Hat Enterprise Linux 9.x"
    OS_REDHAT_LINUX_9
elif [[ $SP_OS = "Solus" ]]; then
    echo "Solus"
    OS_SOLUS_LINUX
elif [[ $SP_OS = "Ubuntu 18.04" ]]; then
    echo "Ubuntu 18.04"
    DEBIAN_BASED_1
    OS_UBUNTU_18
    DEBIAN_BASED_2
elif [[ $SP_OS = "Ubuntu 20.04" ]]; then
    echo "Ubuntu 20.04"
    DEBIAN_BASED_1
    OS_UBUNTU_20
    DEBIAN_BASED_2
elif [[ $SP_OS = "Ubuntu 22.04" ]]; then
    echo "Ubuntu 22.04"
    DEBIAN_BASED_1
    OS_UBUNTU_22
    DEBIAN_BASED_2
elif [[ $SP_OS = "Void Linux" ]]; then
    echo "Void Linux"
    OS_VOID_LINUX
elif [[ $SP_OS = "Gentoo Linux" ]]; then
    echo "Gentoo Linux"
    OS_GENTOO_LINUX
fi
}

###############################################################################################################################################################

function SP_FUSION360_INSTALL_PROGRESS {

SP_FUSION360_INSTALL_PROGRESS_MAIN () {
echo "20"
SP_FUSION360_INSTALL_START_1 & SP_FUSION360_INSTALL_STOP_1 # These two commands run in the same time.
echo "70"
SP_FUSION360_INSTALL_START_1 & SP_FUSION360_INSTALL_STOP_1 # These two commands run in the same time.
sleep 5
echo "100"
}

SP_FUSION360_INSTALL_PROGRESS_MAIN | yad --progress --progress-text "$SP_INSTALL_PROGRESS_LABEL" --percentage=0 --auto-close
}

###############################################################################################################################################################

function SP_FUSION360_INSTALL_PROGRESS_REFRESH {

SP_FUSION360_INSTALL_PROGRESS_MAIN_REFRESH () {
echo "20"
SP_FUSION360_INSTALL_REFRESH_START_1 & SP_FUSION360_INSTALL_REFRESH_STOP_1 # These two commands run in the same time.
echo "70"
SP_FUSION360_INSTALL_REFRESH_START_2 & SP_FUSION360_INSTALL_REFRESH_STOP_2 # These two commands run in the same time.
sleep 5
echo "100"
}

SP_FUSION360_INSTALL_PROGRESS_MAIN_REFRESH | yad --progress --progress-text "$SP_INSTALL_PROGRESS_REFRESH_LABEL" --percentage=0 --auto-close
}

###############################################################################################################################################################

function SP_FUSION360_EXTENSIONS {
EXTENSIONS=$(yad --title="$SP_TITLE" --button=gtk-cancel:99 --button=gtk-ok:0 --height=300 --list --multiple --checklist --column=$SP_EXTENSION_SELECT --column=$SP_EXTENSION_NAME --column=$SP_EXTENSION_DESCRIPTION < $SP_EXTENSION_LIST)

if [[ $EXTENSIONS = *"Airfoil Tools"* ]]; then
    echo "Airfoil Tools"
    EXTENSION_AIRFOIL_TOOLS
fi

if [[ $EXTENSIONS = *"Additive Assistant (FFF)"* ]]; then
    echo "Additive Assistant (FFF)"
    EXTENSION_ADDITIVE_ASSISTANT
fi

if [[ $EXTENSIONS = *"Czech localization for F360"* ]]; then
    echo "Czech localization for F360"
    EXTENSION_CZECH_LOCALE
fi

if [[ $EXTENSIONS = *"HP 3D Printers for Autodesk® Fusion 360™"* ]]; then
    echo "HP 3D Printers for Autodesk® Fusion 360™"
    EXTENSION_HP_3DPRINTER_CONNECTOR
fi

if [[ $EXTENSIONS = *"Helical Gear Generator"* ]]; then
    echo "Helical Gear Generator"
    EXTENSION_HELICAL_GEAR_GENERATOR
fi

if [[ $EXTENSIONS = *"OctoPrint for Autodesk® Fusion 360™"* ]]; then
    echo "OctoPrint for Autodesk® Fusion 360™"
    EXTENSION_OCTOPRINT
fi

if [[ $EXTENSIONS = *"Parameter I/O"* ]]; then
    echo "Parameter I/O"
    EXTENSION_PARAMETER_IO
fi

if [[ $EXTENSIONS = *"RoboDK"* ]]; then
    echo "RoboDK"
    EXTENSION_ROBODK
fi

if [[ $EXTENSIONS = *"Ultimaker Digital Factory for Autodesk Fusion 360™"* ]]; then
    echo "Ultimaker Digital Factory for Autodesk Fusion 360™"
    EXTENSION_ULTIMAKER_DIGITAL_FACTORY
fi
}

###############################################################################################################################################################

# Select the downloaded installer for this special extension!
function SP_SEARCH_EXTENSION_CZECH_LOCALE {
  CZECH_LOCALE_EXTENSION=$(yad --title="$SP_TITLE" \
  --form --separator="" \
  --borders=15 \
  --width=550 \
  --buttons-layout=center \
  --align=center \
  --field="<big><b>$SP_SEARCH_EXTENSION_CZECH_LOCALE_TITLE</b></big>:LBL" \
  --field=":LBL" \
  --field="<b>$SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_1</b>:LBL" \
  --field="$SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_2:FL" \
  --field="<b>$SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_3</b>:LBL" \
  "" "" "" "$HOME" "" )
}

###############################################################################################################################################################

# The installation is complete and will be terminated.
function SP_COMPLETED {
  echo "The installation is completed!"
  SP_COMPLETED_CHECK=$(yad \
  --title="$SP_TITLE" \
  --form \
  --borders=15 \
  --width=550 \
  --height=450 \
  --buttons-layout=center \
  --align=center \
  --field=":TXT" "$SP_COMPLETED_TEXT" \
  --field="$SP_COMPLETED_CHECK_LABEL:CHK" )

  if [[ $SP_LICENSE_CHECK = *"TRUE"* ]]; then
    echo "TRUE"
    . $WP_DIRECTORY/box-run.sh
  else
    echo "FALSE"
  fi
}

###############################################################################################################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:                                                                                                                   #
###############################################################################################################################################################

SP_STRUCTURE
SP_LOGFILE_INSTALL
SP_LOCALE_INDEX
SP_WELCOME
