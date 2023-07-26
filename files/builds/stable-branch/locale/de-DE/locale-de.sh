#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This is the German translation for the Setup Wizard.                              #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    18:00/26.07.2023                                                                   #
# Version:      1.6.1                                                                              #
####################################################################################################

# Path: /$HOME/.fusion360/locale/de-DE/locale-de.sh

###############################################################################################################################################################
# ALL DEFINITIONS FOR AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                                  #
###############################################################################################################################################################

# Window Title (Setup Wizard)
SP_TITLE="Setup-Assistent - Autodesk Fusion 360 für Linux"

# Window Title:
SP_SUBTITLE="Willkommen zum Autodesk Fusion 360 Setup-Assistenten für Linux"

# Welcome Screen:
SP_WELCOME_LABEL_1="Dieser Einrichtungsassistent installiert Autodesk Fusion 360 auf Ihrem Computer, damit Sie auch unter Linux an Ihren Projekten arbeiten können."
SP_WELCOME_LABEL_2="Klicken Sie auf OK, um fortzufahren oder auf Abbrechen, um den Einrichtungsassistenten zu verlassen."
SP_WELCOME_TOOLTIP_1="Hier erhalten Sie weitere Informationen zu diesem Einrichtungsassistenten."
SP_WELCOME_TOOLTIP_2="Hier können Sie die Standardeinstellung anpassen. Zum Beispiel die Sprache."

###############################################################################################################################################################

# General Settings:
SP_SETTINGS_TITLE="Allgemeine Einstellungen"
SP_SETTINGS_LABEL_1="Hier haben Sie die Möglichkeit weitere Einstellungen vorzunehmen*:"
SP_SETTINGS_LABEL_2="*Bitte denken Sie daran, dass sich jede Änderung auf die Installation von Autodesk Fusion 360 auswirkt!"
SP_LOCALE_LABEL="Sprachen"
SP_LOCALE_SELECT=$(echo "Czech,English,German,Spanish,French,Italian,Japanese,Korean,Chinese")
WP_DRIVER_LABEL="Grafiktreiber"
WP_DRIVER_SELECT=$(echo "DXVK,OpenGL")

# License Checkbox:
SP_LICENSE_CHECK_LABEL="Ich habe die Lizenzvereinbachung gelesen und akzeptiert."
SP_LICENSE="$SP_PATH/locale/de-DE/license-de.txt"

###############################################################################################################################################################

# Wineprefix Info - Autodesk Fusion 360 exist on the computer:
SP_LOGFILE_WINEPREFIX_INFO_TITLE="$SP_TITLE"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_1="Auf Ihrem System wurde eine frühere Installation von Autodesk Fusion 360 erkannt!"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_2="Wählen Sie daher bitte eine der folgenden Optionen aus, um fortzufahren!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_1="Erstellen Sie eine neue Wineprefix an einem anderen Ort!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_2="Reparieren Sie eine aktuelle Wineprefix auf Ihrem System!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_3="Entfernen Sie eine aktuelle Wineprefix von Ihrem System!"

###############################################################################################################################################################

# Linux distribution - Configuration:
SP_OS_TITLE="Linux-Distribution - Konfiguration"
SP_OS_LABEL_1="In diesem Schritt können Sie nun Ihre Linux-Distribution auswählen, um die benötigten Pakete für die Installation zu installieren."
SP_OS_LABEL_2="Linux-Distribution:"
SP_OS_SELECT=$(echo "Arch Linux,Debian 10,Debian 11,EndeavourOS,Fedora 35,Fedora 36,Linux Mint 19.x,Linux Mint 20.x,Linux Mint 21.x,Linux Mint 5.x - LMDE Version,Manjaro Linux,openSUSE Leap 15.3,openSUSE Leap 15.4,openSUSE Tumbleweed,Red Hat Enterprise Linux 8.x,Red Hat Enterprise Linux 9.x,Solus,Ubuntu 18.04,Ubuntu 20.04,Ubuntu 22.04,Ubuntu 23.04,Void Linux,Gentoo Linux")

###############################################################################################################################################################

# Installation Folder - Configuration:
SP_INSTALLDIR_TITLE="Wählen Sie das Ziel der Installation aus"
SP_INSTALLDIR_LABEL_1="Der Setup-Assistent installiert Autodesk Fusion 360 im folgenden Verzeichnis*."
SP_INSTALLDIR_LABEL_2="Verzeichnis:"
SP_INSTALLDIR_LABEL_3="*Sie können auch ein anderes Verzeichnis für die Installation auswählen, indem Sie in das Feld klicken."

###############################################################################################################################################################

# Directory info:
SP_INSTALLDIR_INFO_TITLE="Installationsverzeichnis wählen - Info"
SP_INSTALLDIR_INFO_LABEL_1="Achtung! Dieses Verzeichnis existiert bereits!"
SP_INSTALLDIR_INFO_LABEL_2="Bitte wählen Sie ein anderes Verzeichnis."

