<h1>Fusion-360 - Linux (Wine Version)</h1>

![image](https://user-images.githubusercontent.com/79079633/114744478-07467500-9d4e-11eb-99a9-11596a78ccf1.png)

Hello and Welcome on my GitHub-Channel "Crinkfly"!

In this repository you can find some instructions for Autodesk Fusion 360, where you get a way to install this program on your system.
I will give you a feedback at different intervals, when there is something new.

My goal is that we can also use Autodesk Fusion 360 on Linux and so we don't need longer two operating systems for this program, when we use this for our projects. I think this is a fantastic idea!

________________________________________________

You will get more information about this program, then you can visit the original website of Autodesk Fusion 360 with this link: https://www.autodesk.com/products/fusion-360/features

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

Wine version: wine-6.7 (WINEARCH = win64)

________________________________________________

##### Installation on openSUSE Leap & Tumbleweed:

![openSUSE Leap 15.3](https://user-images.githubusercontent.com/79079633/115074681-53ceb380-9efa-11eb-92ea-7047f781ee8a.png)

    1.) Check if your system is up to date!!! (With YaST or open a Terminal and run this commands: su (input your root password!) and then: zypper up )

    2a.) Install these packages with YaST: wine & p7zip-full (winetricks, winbind, ... will be installed automatically!) -> OR
    2b.) Add this Repo: https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.2/ and install these packages with YaST: wine & p7zip-full
    
    3.) Reboot your system!
    
    4a.) Open a Terminal -> Run this command: cd Downloads && winetricks -q corefonts vcrun2017 msxml4 (minimum requirement for running Fusion 360) -> OR
    4b.) Run this command: cd Downloads && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && chmod +x winetricks && sh winetricks -q corefonts vcrun2017 msxml4 (With this option you get the newest winetricks version!)

    5.) Run this command: winecfg 
    6.) Set the windows version to Windows 8 or 10 (Only when you use the wine version 6.6 or newer at the moment!)

    7.) Close this window

    8.) Run this command: mkdir fusion360 && cd fusion360

    9.) Run this command: wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe (Here we downloading the installer of Fusion 360.)

    10.) Run this commands: 7z x -osetup/ "Fusion 360 Admin Install.exe" && curl -Lo setup/platform.py github.com/python/cpython/raw/3.5/Lib/platform.py && sed -i 's/winver._platform_version or //' setup/platform.py

    11.) Run this command: wine setup/streamer.exe -p deploy -g -f log.txt --quiet (Run this command 2x)

    12.) Open your Filebrowser (for example Thunar) -> Go to this path: /home/YOUR-USER/.wine/drive_c/users/steve/Application Data/Autodesk/Neutron Platform/

    13.) Create a new folder: Options
    14.) Create a new file: NMachineSpecificOptions.xml
    15.) Insert this text:

`<?xml version="1.0" encoding="UTF-16" standalone="no" ?>
<OptionGroups>
  <BootstrapOptionsGroup SchemaVersion="2" ToolTip="Special preferences that require the application to be restarted after a change." UserName="Bootstrap">
    <driverOptionId ToolTip="The driver used to display the graphics" UserName="Graphics driver" Value="VirtualDeviceGLCore"/></BootstrapOptionsGroup>
</OptionGroups>`

    ... safe this file, close the editor and your file-browser. (With this method we selected openGL and so we dosn't need DXVK for the future!)

    16.) Run this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (Here we opening the program Fusion 360 and this creating some files in our .Fusion360 folder.)

    17.) Login with your account data

    18.) Now everything should work so far.


* Here can you see my way to install Fusion 360 on openSUSE Leap 15.2: https://youtu.be/-BktJspJKgs

________________________________________________________________________________________________


#### Installation on Ubuntu, Linux Mint, ...:

