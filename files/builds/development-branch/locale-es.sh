#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This is the Spanish translation for the Setup Wizard.                              #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    21:10/07.06.2022                                                                   #
# Version:      1.5 -> 1.6                                                                         #
####################################################################################################

# Path: /$HOME/.fusion360/locale/es-ES/locale-es.sh

###############################################################################################################################################################
# ALL DEFINITIONS FOR AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                                  #
###############################################################################################################################################################

# Window Title (Setup Wizard)
SP_TITLE="Asistente de configuración - Autodesk Fusion 360 para Linux"

# Window Title:
SP_SUBTITLE="Bienvenido al instalador de Autodesk Fusion 360 para Linux"

# Welcome Screen:
SP_WELCOME_LABEL_1="Este asistente de configuración instala Autodesk Fusion 360 en su computadora para que también pueda trabajar en sus proyectos en Linux."
SP_WELCOME_LABEL_2="Haga clic en Aceptar para continuar o en Cancelar para salir del asistente de configuración."
SP_WELCOME_TOOLTIP_1="Aquí obtendrá más información sobre este asistente de configuración."
SP_WELCOME_TOOLTIP_2="Aquí puede ajustar la configuración predeterminada. Por ejemplo el idioma."

###############################################################################################################################################################

# General Settings:
SP_SETTINGS_TITLE="Configuración general"
SP_SETTINGS_LABEL_1="Aquí tiene la opción de ajustar* más configuraciones:"
SP_SETTINGS_LABEL_2="* ¡Recuerde que cualquier cambio afectará la instalación de Autodesk Fusion 360!"
SP_LOCALE_LABEL="Idiomas"
SP_LOCALE_SELECT=$(echo "Czech,English,German,Spanish,French,Italian,Japanese,Korean,Chinese")
WP_DRIVER_LABEL="Controladora de gráficos"
WP_DRIVER_SELECT=$(echo "DXVK,OpenGL")

# License Checkbox:
SP_LICENSE_CHECK_LABEL="He leído los términos y condiciones y los acepto."
SP_LICENSE="$SP_PATH/locale/es-ES/license-es.txt"

###############################################################################################################################################################

# Wineprefix Info - Autodesk Fusion 360 exist on the computer:
SP_LOGFILE_WINEPREFIX_INFO_TITLE="$SP_SUBTITLE"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_1="¡Se ha detectado una instalación anterior de Autodesk Fusion 360 en su sistema!"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_2="Por lo tanto, seleccione una de las siguientes opciones para continuar."
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_1="¡Cree un nuevo Wineprefix en una ubicación diferente!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_2="¡Repare un Wineprefix actual en su sistema!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_3="¡Elimine un Wineprefix actual de su sistema!"

###############################################################################################################################################################

# Linux distribution - Configuration:
SP_OS_TITLE="Distribución Linux - Configuración"
SP_OS_LABEL_1="En este paso ahora puede seleccionar su distribución de Linux para instalar los paquetes necesarios para la instalación."
SP_OS_LABEL_2="Distribución de Linux:"
SP_OS_SELECT=$(echo "Arch Linux,Debian 10,Debian 11,EndeavourOS,Fedora 35,Fedora 36,Linux Mint 19.x,Linux Mint 20.x,Manjaro Linux,openSUSE Leap 15.3,openSUSE Leap 15.4,openSUSE Tumbleweed,Red Hat Enterprise Linux 8.x,Red Hat Enterprise Linux 9.x,Solus,Ubuntu 18.04,Ubuntu 20.04,Ubuntu 22.04,Void Linux,Gentoo Linux")

###############################################################################################################################################################

# Installation Folder - Configuration:
SP_INSTALLDIR_TITLE="Seleccione el destino de la instalación"
SP_INSTALLDIR_LABEL_1="El asistente de instalación instalará Autodesk Fusion 360 en el siguiente directorio*".
SP_INSTALLDIR_LABEL_2="Directorio:"
SP_INSTALLDIR_LABEL_3="*También puede elegir un directorio diferente para la instalación haciendo clic en el campo."

###############################################################################################################################################################

