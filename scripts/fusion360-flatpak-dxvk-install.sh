#!/bin/bash

# Name:         Autodesk Fusion 360 - Installationsskript with DXVK - Flatpak (Linux)
# Description:  With this file you can install Autodesk Fusion 360 on Linux.
# Author:       Steve Zabka
# Author URI:   https://cryinkfly.de
# Time/Date:    20:00/21.05.2021
# Version:      0.3

# 1. Step: Install Flatpak on your system: https://flatpak.org/setup/ (More information about FLatpak: https://youtu.be/SavmR9ZtHg0)
# 2. Step: Open a Terminal and run this command: cd Downloads && chmod +x fusion360-flatpak-dxvk-install.sh && bash fusion360-flatpak-dxvk-install.sh
# 3. Step: The installation will now start and set up everything for you automatically.
# 4. Step: Now you can use my other file "fusion360-flatpak-start.sh" for running Autodesk Fusion 360 on your system.
# 5. Step: When you have opened Fusion 360 -> Go to preferences and in General under Graphics driver, select DirectX 9.

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
flatpak run org.winehq.flatpak-proton-68-ge-1 winetricks -q corefonts vcrun2017 msxml4 dxvk fontsmooth=rgb win10 &&

 echo "Autodesk Fusion 360 will be installed and set up."
flatpak run org.winehq.flatpak-proton-68-ge-1 bash &&
cd $HOME &&
cd Downloads &&
mkdir -p fusion360 &&
cd fusion360 &&
wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe &&

wine Fusion\ 360\ Admin\ Install.exe -p deploy -g -f log.txt --quiet &&
wine Fusion\ 360\ Admin\ Install.exe -p deploy -g -f log.txt --quiet &&

echo "Change the DLL's with winecfg"
  echo "---------------------------------"
  echo "d3d10core = disabled"
  echo "d3d11 = builtin"
  echo "d3d9 = builtin"
  echo "dxgi = builtin"
  winecfg &&


# Autodesk Fusion 360 works also, when you skip the next step!!!

  echo "Now we open wine regedit and go to HKEY_CURRENT_USER\Software\Wine\Direct3D"
  echo "And here we can change this option (Experimental): renderer to vulkan"
  wine regedit

echo "The installation of Autodesk Fusion 360 is completed."
exit
