#!/bin/bash

# Name:         Autodesk Fusion 360 - Installationsskript - Flatpak (Linux)
# Description:  With this file you can install Autodesk Fusion 360 on Linux.
# Author:       Steve Zabka
# Author URI:   https://cryinkfly.de
# Time/Date:    20:00/21.05.2021
# Version:      0.4

# 1. Step: Install Flatpak on your system: https://flatpak.org/setup/ (More information about FLatpak: https://youtu.be/SavmR9ZtHg0)
# 2. Step: Open a Terminal and run this command: cd Downloads && chmod +x fusion360-flatpak-install.sh && bash fusion360-flatpak-install.sh
# 3. Step: The installation will now start and set up everything for you automatically.
# 4. Step: Now you can use my other file "fusion360-flatpak-start.sh" for running Autodesk Fusion 360 on your system.

# Optional: You can also install Autodesk Fusion 360 with DXVK, when you use the file: fusion360-flatpak-dxvk-install.sh

####################################################################
# The next two steps are also very important for you, because on some Linux Distrubition you dosn't get to work Flatpak without these steps!!!
####################################################################

# 1. Step: Open a Terminal and run this command sudo nano /etc/hosts (Change this file wihtout # !)

#     127.0.0.1     localhost
#     127.0.1.1     EXAMPLE-NAME
     
#     ::1 ip6-localhost ip6-loopback
#     fe00::0 ip6-localnet
#     ff00::0 ip6-mcastprefix
#     ff02::1 ip6-allnodes
#     ff02::2 ip6-allrouters
#     ff02::3 ip6-allhosts

# 2. Step: Run this command: sudo nano /etc/hostname (Change this file wihtout # !)

#    EXAMPLE-NAME

# 3. Step: Reboot your system!

####################################################################

# Add the Flathub repository for your current user!!!
echo "Add the Flathub repository"
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo &&
flatpak -y --user install flathub                              \
        org.freedesktop.Platform/x86_64/20.08                  \
        org.freedesktop.Platform.Compat.i386/x86_64/20.08      \
        org.freedesktop.Platform.GL32.default/x86_64/20.08     \
        org.freedesktop.Platform.GL.default/x86_64/20.08       \
        org.freedesktop.Platform.VAAPI.Intel.i386/x86_64/20.08 \
        org.freedesktop.Platform.VAAPI.Intel/x86_64/20.08      \
        org.freedesktop.Platform.ffmpeg_full.i386/x86_64/20.08 \
        org.freedesktop.Platform.ffmpeg-full/x86_64/20.08

#Install some packages for Nvidia users
if [ -f /proc/driver/nvidia/version ]; then
echo "Install some packages for your Nvidia graphics card!"
    ver=$(nvidia-settings -q all |grep OpenGLVersion|grep NVIDIA|sed 's/.*NVIDIA \(.*\) /nvidia-\1/g'|sed 's/\./-/g')
    flatpak -y --user install flathub                 \
        org.freedesktop.Platform.GL.$ver   \
        org.freedesktop.Platform.GL32.$ver
fi
echo "Installation of some packages for your graphics card is completed!"

#Install a special Wine-Version (org.winehq.flatpak-proton-68-ge-1)
echo "Install a special Wine-Version!"
wget https://github.com/fastrizwaan/flatpak-wine-releases/releases/download/6.8-20210510/org.winehq.flatpak-proton-68-ge-1-6.8-20210510.flatpak &&
flatpak -y --user install flathub org.winehq.flatpak-proton-68-ge-1 &&

echo "Winetricks isntall some packages for you!"
flatpak run org.winehq.flatpak-proton-68-ge-1 winetricks -q corefonts vcrun2017 msxml4 fontsmooth=rgb win10 &&

 echo "Autodesk Fusion 360 will be installed and set up."
flatpak run org.winehq.flatpak-proton-68-ge-1 bash &&
cd $HOME &&
cd Downloads &&
mkdir fusion360 &&
cd fusion360 &&
wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe &&

wine Fusion\ 360\ Admin\ Install.exe -p deploy -g -f log.txt --quiet &&
wine Fusion\ 360\ Admin\ Install.exe -p deploy -g -f log.txt --quiet &&

mkdir -p "$HOME/.local/share/flatpak-proton-68-ge-1/default/drive_c/users/steamuser/Application Data/Autodesk/Neutron Platform/" &&

cat > "$HOME/.local/share/flatpak-proton-68-ge-1/default/drive_c/users/steamuser/Application Data/Autodesk/Neutron Platform/Options/NMachineSpecificOptions.xml" << "E"
<?xml version="1.0" encoding="UTF-16" standalone="no" ?>
<OptionGroups>
<BootstrapOptionsGroup SchemaVersion="2" ToolTip="Special preferences that require the application to be restarted after a change." UserName="Bootstrap">
 <driverOptionId ToolTip="The driver used to display the graphics" UserName="Graphics driver" Value="VirtualDeviceGLCore"/></BootstrapOptionsGroup>
</OptionGroups>
E

echo "The installation of Autodesk Fusion 360 is completed."
exit
