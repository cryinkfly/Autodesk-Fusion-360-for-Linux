#!/usr/bin/env bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This is the Italian translation for the Setup Wizard.                              #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2024                                                                          #
# Time/Date:    16:00/05.02.2024                                                                   #
# Version:      1.6.3                                                                              #
####################################################################################################

# Path: /$HOME/.fusion360/locale/it-IT/locale-it.sh

###############################################################################################################################################################
# ALL DEFINITIONS FOR AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                                  #
###############################################################################################################################################################

# Window Title (Setup Wizard)
SP_TITLE="Installazione guidata - Autodesk Fusion 360 per Linux"

# Window Title:
SP_SUBTITLE="Benvenuto nel programma di installazione di Autodesk Fusion 360 per Linux"

# Welcome Screen:
SP_WELCOME_LABEL_1="Questa procedura guidata di installazione installa Autodesk Fusion 360 sul tuo computer in modo che tu possa lavorare sui tuoi progetti anche su Linux."
SP_WELCOME_LABEL_2="Fai clic su OK per continuare o su Annulla per uscire dalla procedura guidata di configurazione."
SP_WELCOME_TOOLTIP_1="Qui ottieni maggiori informazioni su questa procedura guidata di configurazione."
SP_WELCOME_TOOLTIP_2="Qui puoi regolare l'impostazione predefinita. Ad esempio la lingua."

###############################################################################################################################################################

# General Settings:
SP_SETTINGS_TITLE="Impostazioni generali"
SP_SETTINGS_LABEL_1="Qui hai la possibilità di regolare* ulteriori impostazioni:"
SP_SETTINGS_LABEL_2="*Ricorda che qualsiasi modifica influirà sull'installazione di Autodesk Fusion 360!"
SP_LOCALE_LABEL="Lingue"
SP_LOCALE_SELECT=$(echo "Czech,English,German,Spanish,French,Italian,Japanese,Korean,Chinese")
WP_DRIVER_LABEL="Driver grafico"
WP_DRIVER_SELECT=$(echo "DXVK,OpenGL")

# License Checkbox:
SP_LICENSE_CHECK_LABEL="Ho letto i termini e le condizioni e li accetto."
SP_LICENSE="$SP_PATH/locale/it-IT/license-it.txt"

###############################################################################################################################################################

# Wineprefix Info - Autodesk Fusion 360 exist on the computer:
SP_LOGFILE_WINEPREFIX_INFO_TITLE="$SP_SUBTITLE"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_1="È stata rilevata un'installazione precedente di Autodesk Fusion 360 sul sistema!"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_2="Pertanto, seleziona una delle opzioni qui sotto per continuare!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_1="Crea un nuovo Wineprefix in una posizione diversa!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_2="Ripara un Wineprefix corrente sul tuo sistema!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_3="Rimuovi un Wineprefix corrente dal tuo sistema!"

###############################################################################################################################################################

# Linux distribution - Configuration:
SP_OS_TITLE="Distribuzione Linux - Configurazione"
SP_OS_LABEL_1="In questo passaggio puoi ora selezionare la tua distribuzione Linux per installare i pacchetti richiesti per l'installazione."
SP_OS_LABEL_2="Distribuzione Linux:"
SP_OS_SELECT=$(echo "Arch Linux,CachyOS,Debian 11,Debian 12, Debian Testing,EndeavourOS,Fedora 38,Fedora 39,Fedora Rawhide,Linux Mint 20.x,Linux Mint 21.x,Linux Mint 5.x - LMDE Version,Manjaro Linux,openSUSE Leap 15.4,openSUSE Leap 15.5,openSUSE Tumbleweed,Red Hat Enterprise Linux 8.x,Red Hat Enterprise Linux 9.x,Solus,Ubuntu 20.04,Ubuntu 22.04,Ubuntu 23.10,Void Linux,Gentoo Linux")

###############################################################################################################################################################

# Installation Folder - Configuration:
SP_INSTALLDIR_TITLE="Seleziona la destinazione dell'installazione"
SP_INSTALLDIR_LABEL_1="L'installazione guidata installerà Autodesk Fusion 360 nella directory seguente*."
SP_INSTALLDIR_LABEL_2="Directory:"
SP_INSTALLDIR_LABEL_3="*Puoi anche scegliere una directory diversa per l'installazione cliccando nel campo."

###############################################################################################################################################################

# Directory info:
SP_INSTALLDIR_INFO_TITLE="Seleziona directory di installazione - Informazioni"
SP_INSTALLDIR_INFO_LABEL_1="Pericolo! Questa directory esiste già!"
SP_INSTALLDIR_INFO_LABEL_2="Seleziona una directory diversa."

