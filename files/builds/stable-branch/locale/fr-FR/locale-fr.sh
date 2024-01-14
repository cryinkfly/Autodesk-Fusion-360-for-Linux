#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This is the French translation for the Setup Wizard.                               #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    19:00/26.07.2023                                                                   #
# Version:      1.6.2                                                                              #
####################################################################################################

# Path: /$HOME/.fusion360/locale/fr-FR/locale-fr.sh

###############################################################################################################################################################
# ALL DEFINITIONS FOR AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                                  #
###############################################################################################################################################################

# Window Title (Setup Wizard)
SP_TITLE="Assistant de configuration - Autodesk Fusion 360 pour Linux"

# Window Title:
SP_SUBTITLE="Bienvenue dans le programme d'installation d'Autodesk Fusion 360 pour Linux"

# Welcome Screen:
SP_WELCOME_LABEL_1="Cet assistant de configuration installe Autodesk Fusion 360 sur votre ordinateur afin que vous puissiez également travailler sur vos projets sous Linux."
SP_WELCOME_LABEL_2="Cliquez sur OK pour continuer ou sur Annuler pour quitter l'assistant de configuration."
SP_WELCOME_TOOLTIP_1="Ici, vous obtenez plus d'informations sur cet assistant de configuration."
SP_WELCOME_TOOLTIP_2="Ici, vous pouvez régler le paramètre par défaut. Par exemple, la langue."

###############################################################################################################################################################

# General Settings:
SP_SETTINGS_TITLE="Paramètres généraux"
SP_SETTINGS_LABEL_1="Ici, vous avez la possibilité d'ajuster* d'autres paramètres :"
SP_SETTINGS_LABEL_2="*N'oubliez pas que toute modification affectera l'installation d'Autodesk Fusion 360 !"
SP_LOCALE_LABEL="Langues"
SP_LOCALE_SELECT=$(echo "Czech,English,German,Spanish,French,Italian,Japanese,Korean,Chinese")
WP_DRIVER_LABEL="Pilote graphique"
WP_DRIVER_SELECT=$(echo "DXVK,OpenGL")

# License Checkbox:
SP_LICENSE_CHECK_LABEL="J'ai lu les termes et conditions et je les accepte."
SP_LICENSE="$SP_PATH/locale/fr-FR/license-fr.txt"

###############################################################################################################################################################

# Wineprefix Info - Autodesk Fusion 360 exist on the computer:
SP_LOGFILE_WINEPREFIX_INFO_TITLE="$SP_SUBTITLE"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_1="Une installation précédente d'Autodesk Fusion 360 a été détectée sur votre système !"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_2="Par conséquent, veuillez sélectionner l'une des options ci-dessous pour continuer !"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_1="Créer un nouveau préfixe Wine à un emplacement différent !"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_2="Réparer un préfixe Wine actuel sur votre système !"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_3="Supprimer un préfixe Wine actuel de votre système !"

###############################################################################################################################################################

# Linux distribution - Configuration:
SP_OS_TITLE="Distribution Linux - Configuration"
SP_OS_LABEL_1="Dans cette étape, vous pouvez maintenant sélectionner votre distribution Linux pour installer les packages requis pour l'installation."
SP_OS_LABEL_2="Répartition Linux :"
SP_OS_SELECT=$(echo "Arch Linux,Debian 11,Debian 12, Debian Testing,EndeavourOS,Fedora 37,Fedora 38,Fedora Rawhide,Linux Mint 20.x,Linux Mint 21.x,Linux Mint 5.x - LMDE Version,Manjaro Linux,openSUSE Leap 15.4,openSUSE Leap 15.5,openSUSE Tumbleweed,Red Hat Enterprise Linux 8.x,Red Hat Enterprise Linux 9.x,Solus,Ubuntu 20.04,Ubuntu 22.04,Ubuntu 23.04,Void Linux,Gentoo Linux")

###############################################################################################################################################################

# Installation Folder - Configuration:
SP_INSTALLDIR_TITLE="Sélectionnez la destination de l'installation"
SP_INSTALLDIR_LABEL_1="L'assistant d'installation installera Autodesk Fusion 360 dans le répertoire suivant*."
SP_INSTALLDIR_LABEL_2="Répertoire :"
SP_INSTALLDIR_LABEL_3="*Vous pouvez également choisir un répertoire différent pour l'installation en cliquant dans le champ."

###############################################################################################################################################################

# Directory info:
SP_INSTALLDIR_INFO_TITLE="Sélectionner le répertoire d'installation - Infos"
SP_INSTALLDIR_INFO_LABEL_1="Danger ! Ce répertoire existe déjà !"
SP_INSTALLDIR_INFO_LABEL_2="Veuillez sélectionner un autre répertoire."