![Ubuntu](https://user-images.githubusercontent.com/79079633/115113193-6ba14880-9f89-11eb-8d88-b927a80939cd.png)

    1.) Check if your system is up to date!!! (You can do that, when you open a Termial -> Run this command: sudo apt-get update && sudo apt-get upgrade
    
    2.) Open a Terminal -> Run this command: sudo apt.get install -y p7zip p7zip-full p7zip-rar curl winbind
    
    3.) Run this command (install wine): sudo dpkg --add-architecture i386  && wget -nc https://dl.winehq.org/wine-builds/winehq.key && sudo apt-key add winehq.key && sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' && sudo apt-get update && sudo apt install --install-recommends winehq-staging
    
    4.) Reboot your system!
    
    5a.) Run this command: sudo apt install -y winetricks && cd Downloads && winetricks -q corefonts vcrun2017 msxml4 (minimum requirement for running Fusion 360) -> OR
    5b.) Run this command: cd Downloads && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && chmod +x winetricks && sh winetricks -q corefonts vcrun2017 msxml4 (With this option you get the newest winetricks version!)

    6.) Run this command: winecfg 
    7.) Set the windows version to Windows 8 or 10 (Only when you use the wine version 6.6 or newer at the moment!)

    8.) Close this window

    9.) Run this command: mkdir fusion360 && cd fusion360

    10.) Run this command: wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe (Here we downloading the installer of Fusion 360.)

    11.) Run this commands: 7z x -osetup/ "Fusion 360 Admin Install.exe" && curl -Lo setup/platform.py github.com/python/cpython/raw/3.5/Lib/platform.py && sed -i 's/winver._platform_version or //' setup/platform.py

    12.) Run this command: wine setup/streamer.exe -p deploy -g -f log.txt --quiet (Run this command 2x)

    13.) Open your Filebrowser (for example Thunar) -> Go to this path: /home/YOUR-USER/.wine/drive_c/users/steve/Application Data/Autodesk/Neutron Platform/

    14.) Create a new folder: Options
    15.) Create a new file: NMachineSpecificOptions.xml
    16.) Insert this text:

`<?xml version="1.0" encoding="UTF-16" standalone="no" ?>
<OptionGroups>
  <BootstrapOptionsGroup SchemaVersion="2" ToolTip="Special preferences that require the application to be restarted after a change." UserName="Bootstrap">
    <driverOptionId ToolTip="The driver used to display the graphics" UserName="Graphics driver" Value="VirtualDeviceGLCore"/></BootstrapOptionsGroup>
</OptionGroups>`

    ... safe this file, close the editor and your file-browser. (With this method we selected openGL and so we dosn't need DXVK for the future!)

    17.) Run this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (Here we opening the program Fusion 360 and this creating some files in our .Fusion360 folder.)

    18.) Login with your account data

    19.) Now everything should work so far.

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

    3.) Check if your system is up to date!!! (With Gnome-Software-Center or open a Terminal and run this commands: sudo dnf update && sudo dnf upgrade

    4.) Run this command: sudo dnf install p7zip p7zip-plugins && sudo dnf install curl

    5.) Open a Terminal -> Add a Repo (RPM) with this command: sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf update && sudo dnf upgrade

    6.) Run this command (install wine): sudo dnf install wine && sudo dnf install winetricks (It's important that you use the standard wine version from the fedora repository, because only this version works perfectly with winetricks and this one we need for the step 8a!)

    7.) Reboot your system!

    8a.) Open a Terminal -> Run this command: cd Downloads && winetricks -q corefonts vcrun2017 msxml4 (minimum requirement for running Fusion 360) -> OR
    8b.) Run this command: cd Downloads && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && chmod +x winetricks && sh winetricks -q corefonts vcrun2017 msxml4 (With this option you get the newest winetricks version!)
    
    9.) Change the wine version (devel): sudo dnf config-manager --add-repo https://dl.winehq.org/wine-builds/fedora/33/winehq.repo && sudo dnf install winehq-devel --allowerasing (Now you must install the devel version of wine, because with this version you get the internet connection!)

    10.) Run this command: winecfg 
    11.) Set the windows version to Windows 8 or 10 (Only when you use the wine version 6.6 or newer at the moment!)

    12.) Close this window

    13.) Run this command: mkdir fusion360 && cd fusion360

    14.) Run this command: wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe (Here we downloading the installer of Fusion 360.)

    15.) Run this commands: 7z x -osetup/ "Fusion 360 Admin Install.exe" && curl -Lo setup/platform.py github.com/python/cpython/raw/3.5/Lib/platform.py && sed -i 's/winver._platform_version or //' setup/platform.py

    16.) Run this command: wine setup/streamer.exe -p deploy -g -f log.txt --quiet (Run this command 2x)

    17.) Open your Filebrowser (for example Thunar) -> Go to this path: /home/YOUR-USER/.wine/drive_c/users/steve/Application Data/Autodesk/Neutron Platform/

    18.) Create a new folder: Options
    19.) Create a new file: NMachineSpecificOptions.xml
    20.) Insert this text:

