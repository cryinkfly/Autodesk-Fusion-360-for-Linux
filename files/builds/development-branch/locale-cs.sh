#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This is the Czech translation for the Setup Wizard.                                #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    21:10/08.06.2022                                                                   #
# Version:      1.5 -> 1.6                                                                         #
####################################################################################################

# Path: /$HOME/.fusion360/locale/cs-CZ/locale-cs.sh

###############################################################################################################################################################
# ALL DEFINITIONS FOR AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                                  #
###############################################################################################################################################################

# Window Title (Setup Wizard)
SP_TITLE="Průvodce instalací - Autodesk Fusion 360 pro Linux"

# Window Title:
SP_SUBTITLE="Vítejte v instalačním programu Autodesk Fusion 360 pro Linux"

# Welcome Screen:
SP_WELCOME_LABEL_1="Tento průvodce nastavením nainstaluje Autodesk Fusion 360 do vašeho počítače, abyste mohli na svých projektech pracovat také v systému Linux."
SP_WELCOME_LABEL_2="Klikněte na OK pro pokračování nebo Storno pro ukončení průvodce nastavením."
SP_WELCOME_TOOLTIP_1="Zde získáte další informace o tomto průvodci nastavením."
SP_WELCOME_TOOLTIP_2="Zde můžete upravit výchozí nastavení. Například jazyk."

###############################################################################################################################################################

# General Settings:
SP_SETTINGS_TITLE="Obecné nastavení"
SP_SETTINGS_LABEL_1="Zde máte možnost upravit* další nastavení:"
SP_SETTINGS_LABEL_2="*Pamatujte prosím, že jakákoli změna ovlivní instalaci Autodesk Fusion 360!"
SP_LOCALE_LABEL="Jazyky"
SP_LOCALE_SELECT=$(echo "Czech,English,German,Spanish,French,Italian,Japanese,Korean,Chinese")
WP_DRIVER_LABEL="Ovladač grafiky"
WP_DRIVER_SELECT=$(echo "DXVK,OpenGL")

# License Checkbox:
SP_LICENSE_CHECK_LABEL="Přečetl jsem si podmínky a souhlasím s nimi."
SP_LICENSE="$SP_PATH/locale/cs-CZ/license-cs.txt"

###############################################################################################################################################################

# Wineprefix Info - Autodesk Fusion 360 exist on the computer:
SP_LOGFILE_WINEPREFIX_INFO_TITLE="$SP_SUBTITLE"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_1="Ve vašem systému byla zjištěna předchozí instalace Autodesk Fusion 360!"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_2="Proto pro pokračování vyberte jednu z níže uvedených možností!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_1="Vytvořte nový Wineprefix na jiném místě!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_2="Opravte aktuální Wineprefix na vašem systému!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_3="Odstraňte aktuální Wineprefix ze svého systému!"

###############################################################################################################################################################

# Linux distribution - Configuration:
SP_OS_TITLE="Linux distribuce - Konfigurace"
SP_OS_LABEL_1="V tomto kroku nyní můžete vybrat svou distribuci Linuxu a nainstalovat potřebné balíčky pro instalaci."
SP_OS_LABEL_2="Linux distribuce:"
SP_OS_SELECT=$(echo "Arch Linux,Debian 10,Debian 11,EndeavourOS,Fedora 35,Fedora 36,Linux Mint 19.x,Linux Mint 20.x,Manjaro Linux,openSUSE Leap 15.3,openSUSE Leap 15.4,openSUSE Tumbleweed,Red Hat Enterprise Linux 8.x,Red Hat Enterprise Linux 9.x,Solus,Ubuntu 18.04,Ubuntu 20.04,Ubuntu 22.04,Void Linux,Gentoo Linux")

###############################################################################################################################################################

# Installation Folder - Configuration:
SP_INSTALLDIR_TITLE="Vyberte cíl instalace"
SP_INSTALLDIR_LABEL_1="Průvodce nastavením nainstaluje Autodesk Fusion 360 do následujícího adresáře*."
SP_INSTALLDIR_LABEL_2="Adresář:"
SP_INSTALLDIR_LABEL_3="*Kliknutím do pole můžete také vybrat jiný adresář pro instalaci."

###############################################################################################################################################################

# Directory info:
SP_INSTALLDIR_INFO_TITLE="Vyberte Instalační adresář - Informace"
SP_INSTALLDIR_INFO_LABEL_1="Nebezpečí! Tento adresář již existuje!"
SP_INSTALLDIR_INFO_LABEL_2="Vyberte prosím jiný adresář."

###############################################################################################################################################################

# Wine Version
SP_WINE_SETTINGS_TITLE="Vyberte verzi vína"
SP_WINE_SETTINGS_LABEL_1="Zde se musíte rozhodnout mezi dvěma možnostmi*."
SP_WINE_SETTINGS_LABEL_2="Vybrat:"
SP_WINE_VERSION_SELECT=$(echo "Verze vína (Staging), Verze vína (6.23 nebo vyšší) je již nainstalována v systému!")
SP_WINE_SETTINGS_LABEL_3="*V závislosti na zvolené možnosti se na váš systém nainstalují další balíčky!"