###############################################################################################################################################################

# Wine Version
SP_WINE_SETTINGS_TITLE="Sélectionner la version du vin"
SP_WINE_SETTINGS_LABEL_1="Ici, vous devez choisir entre deux options*."
SP_WINE_SETTINGS_LABEL_2="Sélectionnez :"
SP_WINE_VERSION_SELECT=$(echo "La version de Wine (Staging), la version de Wine (6.23 ou supérieure) est déjà installée sur le système !")
SP_WINE_SETTINGS_LABEL_3="*Selon l'option sélectionnée, d'autres packages seront installés sur votre système !"

###############################################################################################################################################################

SP_INSTALL_PROGRESS_LABEL="Autodesk Fusion 360 sera installé sur votre système ..."
SP_INSTALL_PROGRESS_REFRESH_LABEL="Autodesk Fusion 360 est en cours de mise à jour sur ce système ..."

###############################################################################################################################################################

# Extension - Configuration:
SP_EXTENSION_SELECT="Sélectionner"
SP_EXTENSION_NAME="Extension"
SP_EXTENSION_DESCRIPTION="Description"

SP_EXTENSION_LIST="$SP_PATH/locale/fr-FR/extensions-fr.txt"

SP_SEARCH_EXTENSION_CZECH_LOCALE_TITLE="Installer l'extension locale tchèque"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_1="Sélectionnez le fichier* dans lequel se trouve l'extension !"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_2="Fichier :"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_3="*Par défaut, vous trouverez vos extensions téléchargées dans le répertoire de téléchargement."

###############################################################################################################################################################
# ALL DEFINITIONS FOR UNINSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

DL_TITLE="Programme de désinstallation - Autodesk Fusion 360 pour Linux"
DL_SUBTITLE="Bienvenue dans le programme de désinstallation d'Autodesk Fusion 360 pour Linux"
DL_WELCOME_LABEL_1="Autodesk Fusion 360 va être désinstallé de votre ordinateur !"
DL_WELCOME_LABEL_2="Cliquez sur OK pour continuer ou sur Annuler pour quitter ce programme de désinstallation."
DL_WELCOME_TOOLTIP_1="Ici, vous obtenez plus d'informations sur ce programme de désinstallation."

DL_WINEPREFIXES_DEL_INFO_TEXT="Êtes-vous sûr de vouloir supprimer le préfixe Wine sélectionné de votre ordinateur ?"
DL_WINEPREFIXES_DEL_INFO_LABEL="Oui, je suis conscient que toutes mes données personnelles seront perdues dans le Wineprefix."

###############################################################################################################################################################

SP_COMPLETED_TEXT="Autodesk Fusion 360 a été correctement installé et configuré sur votre ordinateur."
SP_COMPLETED_CHECK_LABEL="Exécuter Autodesk Fusion 360"

###############################################################################################################################################################
# ALL DEFINITIONS FOR THE LAUNCHER OF AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                  #
###############################################################################################################################################################

UP_TITLE="Autodesk Fusion 360 pour Linux - Lanceur"
UP_NO_UPDATE_INFO_LABEL="Aucune version plus récente n'a été trouvée, donc votre Autodesk fusion 360 est à jour !"
UP_SKIP_INFO_LABEL="La mise à jour a été ignorée ! Veuillez envisager de vérifier les mises à jour la prochaine fois."
UP_SKIP_UPDATE_QUESTION_LABEL="Êtes-vous sûr de vouloir ignorer la recherche d'une mise à jour d'Autodesk Fusion 360 ?"

UP_QUESTION_LABEL="Une nouvelle version est sortie ! Voulez-vous mettre à jour maintenant ?"

UP_NO_CONNECTION_WARNING_LABEL="La connexion au serveur n'a pas pu être établie ! La recherche de nouvelles mises à jour a été ignorée ! Veuillez vérifier votre connexion Internet !"

UP_WANT_TO_CHECK_FOR_UPDATES="Souhaitez-vous vérifier les mises à jour de Fusion 360 avant de le lancer ?"

UP_INSTALL_UPDATE_PROGRESS_LABEL="Autodesk Fusion 360 sera mis à jour vers une version plus récente ..."

###############################################################################################################################################################
###############################################################################################################################################################

SELECT="Sélectionner"
WINEPREFIXES_TYPE="Type de préfixes de vin"
WINEPREFIXES_DRIVER="Pilote de préfixes Wine"
WINEPREFIXES_DIRECTORY="Répertoire des préfixes des vins"
