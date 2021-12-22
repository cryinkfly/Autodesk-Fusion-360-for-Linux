#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard - Flatpak (Linux)                               #
# Description:  With this file you can install Autodesk Fusion 360 on Linux.                       #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2021                                                                          #
# Time/Date:    17:00/27.11.2021                                                                   #
# Version:      2.1                                                                                #
####################################################################################################

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
# 1. Step: Install Flatpak on your system: https://flatpak.org/setup/ (More information about FLatpak: https://youtu.be/SavmR9ZtHg0)                          #
###############################################################################################################################################################
#                                                                                                                                                             #
# The next two steps are also very important for you, because on some Linux Distrubition you dosn't get to work Flatpak without these steps!!!                #
###############################################################################################################################################################
#                                                                                                                                                             #
# 1. Step: Open a Terminal and run this command sudo nano /etc/hosts (Change this file wihtout # !)                                                           #
#                                                                                                                                                             #
#     127.0.0.1     localhost                                                                                                                                 #
#     127.0.1.1     EXAMPLE-NAME                                                                                                                              #
#                                                                                                                                                             #
#     ::1 ip6-localhost ip6-loopback                                                                                                                          #
#     fe00::0 ip6-localnet                                                                                                                                    #
#     ff00::0 ip6-mcastprefix                                                                                                                                 #
#     ff02::1 ip6-allnodes                                                                                                                                    #
#     ff02::2 ip6-allrouters                                                                                                                                  #
#     ff02::3 ip6-allhosts                                                                                                                                    #
#                                                                                                                                                             #
# 2. Step: Run this command: sudo nano /etc/hostname (Change this file wihtout # !)                                                                           #
#                                                                                                                                                             #
#    EXAMPLE-NAME                                                                                                                                             #
#                                                                                                                                                             #
# 3. Step: Reboot your system!                                                                                                                                #
#                                                                                                                                                             #
###############################################################################################################################################################

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

function flathub {
    # Add the Flathub repository for your current user!!!
    flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak -y --user install flathub                              \
            org.freedesktop.Platform/x86_64/20.08                  \
            org.freedesktop.Platform.Compat.i386/x86_64/20.08      \
            org.freedesktop.Platform.GL32.default/x86_64/20.08     \
            org.freedesktop.Platform.GL.default/x86_64/20.08       \
            org.freedesktop.Platform.VAAPI.Intel.i386/x86_64/20.08 \
            org.freedesktop.Platform.VAAPI.Intel/x86_64/20.08      \
            org.freedesktop.Platform.ffmpeg_full.i386/x86_64/20.08 \
            org.freedesktop.Platform.ffmpeg-full/x86_64/20.08

    # Install some packages for Nvidia users
    if [ -f /proc/driver/nvidia/version ]; then
        ver=$(nvidia-settings -q all |grep OpenGLVersion|grep NVIDIA|sed 's/.*NVIDIA \(.*\) /nvidia-\1/g'|sed 's/\./-/g')
        flatpak -y --user install flathub                 \
            org.freedesktop.Platform.GL.$ver   \
            org.freedesktop.Platform.GL32.$ver
    fi

# Install a special Wine-Version (org.winehq.flatpak-proton-68-ge-1)
wget -c https://github.com/fastrizwaan/flatpak-wine-releases/releases/download/6.19-20211009/org.winehq.flatpak-wine619-6.19-20211010.flatpak
flatpak -y --user install org.winehq.flatpak-wine619-6.19-20211010.flatpak
}

function fusion360-flatpak {

    flatpak run org.winehq.flatpak-wine619 winetricks -q corefonts msxml4 msxml6 vcrun2019 fontsmooth=rgb win8
    flatpak run org.winehq.flatpak-wine619 bash
    mkdir -p "$HOME/.wineprefixes/fusion360/INSTALLDIR/data/fusion360"
    cd "$HOME/.wineprefixes/fusion360/INSTALLDIR/data/fusion360"
    wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe -O Fusion360installer.exe
    wine Fusion360installer.exe -p deploy -g -f log.txt --quiet
    wine Fusion360installer.exe -p deploy -g -f log.txt --quiet
    mkdir -p "$HOME/.local/share/flatpak-wine619/default/drive_c/users/steamuser/Application Data/Autodesk/Neutron Platform/"

cat > "$HOME/.local/share/flatpak-wine619/default/drive_c/users/steamuser/Application Data/Autodesk/Neutron Platform/Options/NMachineSpecificOptions.xml" << "E"
<?xml version="1.0" encoding="UTF-16" standalone="no" ?>
<OptionGroups>
<BootstrapOptionsGroup SchemaVersion="2" ToolTip="Special preferences that require the application to be restarted after a change." UserName="Bootstrap">
 <driverOptionId ToolTip="The driver used to display the graphics" UserName="Graphics driver" Value="VirtualDeviceGLCore"/></BootstrapOptionsGroup>
</OptionGroups>
E

echo "The installation of Autodesk Fusion 360 is completed."
exit

}

flathub
fusion360-flatpak