`<?xml version="1.0" encoding="UTF-16" standalone="no" ?>
<OptionGroups>
  <BootstrapOptionsGroup SchemaVersion="2" ToolTip="Special preferences that require the application to be restarted after a change." UserName="Bootstrap">
    <driverOptionId ToolTip="The driver used to display the graphics" UserName="Graphics driver" Value="VirtualDeviceGLCore"/></BootstrapOptionsGroup>
</OptionGroups>`

    ... safe this file, close the editor and your file-browser. (With this method we selected openGL and so we dosn't need DXVK for the future!)

    21.) Run this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (Here we opening the program Fusion 360 and this creating some files in our .Fusion360 folder.)

    22.) Login with your account data

    23.) Now everything should work so far.

* Here can you see more about Fusion 360 on Fedora: https://youtu.be/JRu-OaGsv3A
________________________________________________________________________________________________


#### Installation on Manjaro (based on Arch Linux): 

![Manjaro](https://user-images.githubusercontent.com/79079633/114720624-76b16a00-9d38-11eb-84f9-9096f0bbbbc7.png)

    1.) Check if your system is up to date!!! (With Pamac or open a Terminal and run this commands: sudo pacman -Syu or sudo pacman -Syyu)

    2.) Open a terminal -> Run this command: pacman -S wine wine-mono wine_gecko winetricks

    3.) Reboot your system!
    
    4a.) Run this command: cd Downloads && winetricks -q corefonts vcrun2017 msxml4 (minimum requirement for running Fusion 360)
    4b.) Run this command: cd Downloads && wget https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks && chmod +x winetricks && sh winetricks -q corefonts vcrun2017 msxml4 (With this option you get the newest winetricks version!)

    5.) Run this command: winecfg 
    6.) Set the windows version to Windows 8 or 10 (Only when you use the wine version 6.6 or newer at the moment!)

    7.) Close this window

    8.) Run this command: mkdir fusion360 && cd fusion360

    9.) Run this command: wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe (Here we downloading the installer of Fusion 360.)

    10.) Run this commands: 7z x -osetup/ "Fusion 360 Admin Install.exe" && curl -Lo setup/platform.py github.com/python/cpython/raw/3.5/Lib/platform.py && sed -i 's/winver._platform_version or //' setup/platform.py

    11.) Run this command: wine setup/streamer.exe -p deploy -g -f log.txt --quiet (Run this command 2x)

    12.) Open your Filebrowser (for example Thunar) -> Go to this path: /home/YOUR-USER/.wine/drive_c/users/steve/Application Data/Autodesk/Neutron Platform/

    13.) Create a new folder: Options
    14.) Create a new file: NMachineSpecificOptions.xml
    15.) Insert this text:

`<?xml version="1.0" encoding="UTF-16" standalone="no" ?>
<OptionGroups>
  <BootstrapOptionsGroup SchemaVersion="2" ToolTip="Special preferences that require the application to be restarted after a change." UserName="Bootstrap">
    <driverOptionId ToolTip="The driver used to display the graphics" UserName="Graphics driver" Value="VirtualDeviceGLCore"/></BootstrapOptionsGroup>
</OptionGroups>`

    ... safe this file, close the editor and your file-browser. (With this method we selected openGL and so we dosn't need DXVK for the future!)

    16.) Run this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (Here we opening the program Fusion 360 and this creating some files in our .Fusion360 folder.)

    17.) Login with your account data

    18.) Now everything should work so far.

________________________________________________________________________________________________

#### Installation with Flatpak (Ubuntu) - EXPERIMENTAL:

1. Check if your system is up to date: Open a Termial -> Run this command: sudo apt-get update && sudo apt-get upgrade (And it's important that have installed the newest graphics driver!)

2. Run this command: sudo apt-get install p7zip p7zip-full p7zip-rar && sudo apt-get install curl 

3. Run this command (install flatpak): sudo apt install flatpak

4. Run this command: flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

5. Run this command sudo nano /etc/hosts (Change this file!)

         127.0.0.1     localhost
         127.0.1.1     EXAMPLE-NAME
         
         ::1 ip6-localhost ip6-loopback
         fe00::0 ip6-localnet
         ff00::0 ip6-mcastprefix
         ff02::1 ip6-allnodes
         ff02::2 ip6-allrouters
         ff02::3 ip6-allhosts

6. Run this command: sudo nano /etc/hostname (Change this file!)

        EXAMPLE-NAME

7. Reboot your system!

8. Open a Terminal -> Run this command: flatpak install flathub org.phoenicis.playonlinux

10. Run this command: cd Downloads && mkdir fusion360 && cd fusion360

11. Run this command: wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe (Here we downloading the installer of Fusion 360.)

12. Run this command: 7z x -osetup/ "Fusion 360 Admin Install.exe" && curl -Lo setup/platform.py github.com/python/cpython/raw/3.5/Lib/platform.py && sed -i 's/winver._platform_version or //' setup/platform.py

13. Close the terminal

14. Then you must look to my instruction: https://github.com/PhoenicisOrg/phoenicis/issues/2389
      (Safe your winetricks (file) here: /home/YOUR-USER/Downloads/ winetricks)

15. Now, you can continue with the installation of Fusion 360.

![2](https://user-images.githubusercontent.com/79079633/115906698-26d55000-a468-11eb-861f-2d3432cb9727.png)
![3](https://user-images.githubusercontent.com/79079633/115906701-26d55000-a468-11eb-8a01-4ab5138cac2d.png)
![4](https://user-images.githubusercontent.com/79079633/115906702-276de680-a468-11eb-85e4-67a002883ace.png)

16. Open the terminal:

![5](https://user-images.githubusercontent.com/79079633/115906705-276de680-a468-11eb-8f1a-c53e9b88a325.png)

17. Run this command: cd $HOME/Downloads/ && sh winetricks -q corefonts vcrun2017 msxml4

18. Run this command: winecfg 
19. Set the windows version to Windows 10

20. Run this command: cd fusion360 && wine setup/streamer.exe -p deploy -g -f log.txt --quiet (Run this command 2x)

21. Close the Terminal.

22. Open your Filebrowser (for example Thunar) -> Go to this path: /home/YOUR-USER/.var/app/org.phoenicis.playonlinux/.Phoenicis/containers/wineprefix/Fusion/drive_c/users/steve/Application Data/Autodesk/Neutron Platform/

23. Create a new folder: Options
24. Create a new file: NMachineSpecificOptions.xml
25. Insert this text:

`<?xml version="1.0" encoding="UTF-16" standalone="no" ?>
<OptionGroups>
  <BootstrapOptionsGroup SchemaVersion="2" ToolTip="Special preferences that require the application to be restarted after a change." UserName="Bootstrap">
    <driverOptionId ToolTip="The driver used to display the graphics" UserName="Graphics driver" Value="VirtualDeviceGLCore"/></BootstrapOptionsGroup>
</OptionGroups>`

... safe this file, close the editor and your file-browser.

26. Open the terminal:

![5](https://user-images.githubusercontent.com/79079633/115906705-276de680-a468-11eb-8f1a-c53e9b88a325.png)

27. Run this command: cd drive_c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/ && wine Autodesk\ Fusion\ 360.Ink

![#1_Phoenicis PlayOnLinux](https://user-images.githubusercontent.com/79079633/115911821-dca39d00-a46e-11eb-8547-5a53007178e1.png)


#### Fusion 360 dosn't work at the moment with this method! Only the installation of Fusion 360 works!

But you can see now, that I search for a solution, so that Fusion 360 works on all Linux distributions.
This is just one of my ways to get Fusion 360 up and running using Flatpak.

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

##### Application Maintainer (WineHQ): https://appdb.winehq.org/objectManager.php?sClass=version&iId=36468

- @cryinkfly (Administrator & Project Manager)

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
________________________________________________________________________________________________

#### When you will dosn't use openGL:

- Run this command: winetricks -q corefonts vcrun2017 msxml4 dxvk (Then you must install also dxvk!)
- Run this command: winecfg -> Go to libraries -> Change these options:

    - d3d10core = disabled
    - d3d11 = builtin
    - d3d9 = builtin
    - dxgi = builtin

When you have opened Fusion 360 -> Go to preferences and in General under Graphics driver, select DirectX 9.
