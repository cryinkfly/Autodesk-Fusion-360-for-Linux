<h1>Fusion-360 - Linux (Wine Version)</h1>

I decided to use WINE to run this program just as well under Linux as it did under Windows, so that you no longer have to run two operating systems just to be able to use Fusion 360.

As a Linux distribution I use openSuse Leap 15.2 with the desktop environment Xfce and the Wine version from the standard repositories. I also use an Nvidia graphics card and use the drivers from the community repository.

The program is actually already running, but I go a step further and have added the CUDA repository from Nvidia to use the CUDA toolkits.

This gives me more performance for Fusion 360 and my other programs that I use.

Of course you can also use another Linux distribution, because on most of these systems you also get access to the programs and packages I use.


________________________________________________

Here and on my other channels, as well as on my website, I will not only create instructions for installation, but also publish test reports on the respective working environments (simulation, animation, ...).


________________________________________________

My system:

OS: openSUSE Leap 15.2 x86_64
Kernel: 5.3.18-lp152.63-default
DE: Xfce
CPU: Intel i7-7700HQ (8) @ 3.800GHz
GPU: NVIDIA GeForce GTX 1060 Mobile 6G (Community Repository Nvidia)
Memory: 32GB

Wine version: wine-5.0 (WINEARCH = win64)

I proceeded as follows:

    Open Yast -> Install Software -> "wine" & "p7zip-full"

    Reboot the system

    Open a Terminal -> Run: winetricks corefonts vcrun2017 msxml3 msxml4 msxml6 dxvk
    or install these packages manual with "winetricks" (minimum requirement for running Fusion 360)

    Close winetricks, when You install manual.

    Run: winecfg
    Set the windows version to Windows 8

    Close this window

    Run: clear

    Run: cd Downloads && mkdir fusion360 && cd fusion360

    Run: wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe

    Run: 7z x -osetup/ "Fusion 360 Admin Install.exe" && curl -Lo setup/platform.py github.com/python/cpython/raw/3.5/Lib/platform.py && sed -i 's/winver._platform_version or //' setup/platform.py

    Run: winecfg
    Set the windows version to Windows 8

    Run: wine setup/streamer.exe -p deploy -g -f log.txt --quiet

    Run Fusion 360: env WINEPREFIX="/home/steve/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk

    Login with your account data

    Then go to preferences and in General under Graphics driver select DirectX 9.

    Close Fusion 360

    winecfg -> libraries -> change:

    d3d10core = disabled
    d3d11 = native
    d3d9 = builtin
    dxgi = native

    Open Fusion again: env WINEPREFIX="/home/steve/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk

    Now everything should work so far.

    Note: simply ignore errors that occur during installation. The installation of Fusion 360 was repeated several times to ensure that it really worked.

Which workspaces I have tested:

    construction (works)
    animation (works)
    rendering (works with problems - The problem is, when you will saving a rendered file, then you must kill Fusion 360. After this you can see a window, where you can save this file.
    production (seems to work at first glance)

Further changes to Fusion 360 will be made and further tests will be carried out as well.

Here You can see the installation of Fusion360 on a Linux system: https://youtu.be/-BktJspJKgs