###############################################################################################################################################################

# Wine Version
SP_WINE_SETTINGS_TITLE="Wählen Sie Wine-Version"
SP_WINE_SETTINGS_LABEL_1="Hier müssen Sie sich zwischen zwei Optionen* entscheiden."
SP_WINE_SETTINGS_LABEL_2="Auswählen:"
SP_WINE_VERSION_SELECT=$(echo "Wine-Version (Staging),Wine-Version (6.23 oder höher) ist bereits auf dem System installiert!")
SP_WINE_SETTINGS_LABEL_3="*Je nach gewählter Option werden weitere Pakete auf Ihrem System installiert!"

###############################################################################################################################################################

SP_INSTALL_PROGRESS_LABEL="Autodesk Fusion 360 wird auf Ihrem System installiert ..."
SP_INSTALL_PROGRESS_REFRESH_LABEL="Autodesk Fusion 360 wird auf diesem System aktualisiert ..."

###############################################################################################################################################################

# Extension - Configuration:
SP_EXTENSION_SELECT="Auswählen"
SP_EXTENSION_NAME="Erweiterung"
SP_EXTENSION_DESCRIPTION="Beschreibung"

SP_EXTENSION_LIST="$SP_PATH/locale/de-DE/extensions-de.txt"

SP_SEARCH_EXTENSION_CZECH_LOCALE_TITLE="Installation - Tschechische Spracherweiterung"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_1="Wählen Sie die Datei* aus, in der sich die Erweiterung befindet!"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_2="Datei:"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_3="*Standardmäßig finden Sie Ihre heruntergeladenen Erweiterungen im Download-Verzeichnis."

###############################################################################################################################################################
# ALL DEFINITIONS FOR UNINSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

DL_TITLE="Deinstallationsprogramm - Autodesk Fusion 360 für Linux"
DL_SUBTITLE="Willkommen zum Autodesk Fusion 360 Deinstallationsprogramm für Linux"
DL_WELCOME_LABEL_1="Autodesk Fusion 360 wird von Ihrem Computer deinstalliert!"
DL_WELCOME_LABEL_2="Klicken Sie auf OK, um fortzufahren oder auf Abbrechen, um dieses Deinstallationsprogramm zu beenden."
DL_WELCOME_TOOLTIP_1="Hier erhalten Sie weitere Informationen zu diesem Deinstallationsprogramm."

DL_WINEPREFIXES_DEL_INFO_TEXT="Möchten Sie die ausgewählte Wineprefix wirklich von Ihrem Computer entfernen?"
DL_WINEPREFIXES_DEL_INFO_LABEL="Ja, mir ist bekannt, dass alle meine persönlichen Daten in der Wineprefix verloren gehen."

###############################################################################################################################################################

SP_COMPLETED_TEXT="Autodesk Fusion 360 wurde erfolgreich auf Ihrem Computer installiert und eingerichtet."
SP_COMPLETED_CHECK_LABEL="Autodesk Fusion 360 ausführen"

###############################################################################################################################################################
# ALL DEFINITIONS FOR THE LAUNCHER OF AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                  #
###############################################################################################################################################################

UP_TITLE="Autodesk Fusion 360 für Linux – Launcher"
UP_NO_UPDATE_INFO_LABEL="Es wurde keine neuere Version gefunden, daher ist Ihr Autodesk Fusion 360 auf dem neuesten Stand!"
UP_SKIP_INFO_LABEL="Das Update wurde übersprungen! Bitte aktualisieren Sie bald Ihre Autodesk Fusion 360 Version!"
UP_SKIP_UPDATE_QUESTION_LABEL="Sind Sie sicher, dass Sie die Suche nach einem Autodesk Fusion 360 Update überspringen möchten?"

UP_QUESTION_LABEL="Eine neue Version wurde veröffentlicht! Möchten Sie jetzt aktualisieren?"

UP_NO_CONNECTION_WARNING_LABEL="Die Verbindung zum Server konnte nicht hergestellt werden! Die Suche nach neuen Updates wurde übersprungen! Bitte überprüfen Sie Ihre Internetverbindung!"

UP_PROGRESS_LABEL_1="Verbinde mit dem Server ..."
UP_PROGRESS_LABEL_2="# Alle Dateien werden geprüft .."
UP_PROGRESS_LABEL_3="# Alle Dateien wurden geprüft!"
UP_INSTALL_UPDATE_PROGRESS_LABEL="Autodesk Fusion 360 wird auf eine neuere Version aktualisiert ..."

###############################################################################################################################################################
###############################################################################################################################################################

SELECT="Auswählen"
WINEPREFIXES_TYPE="Wineprefix Typ"
WINEPREFIXES_DRIVER="Wineprefix Treiber"
WINEPREFIXES_DIRECTORY="Wineprefix Verzeichnis"
