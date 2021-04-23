<h1>Fusion-360 - Linux (Wine Version)</h1>

![image](https://user-images.githubusercontent.com/79079633/114744478-07467500-9d4e-11eb-99a9-11596a78ccf1.png)


I use WINE for running this program on Linux, so you don't need longer two operating systems just to be able to use Fusion 360.

On my system I use openSUSE Leap 15.3 with the desktop environment Xfce.

Fusion 360 is actually already running, but I go a step further and have added the CUDA repository from Nvidia to use the CUDA toolkits, because I think this gives me more performance for Fusion 360.

________________________________________________

You can find here instructions for openSUSE Leap & Tumbleweed, Ubuntu and for another Linux distributions.

________________________________________________

With this link you come to the original website of Autodesk Fusion 360, where you can also get more information about this program: https://www.autodesk.com/products/fusion-360/features

________________________________________________

Also you get more informations about Fusion 360, when you visit my other channels:

  - Facebook:  https://www.facebook.com/cryinkfly/
  - Instagram: https://www.instagram.com/cryinkfly/
  - YouTube:   https://www.youtube.com/channel/UCJO-EOBPtlVv5OycHkFPcRg


![YouTube_channel](https://user-images.githubusercontent.com/79079633/115113000-5d066180-9f88-11eb-89c4-fd4ddea305ed.png)


________________________________________________

My system:

OS: openSUSE Leap 15.3 Beta x86_64<br/>
Kernel: 5.3.18-52-default<br/>
DE: Xfce<br/>
CPU: Intel i7-7700HQ (8) @ 3.800GHz<br/>
GPU: NVIDIA GeForce GTX 1060 Mobile 6G (Community Repository Nvidia & CUDA Repository)<br/>
Memory: 32GB

Wine version: wine-6.6 (WINEARCH = win64)

________________________________________________

##### Installation on openSUSE Leap & Tumbleweed:

![openSUSE Leap 15.3](https://user-images.githubusercontent.com/79079633/115074681-53ceb380-9efa-11eb-92ea-7047f781ee8a.png)

    1.) Open Yast -> Install Software -> Install these packages: wine & p7zip-full (And it's important that have installed the newest graphics driver!) -> Reboot your system
    
    2.) Open a Terminal -> Run this command: winetricks corefonts vcrun2017 msxml4 dxvk (minimum requirement for running Fusion 360)

    3.) Run this command: winecfg 
    4.) Set the windows version to Windows 8 or 10 (only when you use the wine version 6.6 -> At the moment)

    5.) Close this window

    6.) Run this command: clear (It's better to see, what happens, when we clear the terminal.)

    7.) Run this command: cd Downloads && mkdir fusion360 && cd fusion360

    8.) Run this command: wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe (Here we downloading the installer of Fusion 360.)

    9.) Run this commands: 7z x -osetup/ "Fusion 360 Admin Install.exe" && curl -Lo setup/platform.py github.com/python/cpython/raw/3.5/Lib/platform.py && sed -i 's/winver._platform_version or //' setup/platform.py

    10.) Run this command: wine setup/streamer.exe -p deploy -g -f log.txt --quiet (Run this command 2x)

    11.) Run this command: cd $HOME && mkdir .Fusion360 && cd .Fusion360

    12.) Run this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (Here we opening the program Fusion 360 and this creating some files in our .Fusion360 folder.)

    13.) Login with your account data

    14.) Then go to preferences and in General under Graphics driver, select DirectX 9. <-- OR -->
    15.) Then go to preferences and in General under Graphics driver, select OpenGL <-- This is now the best choise for Fusion 360!

    16.) Close Fusion 360

    17.) Run this command: winecfg -> Go to libraries -> Change these options:

    d3d10core = disabled
    d3d11 = builtin
    d3d9 = builtin
    dxgi = builtin

    
    18.) Open Fusion again with this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (It's important, that your changing to your .Fusion360 folder in our home-directory and run then this command now & in the future here.)

    19.) Now everything should work so far.


* Here can you see my way to install Fusion 360 on openSUSE Leap 15.2: https://youtu.be/-BktJspJKgs

________________________________________________________________________________________________


#### Installation on Ubuntu, Linux Mint, ...:

![Ubuntu](https://user-images.githubusercontent.com/79079633/115113193-6ba14880-9f89-11eb-8d88-b927a80939cd.png)

    1.) Check if your system is up to date: Open a Termial -> Run this command: sudo apt-get update && sudo apt-get upgrade (And it's important that have installed the newest graphics driver!)
    
    2.) Then run this command (install wine): sudo dpkg --add-architecture i386  && wget -nc https://dl.winehq.org/wine-builds/winehq.key && sudo apt-key add winehq.key && sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' && sudo apt-get update && sudo apt install --install-recommends winehq-staging && sudo apt install winetricks
    
    3.) Run this command: sudo apt-get install p7zip p7zip-full p7zip-rar && sudo apt-get install curl && sudo apt-get install winbind
    
    4.) Run this command: winetricks corefonts vcrun2017 msxml4 dxvk (minimum requirement for running Fusion 360)

    5.) Run this command: winecfg 
    6.) Set the windows version to Windows 8 or 10 (only when you use the wine version 6.6 -> At the moment)

    7.) Close this window

    8.) Run this command: clear (It's better to see, what happens, when we clear the terminal.)

    9.) Run this command: cd Downloads && mkdir fusion360 && cd fusion360

    10.) Run this command: wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe (Here we downloading the installer of Fusion 360.)

    11.) Run this command: 7z x -osetup/ "Fusion 360 Admin Install.exe" && curl -Lo setup/platform.py github.com/python/cpython/raw/3.5/Lib/platform.py && sed -i 's/winver._platform_version or //' setup/platform.py

    12.) Run this command: wine setup/streamer.exe -p deploy -g -f log.txt --quiet (Run this command 2x)

    13.) Run this command: cd $HOME && mkdir .Fusion360 && cd .Fusion360

    14.) Run this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (Here we opening the program Fusion 360 and this creating some files in our .Fusion360 folder.)

    15.) Login with your account data

    16.) Then go to preferences and in General under Graphics driver, select DirectX 9. <-- OR -->
    17.) Then go to preferences and in General under Graphics driver, select OpenGL <-- This is now the best choise for Fusion 360!

    18) Close Fusion 360

    19.) Run this command: winecfg -> Go to libraries -> Change these options:

    d3d10core = disabled
    d3d11 = builtin
    d3d9 = builtin
    dxgi = builtin

    
    20.) Open Fusion again with this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (It's important, that your changing to your .Fusion360 folder in our home-directory and run then this command now & in the future here.)

    21.) Now everything should work so far.

* Here can you see more about Fusion 360 on Ubuntu: https://youtu.be/NJTV_enR6io & https://www.youtube.com/watch?v=R-ev3dhNM98

________________________________________________________________________________________________


#### Installation on Fedora:

![Fedora](https://user-images.githubusercontent.com/79079633/114680044-0d683180-9d0d-11eb-9aff-ed747060a5d4.png)

    1.) Open a Terminal and run this command sudo nano /etc/hosts (Change this file!)

             127.0.0.1     localhost
             127.0.1.1     EXAMPLE-NAME
             
             ::1 ip6-localhost ip6-loopback
             fe00::0 ip6-localnet
             ff00::0 ip6-mcastprefix
             ff02::1 ip6-allnodes
             ff02::2 ip6-allrouters
             ff02::3 ip6-allhosts
    
    2.) Run this command: sudo nano /etc/hostname (Change this file!)
    
            EXAMPLE-NAME

    3.) Check if your system is up to date: Open the Gnome-Software-Center -> Update your system and change to the Termial -> Run this command: sudo dnf update && sudo dnf upgrade -> Reboot your system (And it's important that have installed the newest graphics driver!)
    
    4.) Open a Terminal -> Add a Repo (RPM) with this command: sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf update && sudo dnf upgrade
    
    5.) Then run this command (install wine): sudo dnf install wine && sudo dnf install winetricks (It's important that you use the standard wine version from the fedora repository, because only this version works perfectly with winetricks and this one we need for the step 6. !)

    6.) Run this command: sudo dnf install p7zip p7zip-plugins && sudo dnf install curl

    7.) Reboot your system

    8.) Open a Terminal -> Run this command: winetricks corefonts vcrun2017 msxml4 dxvk (minimum requirement for running Fusion 360)

    9.) Run this command: winecfg 
    10.) Set the windows version to Windows 8 or 10 (only when you use the wine version 6.6 -> At the moment)

    11.) Close this window

    12.) Run this command: clear (It's better to see, what happens, when we clear the terminal.)

    13.) Run this command: cd Downloads && mkdir fusion360 && cd fusion360

    14.) Run this command: wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe (Here we downloading the installer of Fusion 360.)

    15.) Run this command: 7z x -osetup/ "Fusion 360 Admin Install.exe" && curl -Lo setup/platform.py github.com/python/cpython/raw/3.5/Lib/platform.py && sed -i 's/winver._platform_version or //' setup/platform.py

    16.) Run this command: wine setup/streamer.exe -p deploy -g -f log.txt --quiet (Run this command 2x)
    
    17.) Change the wine version (devel): sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/33/winehq.repo && sudo dnf install winehq-devel --allowerasing (Now you must install the devel version of wine, because with this version you get the internet connection!)
    
    18.) Reboot your system

    19.) Open a Terminal -> Run this command: cd $HOME && mkdir .Fusion360 && cd .Fusion360
    
    20.) Run this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (Here we opening the program Fusion 360 and this creating some files in our .Fusion360 folder.)

    21.) Login with your account data

    22.) Then go to preferences and in General under Graphics driver, select DirectX 9. <-- OR -->
    23.) Then go to preferences and in General under Graphics driver, select OpenGL <-- This is now the best choise for Fusion 360!

    24) Close Fusion 360

    25.) Run this command: winecfg -> Go to libraries -> Change these options:

    d3d10core = disabled
    d3d11 = builtin
    d3d9 = builtin
    dxgi = builtin

    
    26.) Open Fusion again with this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (It's important, that your changing to your .Fusion360 folder in our home-directory and run then this command now & in the future here.)

    27.) Now everything should work so far.