###############################################################################################################################################################

SP_INSTALL_PROGRESS_LABEL="Autodesk Fusion 360 se nainstaluje do vašeho systému ..."
SP_INSTALL_PROGRESS_REFRESH_LABEL="Autodesk Fusion 360 je v tomto systému aktualizován ..."

###############################################################################################################################################################

# Extension - Configuration:
SP_EXTENSION_SELECT="Vybrat"
SP_EXTENSION_NAME="Rozšíření"
SP_EXTENSION_DESCRIPTION="Popis"

SP_EXTENSION_LIST="$SP_PATH/locale/cs-CZ/extensions-cs.txt"

SP_SEARCH_EXTENSION_CZECH_LOCALE_TITLE="Nainstalujte rozšíření Czech-Locale-Extension"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_1="Vyberte soubor*, ve kterém je přípona umístěna!"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_2="Soubor:"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_3="*Ve výchozím nastavení najdete stažená rozšíření v adresáři pro stahování."

###############################################################################################################################################################
# ALL DEFINITIONS FOR UNINSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

DL_TITLE="Vítejte v odinstalačním programu Autodesk Fusion 360 pro Linux"
DL_SUBTITLE="Vítejte v odinstalačním programu Autodesk Fusion 360 pro Linux"
DL_WELCOME_LABEL_1="Autodesk Fusion 360 bude z vašeho počítače odinstalován!"
DL_WELCOME_LABEL_2="Klikněte na OK pro pokračování nebo Storno pro ukončení tohoto odinstalačního programu."
DL_WELCOME_TOOLTIP_1="Zde získáte další informace o tomto odinstalačním programu."

DL_WINEPREFIXES_DEL_INFO_TEXT="Opravdu chcete smazat vybraný Wineprefix z vašeho počítače?"
DL_WINEPREFIXES_DEL_INFO_LABEL="Ano, jsem si vědom toho, že všechna moje osobní data budou ve Wineprefixu ztracena."

###############################################################################################################################################################

SP_COMPLETED_TEXT="Autodesk Fusion 360 byl úspěšně nainstalován a nastaven na vašem počítači."
SP_COMPLETED_CHECK_LABEL="Spusťte Autodesk Fusion 360"

###############################################################################################################################################################
# ALL DEFINITIONS FOR THE LAUNCHER OF AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                  #
###############################################################################################################################################################

LAUNCHER_NO_UPDATE_INFO="Nebyla nalezena žádná novější verze, takže váš Autodesk fusion 360 je aktuální!"

LAUNCHER_SKIP_UPDATE_INFO="Aktualizace byla přeskočena! Aktualizujte prosím svou verzi Autodesk Fusion 360 brzy!"
LAUNCHER_SKIP_UPDATE_QUESTION="Opravdu chcete přeskočit hledání aktualizace Autodesk Fusion 360?"

LAUNCHER_UPDATE_QUESTION="Byla vydána nová verze! Chcete provést aktualizaci?"

LAUNCHER_UPDATE_WARNING="Spojení se serverem nelze navázat! Kontrola nových aktualizací byla přeskočena! Zkontrolujte prosím své internetové připojení!"

UP_TITLE="Autodesk Fusion 360 pro Linux - Launcher"
UP_NO_UPDATE_INFO_LABEL="Nebyla nalezena žádná novější verze, takže váš Autodesk fusion 360 je aktuální!"
UP_SKIP_INFO_LABEL="Aktualizace byla přeskočena! Aktualizujte prosím svou verzi Autodesk Fusion 360 brzy!"
UP_SKIP_UPDATE_QUESTION_LABEL="Opravdu chcete přeskočit hledání aktualizace Autodesk Fusion 360?"

UP_QUESTION_LABEL="Byla vydána nová verze! Chcete provést aktualizaci?"

UP_NO_CONNECTION_WARNING_LABEL="Připojení k serveru nelze navázat! Kontrola nových aktualizací byla přeskočena! Zkontrolujte prosím své internetové připojení!"

UP_PROGRESS_LABEL_1="Připojování k serveru ..."
UP_PROGRESS_LABEL_2="# Zkontrolovat všechny soubory .."
UP_PROGRESS_LABEL_3="# Všechny soubory jsou zkontrolovány!"
UP_INSTALL_UPDATE_PROGRESS_LABEL="Autodesk Fusion 360 bude aktualizován na novější verzi ..."

###############################################################################################################################################################
###############################################################################################################################################################

SELECT="Vybrat"
WINEPREFIXES_TYPE="Typ předpony vína"
WINEPREFIXES_DRIVER="Ovladač pro předpony vína"
WINEPREFIXES_DIRECTORY="Adresář předpon vína"