###############################################################################################################################################################

# Wine Version
SP_WINE_SETTINGS_TITLE="Seleziona versione vino"
SP_WINE_SETTINGS_LABEL_1="Qui devi decidere tra due opzioni*."
SP_WINE_SETTINGS_LABEL_2="Seleziona:"
SP_WINE_VERSION_SELECT=$(echo "Wine Version (Staging),Wine version (8.14 o successive) è già installata nel sistema!")
SP_WINE_SETTINGS_LABEL_3="*A seconda dell'opzione selezionata, ulteriori pacchetti verranno installati sul tuo sistema!"

###############################################################################################################################################################

SP_INSTALL_PROGRESS_LABEL="Autodesk Fusion 360 verrà installato sul tuo sistema ..."
SP_INSTALL_PROGRESS_REFRESH_LABEL="Autodesk Fusion 360 è in aggiornamento su questo sistema ..."

###############################################################################################################################################################

# Extension - Configuration:
SP_EXTENSION_SELECT="Seleziona"
SP_EXTENSION_NAME="Estensione"
SP_EXTENSION_DESCRIPTION="Descrizione"

SP_EXTENSION_LIST="$SP_PATH/locale/it-IT/extensions-it.txt"

SP_SEARCH_EXTENSION_CZECH_LOCALE_TITLE="Installa l'estensione Czech-Locale"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_1="Seleziona il file* in cui si trova l'estensione!"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_2="File:"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_3="*Per impostazione predefinita troverai le estensioni scaricate nella directory di download."

###############################################################################################################################################################
# ALL DEFINITIONS FOR UNINSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

DL_TITLE="Programma di disinstallazione - Autodesk Fusion 360 per Linux"
DL_SUBTITLE="Benvenuto nel programma di disinstallazione di Autodesk Fusion 360 per Linux"
DL_WELCOME_LABEL_1="Autodesk Fusion 360 verrà disinstallato dal tuo computer!"
DL_WELCOME_LABEL_2="Fai clic su OK per continuare o su Annulla per uscire da questo programma di disinstallazione."
DL_WELCOME_TOOLTIP_1="Qui ottieni maggiori informazioni su questo programma di disinstallazione."

DL_WINEPREFIXES_DEL_INFO_TEXT="Sei sicuro di voler eliminare il Wineprefix selezionato dal tuo computer?"
DL_WINEPREFIXES_DEL_INFO_LABEL="Sì, sono consapevole che tutti i miei dati personali andranno persi nel Wineprefix."

###############################################################################################################################################################

SP_COMPLETED_TEXT="Autodesk Fusion 360 è stato installato e configurato correttamente sul tuo computer."
SP_COMPLETED_CHECK_LABEL="Esegui Autodesk Fusion 360"

###############################################################################################################################################################
# ALL DEFINITIONS FOR THE LAUNCHER OF AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                  #
###############################################################################################################################################################

UP_TITLE="Autodesk Fusion 360 per Linux - Avvio applicazioni"
UP_NO_UPDATE_INFO_LABEL="Nessuna versione più recente trovata, quindi il tuo Autodesk fusion 360 è aggiornato!"
UP_SKIP_INFO_LABEL="L'aggiornamento è stato saltato! Ti invitiamo a controllare gli aggiornamenti la prossima volta."
UP_SKIP_UPDATE_QUESTION_LABEL="Sei sicuro di voler saltare la ricerca di un aggiornamento di Autodesk Fusion 360?"

UP_QUESTION_LABEL="Una nuova versione è stata rilasciata! Vuoi aggiornare ora?"

UP_NO_CONNECTION_WARNING_LABEL="Impossibile stabilire la connessione al server! Il controllo dei nuovi aggiornamenti è stato saltato! Controlla la tua connessione Internet!"

UP_WANT_TO_CHECK_FOR_UPDATES="Desideri verificare la disponibilità di aggiornamenti per Fusion 360 prima del lancio?"

UP_INSTALL_UPDATE_PROGRESS_LABEL="Autodesk Fusion 360 verrà aggiornato a una versione più recente ..."

###############################################################################################################################################################
###############################################################################################################################################################

SELECT="Seleziona"
WINEPREFIXES_TYPE="Tipo di prefisso vino"
WINEPREFIXES_DRIVER="Driver Wineprefixes"
WINEPREFIXES_DIRECTORY="Cartella Wineprefixes"