* Here can you see more about Fusion 360 on Fedora: https://youtu.be/JRu-OaGsv3A
________________________________________________________________________________________________


#### Installation on Manjaro (based on Arch Linux): 

![Manjaro](https://user-images.githubusercontent.com/79079633/114720624-76b16a00-9d38-11eb-84f9-9096f0bbbbc7.png)

    1.) Check if your system is up to date. (And it's important that have installed the newest graphics driver!)

    2.) Open a terminal -> Run this command: pacman -S wine winetricks wine-mono wine_gecko
    
    3.) Run this command: winetricks corefonts vcrun2017 msxml4 dxvk (minimum requirement for running Fusion 360)

    4.) Run this command: winecfg 
    5.) Set the windows version to Windows 8 or 10

    6.) Close this window

    7.) Run this command: clear (It's better to see, what happens, when we clear the terminal.)

    8.) Run this command: cd Downloads && mkdir fusion360 && cd fusion360

    9.) Run this command: wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe (Here we downloading the installer of Fusion 360.)

    10.) Run this commands: 7z x -osetup/ "Fusion 360 Admin Install.exe" && curl -Lo setup/platform.py github.com/python/cpython/raw/3.5/Lib/platform.py && sed -i 's/winver._platform_version or //' setup/platform.py

    11.) Run this command: wine setup/streamer.exe -p deploy -g -f log.txt --quiet (Run this command 2x)

    12.) Run this command: cd $HOME && mkdir .Fusion360 && cd .Fusion360

    13.) Run this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (Here we opening the program Fusion 360 and this creating some files in our .Fusion360 folder.)

    14.) Login with your account data

    15.) Then go to preferences and in General under Graphics driver, select DirectX 9. <-- OR -->
    16.) Then go to preferences and in General under Graphics driver, select OpenGL <-- This is now the best choise for Fusion 360!

    17.) Close Fusion 360

    18.) Run this command: winecfg -> Go to libraries -> Change these options:

    d3d10core = disabled
    d3d11 = builtin
    d3d9 = builtin
    dxgi = builtin

    
    19.) Open Fusion again with this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (It's important, that your changing to your .Fusion360 folder in our home-directory and run then this command now & in the future here.)

    20.) Now everything should work so far.

________________________________________________________________________________________________

#### If you use Wine under XWayland, you can activate the option for "Emulating a virtual desktop" in the Graphics Tab in winecfg, to avoid problems with:

- flickering
- wrong window location
- wrong mouse cursor location and clicks
- keyboard detection

________________________________________________________________________________________________

##### Note: Simply ignore errors that occur during installation. 
#####       The installation of Fusion 360 was repeated several times to ensure that it really worked.

________________________________________________________________________________________________

#####        Special thanks to https://github.com/probonopd for his old guide here: https://gist.github.com/probonopd/0fab254aa0b6fc371d8db641822bd530 ! :-)

________________________________________________________________________________________________

#####        Development team:

- @cryinkfly (Administrator & Project Manager)
- @dreamcat4
________________________________________________________________________________________________

#### Which workspaces I have tested:

- construction (works)
- animation (works)
- rendering (works , but when you will saving a rendered file, then you must changing something: https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/releases/tag/v1.2
-  production (works)
-  simulation (Local calculation dosn't work at the moment)