# Información del directorio:
SP_INSTALLDIR_INFO_TITLE="Seleccionar directorio de instalación - Información"
SP_INSTALLDIR_INFO_LABEL_1="¡Peligro! ¡Este directorio ya existe!"
SP_INSTALLDIR_INFO_LABEL_2="Seleccione un directorio diferente".

###############################################################################################################################################################
# Versión de vino
SP_WINE_SETTINGS_TITLE="Seleccionar versión de vino"
SP_WINE_SETTINGS_LABEL_1="Aquí tienes que decidir entre dos opciones*."
SP_WINE_SETTINGS_LABEL_2="Seleccionar:"
SP_WINE_VERSION_SELECT=$(echo "La versión de Wine (puesta en escena), la versión de Wine (6.23 o superior) ya está instalada en el sistema!")
SP_WINE_SETTINGS_LABEL_3="*Dependiendo de la opción seleccionada, ¡se instalarán más paquetes en su sistema!"

###############################################################################################################################################################

SP_INSTALL_PROGRESS_LABEL="Autodesk Fusion 360 se instalará en su sistema..."
SP_INSTALL_PROGRESS_REFRESH_LABEL="Autodesk Fusion 360 se está actualizando en este sistema..."

###############################################################################################################################################################
# Extensión - Configuración:
SP_EXTENSION_SELECT="Seleccionar"
SP_EXTENSION_NAME="Extensión"
SP_EXTENSION_DESCRIPTION="Descripción"

SP_EXTENSION_LIST="$SP_PATH/locale/en-US/extensions-en.txt"

SP_SEARCH_EXTENSION_CZECH_LOCALE_TITLE="Instalar la extensión local checa"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_1="¡Seleccione el archivo* en el que se encuentra la extensión!"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_2="Archivo:"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_3="*De forma predeterminada, encontrará las extensiones descargadas en el directorio de descargas".

###############################################################################################################################################################
# ALL DEFINITIONS FOR UNINSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

DL_TITLE="Desinstalador: Autodesk Fusion 360 para Linux"
DL_SUBTITLE="Bienvenido al programa de desinstalación de Autodesk Fusion 360 para Linux"
DL_WELCOME_LABEL_1="¡Autodesk Fusion 360 se desinstalará de su computadora!"
DL_WELCOME_LABEL_2="Haga clic en Aceptar para continuar o en Cancelar para salir de este programa de desinstalación".
DL_WELCOME_TOOLTIP_1="Aquí obtendrá más información sobre este Desinstalador."

DL_WINEPREFIXES_DEL_INFO_TEXT="¿Está seguro de que desea eliminar el Wineprefix seleccionado de su computadora?"
DL_WINEPREFIXES_DEL_INFO_LABEL="Sí, soy consciente de que todos mis datos personales se perderán en Wineprefix."

###############################################################################################################################################################
SP_COMPLETED_TEXT="Autodesk Fusion 360 se instaló y configuró correctamente en su computadora".
SP_COMPLETED_CHECK_LABEL="Ejecutar Autodesk Fusion 360"

###############################################################################################################################################################
# ALL DEFINITIONS FOR THE LAUNCHER OF AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                  #
###############################################################################################################################################################

LAUNCHER_NO_UPDATE_INFO="¡No se encontró una versión más nueva, por lo que su Autodesk fusion 360 está actualizado!"

LAUNCHER_SKIP_UPDATE_INFO="¡Se omitió la actualización! ¡Actualice su versión de Autodesk Fusion 360 pronto!"
LAUNCHER_SKIP_UPDATE_QUESTION="¿Está seguro de que desea omitir la búsqueda de una actualización de Autodesk Fusion 360?"

LAUNCHER_UPDATE_QUESTION="¡Se ha lanzado una nueva versión! ¿Quiere actualizar ahora?"

LAUNCHER_UPDATE_WARNING="¡No se pudo establecer la conexión con el servidor! ¡Se ha omitido la búsqueda de nuevas actualizaciones! ¡Por favor, compruebe su conexión a Internet!"

###############################################################################################################################################################
###############################################################################################################################################################

SELECCIONAR="Seleccionar"
WINEPREFIXES_TYPE="Tipo de prefijos de vino"
WINEPREFIXES_DRIVER="Controlador de Wineprefixes"
