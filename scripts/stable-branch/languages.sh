#!/bin/bash

########################################################################################
# Name:         Autodesk Fusion 360 - Language file of the Installationsskript (Linux) #
# Description:  The different languages are loaded with this file!                     #
# Author:       Steve Zabka                                                            #
# Author URI:   https://cryinkfly.com                                                  #
# License:      MIT                                                                    #
# Copyright (c) 2020-2021                                                              #
# Time/Date:    09:00/08.10.2021                                                       #
# Version:      2.0                                                                    #
########################################################################################

##############################################################################
# DESCRIPTION
##############################################################################

# With the help of my script, you will be given a way to install Autodesk Fusion 360 in different languages. 

##############################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:
##############################################################################

    function select-language {
        echo "In this step you need to choose a language for the Autodesk Fusion 360 installation!"
        echo -n "Choose one of these options: (English(en), German(de) or Quit(q)"
        read answer

        if [ "$answer" != "${answer#[en]}" ] ;then
          clear &&
          language-en_US
        elif [ "$answer" != "${answer#[de]}" ] ;then
          clear &&
          language-de_DE
        elif [ "$answer" != "${answer#[q]}" ] ;then
          exit;
        else
          exit;
        fi
        }

##############################################################################

# The English language packs are loaded.

    function language-en_US {
    export LC_ALL=en_US.UTF-8
    export LANG=en_US.UTF-8
    export LANGUAGE=en_US.UTF-8

    text_1="In this step the following packages package >dialog< and >wmctrl< are installed for the installation of Autodesk Fusion 360!"
    text_1_1="Do you wish to install these packages (y/n)?"

    #welcome-screen-1
    text_2="Installation of Autodesk Fusion360 - Version $version_number"
    text_2_1="Do you wish to install Autodesk Fusion 360?"
    text_2_2="Choose one of the following options:"
    text_2_3="Yes"
    text_2_4="No"

    #welcome-screen-2
    text_3="$text_2"
    text_3_1="This Setup has checked your system for a existing Autodesk Fusion 360 components and it was found that Autodesk Fusion 360 already exists on your system!"
    text_3_2="$text_2_2"
    text_3_3="New installation of some or all components"
    text_3_4="Update or Repair a existing installation"
    text_3_5="Uninstall all Autodesk Fusion 360 components"

    #select-dxvk-or-opengl
    text_4="$text_2"
    text_4_1="Select preferred driver!"
    text_4_2="$text_2_2"
    text_4_3="OpenGL (default) - Select this option if you are not sure!"
    text_4_4="DXVK - Select this option if you are using an Intel GPU!"

    #select-your-os
    text_5="$text_2"
    text_5_1="Select your Linux distribution!"
    text_5_2="$text_2_2"

    #archlinux-1
    text_6="$text_2"
    text_6_1="If you have enabled multilib repository?"
    text_6_2="$text_2_2"
    text_6_3="$text_2_3"
    text_6_4="$text_2_4"

    #select-your-path
    text_7="$text_2"
    text_7_1="Choose setup type!"
    text_7_2="Choose the kind of setup that best suits your needs."
    text_7_3="Standard - Install Autodesk Fusion 360 into your home folder. (/home/YOUR-USERNAME/.wineprefixes/fusion360)"
    text_7_4="Custom - Install Autodesk Fusion 360 to another place."

    #select-your-path-custom
    text_8="$text_2"
    text_8_1="Description - Configure the installation location!"
    text_8_2="Now you have to determine where you want to install Autodesk Fusion 360 and then the .fusion360 folder will be created for you automatically. For example you can install it on a external usb-drive: /run/media/user/usb-drive/wine/.fusion360 or you install it into your home folder: /home/YOUR-USERNAME/.wineprefixes/fusion360)."
    text_8_3="Enter the installation path for Autodesk Fusion 360:"
    text_8_4="$text_2"

    #change-fusion360-1
    text_9="Make a note of the path to your Autodesk Fusion 360 installation so that you can use it in the next step!"
    text_9_1="$text_2"

    #change-fusion360-2
    text_9_2="Enter the installation path for Autodesk Fusion 360:"
    text_9_3="$text_2"

    #program-exit-uninstall
    text_10="$text_2"
    text_10_1="Uninstalling Autodesk Fusion 360!"
    text_10_2="Autodesk Fusion 360 uninstallation is complete!"

    #program-exit
    text_11="$text_2"
    text_11_1="Autodesk Fusion 360 is completed."
    text_11_2="The Autodesk Fusion 360 installation is complete and you can now use it for your projects."

    #extension-manager
    text_12="$text_2"
    text_12_1="Extension Manager"
    text_12_2="Here you can install some extensions for Autodesk Fusion 360!"

    text_12_3="Airfoil Tools helps you by the optimization any thing or part that is exposed to a moving gas or liquid. For examble: wings, fins, propellers and turbines."
    text_12_4="Additive Assistant (FFF) helps you by analyses a number of aspects of your designs and provides clear feedback on how to improve the manufacturability of the part."
    text_12_5="HP 3D Printers for Autodesk® Fusion 360™ is a connector between Autodesk® Fusion 360™ and the HP SmartStream Software and is used to send over jobs directly to the HP Software."
    text_12_6="With OctoPrint for Autodesk® Fusion 360™ you can send the G-code of your created 3D models directly to the OctoPrint server via Autodesk Fusion 360."
    text_12_7="RoboDK allows you to program more than 50 different robot manufacturers and 500 robots directly from Fusion 360."
}

##############################################################################

