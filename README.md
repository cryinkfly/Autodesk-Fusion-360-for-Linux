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

Wine version: wine-5.0 (WINEARCH = win64)<br/>
Wine version: wine-6.6 (WINEARCH = win64)

________________________________________________

Installation on openSUSE Leap & Tumbleweed:

    1.) Open Yast -> Install Software -> Install these packages: wine & p7zip-full -> Reboot your system
    
    2.) Open a Terminal -> Run this command: winetricks corefonts vcrun2017 msxml4 dxvk (minimum requirement for running Fusion 360)

    3.) Run this command: winecfg 
    4.) Set the windows version to Windows 8 or 10 (only when you use the wine version 6.6 -> At the moment)

    5.) Close this window

    6.) Run this command: clear (It's better to see, what happens, when we clear the terminal.)

    7.) Run this command(s): cd Downloads && mkdir fusion360 && cd fusion360

    8.) Run this command: wget https://dl.appstreaming.autodesk.com/production/installers/Fusion%20360%20Admin%20Install.exe (Here we downloading the installer of Fusion 360.)

    9.) Run this command: 7z x -osetup/ "Fusion 360 Admin Install.exe" && curl -Lo setup/platform.py github.com/python/cpython/raw/3.5/Lib/platform.py && sed -i 's/winver._platform_version or //' setup/platform.py

    10.) Run this command: wine setup/streamer.exe -p deploy -g -f log.txt --quiet (Run this command 2x)

    11.) Run this command(s): cd $HOME && mkdir .Fusion360 && cd .Fusion360

    12.) Run this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (Here we opening the program Fusion 360 and this creating some files in our .Fusion360 folder.)

    13.) Login with your account data

    14.) Then go to preferences and in General under Graphics driver, select DirectX 9. <-- OR -->
    15.) Then go to preferences and in General under Graphics driver, select OpenGL <-- This is now the best choise for Fusion 360!

    16.) Close Fusion 360

    17.) Run this command: winecfg -> Go to libraries -> Change these options: <-- We don't need this one, now!

    d3d10core = disabled
    d3d11 = native
    d3d9 = builtin
    dxgi = native

    
    18.) Open Fusion again with this command: env WINEPREFIX="/home/YOUR_USER_NAME/.wine" wine C:\\windows\\command\\start.exe /Unix /home/YOUR_USER_NAME/.wine/dosdevices/c:/ProgramData/Microsoft/Windows/Start\ Menu/Programs/Autodesk/Autodesk\ Fusion\ 360.lnk (It's important, that your changing to your .Fusion360 folder in our home-directory and run then this command now & in the future here.)

    19.) Now everything should work so far.


* Note: Simply ignore errors that occur during installation. The installation of Fusion 360 was repeated several times to ensure that it really worked.
        Here can you see my way to install Fusion 360 on openSUSE Leap 15.2: https://youtu.be/-BktJspJKgs

________________________________________________________________________________________________


Installation on Ubuntu, Linux Mint, ...:   Still in progress!!! -> https://youtu.be/NJTV_enR6io & https://www.youtube.com/watch?v=R-ev3dhNM98

________________________________________________________________________________________________
________________________________________________________________________________________________

Which workspaces I have tested:

- construction (works)
- animation (works)
- rendering (works , but when you will saving a rendered file, then you must changing something: https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/releases/tag/v1.2
-  production (works)
-  simulation (Local calculation dosn't work at the moment)

Further changes to Fusion 360 will be made and further tests will be carried out as well.