# The German language packs are loaded.

    function language-de_DE {
    export LC_ALL=de_DE.UTF-8
    export LANG=de_DE.UTF-8
    export LANGUAGE=de_DE.UTF-8

    text_1="In diesem Schritt werden die folgenden Pakete >dialog< und >wmctrl< für die Installation von Autodesk Fusion 360 installiert!"
    text_1_1="Möchten Sie diese Pakete installieren (j/n)?"

    #welcome-screen-1
    text_2="Installation von Autodesk Fusion360 - Version $version_number"
    text_2_1="Möchten Sie Autodesk Fusion 360 installieren?"
    text_2_2="Wählen Sie eine der folgenden Optionen aus:"
    text_2_3="Ja"
    text_2_4="Nein"

    #welcome-screen-2
    text_3="$text_2"
    text_3_1="Dieses Setup hat Ihr System auf vorhandene Autodesk Fusion 360-Komponenten überprüft und es wurde festgestellt, dass Autodesk Fusion 360 bereits auf Ihrem System vorhanden ist!"
    text_3_2="$text_2_2"
    text_3_3="Neuinstallation einiger oder aller Komponenten"
    text_3_4="Aktualisieren oder Reparieren Sie eine vorhandene Installation"
    text_3_5="Deinstallieren Sie alle Autodesk Fusion 360-Komponenten"

    #select-dxvk-or-opengl
    text_4="$text_2"
    text_4_1="Bevorzugten Grafiktreiber auswählen!"
    text_4_2="$text_2_2"
    text_4_3="OpenGL (Standard) - Wählen Sie diese Option aus, wenn Sie sich nicht sicher sind!"
    text_4_4="DXVK - Wählen Sie diese Option aus, wenn Sie eine Intel GPU verwenden!"

    #select-your-os
    text_5="$text_2"
    text_5_1="Wählen Sie Ihre Linux-Distribution aus!"
    text_5_2="$text_2_2"

    #archlinux-1
    text_6="$text_2"
    text_6_1="Haben Sie das Multilib-Repository aktiviert?"
    text_6_2="$text_2_2"
    text_6_3="$text_2_3"
    text_6_4="$text_2_4"

    #select-your-path
    text_7="$text_2"
    text_7_1="Wählen Sie den Setup-Typ aus!"
    text_7_2="Wählen Sie die Art der Einrichtung, die Ihren Anforderungen am besten entspricht."
    text_7_3="Standard – Installieren Sie Autodesk Fusion 360 in Ihrem Benutzerordner. (/home/IHR-BENUTZERNAME/.wineprefixes/fusion360)"
    text_7_4="Benutzerdefiniert – Installieren Sie Autodesk Fusion 360 an einem anderen Ort."

    #select-your-path-custom
    text_8="$text_2"
    text_8_1="Beschreibung - Konfigurieren Sie den Installationsort!"
    text_8_2="Jetzt müssen Sie festlegen, wohin Sie Autodesk Fusion 360 installieren möchten, und dann wird der Ordner .fusion360 automatisch für Sie erstellt. Sie können es beispielsweise auf einem externen USB-Laufwerk installieren: /run/media/user/usb-drive/wine/.fusion360 oder Sie installieren es in Ihrem Home-Ordner: /home/IHR-BENUTZERNAME/.wineprefixes/fusion360)."
    text_8_3="Geben Sie den Installationspfad für Autodesk Fusion 360 ein:"
    text_8_4="$text_2"

    #change-fusion360-1
    text_9="Notieren Sie sich den Pfad zu Ihrer Autodesk Fusion 360-Installation, damit Sie ihn im nächsten Schritt verwenden können!"
    text_9_1="$text_2"

    #change-fusion360-2
    text_9_2="Geben Sie den Installationspfad für Autodesk Fusion 360 ein:"
    text_9_3="$text_2"

    #program-exit-uninstall
    text_10="$text_2"
    text_10_1="Deinstallieren von Autodesk Fusion 360!"
    text_10_2="Die Deinstallation von Autodesk Fusion 360 ist abgeschlossen!"

    #program-exit
    text_11="$text_2"
    text_11_1="Autodesk Fusion 360 ist abgeschlossen."
    text_11_2="Die Installation von Autodesk Fusion 360 ist abgeschlossen und Sie können es nun für Ihre Projekte verwenden."

    #extension-manager
    text_12="$text_2"
    text_12_1="Extension Manager"
    text_12_2="Hier können Sie einige Erweiterungen für Autodesk Fusion 360 installieren!"

    text_12_3="Airfoil Tools hilft Ihnen bei der Optimierung aller Dinge oder Teile, die einem bewegten Gas oder einer Flüssigkeit ausgesetzt sind. Zum Beispiel: Flügel, Flossen, Propeller und Turbinen."
    text_12_4="Der Additive Assistant (FFF) hilft Ihnen, indem er eine Reihe von Aspekten Ihrer Konstruktionen analysiert und klare Rückmeldungen gibt, wie die Herstellbarkeit des Teils verbessert werden kann."
    text_12_5="HP 3D-Drucker für Autodesk® Fusion 360™ ist eine Verbindung zwischen Autodesk® Fusion 360™ und der HP SmartStream Software und wird verwendet, um Aufträge direkt an die HP Software zu senden."
    text_12_6="Mit OctoPrint für Autodesk® Fusion 360™ können Sie den G-Code Ihrer erstellten 3D-Modelle über Autodesk Fusion 360 direkt an den OctoPrint-Server senden."
    text_12_7="Mit RoboDK können Sie mehr als 50 verschiedene Roboterhersteller und 500 Roboter direkt aus Autodesk Fusion 360 heraus programmieren."
}

##############################################################################
# THE INSTALLATION PROGRAM IS STARTED HERE:
##############################################################################

version_number="5.3"
select-language

############################################################################################################################################################

