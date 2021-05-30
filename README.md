<h1>Fusion-360 - Linux (Wine Version)</h1>

![image](https://user-images.githubusercontent.com/79079633/114744478-07467500-9d4e-11eb-99a9-11596a78ccf1.png)

Hello and Welcome on my GitHub-Channel "Crinkfly"!

My name is Steve and in this repository you can find some instructions for Autodesk Fusion 360, where you get a way to install this program on your system.
I will give you a feedback at different intervals, when there is something new.

My goal is that we can also use Autodesk Fusion 360 on Linux and so we don't need longer two operating systems for this program, when we use this for our projects. I think this is a fantastic idea!

________________________________________________

You will get more information about this program, then you can visit the original website of Autodesk Fusion 360 with this link: https://www.autodesk.com/products/fusion-360/features

________________________________________________

You might want to use other CAD programs, then you can find more programs here:

- SOLIDWORKS: https://github.com/cryinkfly/SOLIDWORKS-Linux-Wine-Version-
- Rhino 3D: https://github.com/cryinkfly/Rhino-3D---Linux-Wine-Version-
- ...
________________________________________________

Also you get more informations about Fusion 360, when you visit my other channels:

  - Facebook:  https://www.facebook.com/cryinkfly/
  - Instagram: https://www.instagram.com/cryinkfly/
  - YouTube:   https://www.youtube.com/channel/UCJO-EOBPtlVv5OycHkFPcRg


![YouTube_channel](https://user-images.githubusercontent.com/79079633/119709635-b9994e00-be5d-11eb-976a-fca87b572af1.png)

________________________________________________

My system:

OS: openSUSE Leap 15.3 x86_64<br/>
Kernel: 5.3.18-57-default<br/>
DE: Xfce<br/>
CPU: Intel i7-7700HQ (8) @ 3.800GHz<br/>
GPU: NVIDIA GeForce GTX 1060 Mobile 6G (Community Repository Nvidia & CUDA Repository)<br/>
Memory: 32GB

Wine version: wine-6.9 (WINEARCH = win64)

________________________________________________

#### Installation on openSUSE Leap & Tumbleweed:

![openSUSE Leap 15.3](https://user-images.githubusercontent.com/79079633/115074681-53ceb380-9efa-11eb-92ea-7047f781ee8a.png)

1.) Download my scripts: [Installation-Script](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-install.sh) & [Start-Script](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-start.sh)

2.) On openSUSE Tumbleweed you must delete the steps for adding the wine-Repository in my file "fusion360-install.sh"!
    
3.) Follow my instructions in my files "fusion360-install.sh" & "fusion360-start.sh" !

*Notice: Check if you have installed the newest graphics driver on your system!

________________________________________________________________________________________________


#### Installation on Ubuntu, Linux Mint, ...:

![Ubuntu](https://user-images.githubusercontent.com/79079633/115113193-6ba14880-9f89-11eb-8d88-b927a80939cd.png)

1.) Download my scripts: [Installation-Script](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-install.sh) & [Start-Script](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-start.sh)
    
2.) Follow my instructions in my files "fusion360-install.sh" & "fusion360-start.sh" !

*Notice: Check if you have installed the newest graphics driver on your system!

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

3.) Reboot your system

4.) Download my scripts: [Installation-Script](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-install.sh) & [Start-Script](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-start.sh)

5.) Follow my instructions in my files "fusion360-install.sh" & "fusion360-start.sh" !

*Notice: Check if you have installed the newest graphics driver on your system!
 
________________________________________________________________________________________________


#### Installation on Manjaro (based on Arch Linux): 

![Manjaro](https://user-images.githubusercontent.com/79079633/114720624-76b16a00-9d38-11eb-84f9-9096f0bbbbc7.png)


1.) Download my scripts: [Installation-Script](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-install.sh) & [Start-Script](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-start.sh)

2.) Follow my instructions in my files "fusion360-install.sh" & "fusion360-start.sh" !

*Notice: Check if you have installed the newest graphics driver on your system!

________________________________________________________________________________________________

#### Installation with Flatpak - EXPERIMENTAL:

![Login Screen](https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/images/flatpak/org.winehq.flatpak-proton-68-ge-1/%2310_Flatpak_Autodesk_Fusion_360.png)

1.) Look into my file [fusion360-install.sh](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-install.sh) and install the the minimum requirements!

2.) Install Flatpak on your system: https://flatpak.org/setup/ (More information about FLatpak: https://youtu.be/SavmR9ZtHg0)

3.) Download my scripts: [Installation-Script](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-flatpak-install.sh) & [Start-Script](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-flatpak-start.sh)

2.) Follow my instructions in my files "fusion360-flatpak-install.sh" & "fusion360-flatpak-start.sh" !

*Notice: Check if you have installed the newest graphics driver on your system!

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

##### Special thanks to https://github.com/probonopd for his old guide here: https://gist.github.com/probonopd/0fab254aa0b6fc371d8db641822bd530 ! :-)

________________________________________________________________________________________________

##### Super Application Maintainer (WineHQ): https://appdb.winehq.org/objectManager.php?sClass=application&iId=15617
- @cryinkfly (Administrator & Project Manager)

________________________________________________________________________________________________

##### Special thanks go to these users:

- @dreamcat4
- @mike-lloyd03
- @Tony763
- @fastrizwaan
- @DD1984

... they help me to get work Fusion 360 on Linux!!!
________________________________________________________________________________________________

#### Which workspaces I have tested:

- Construction (works)
- Animation (works)
- Rendering (works , but when you will saving a rendered file, then you must changing something: https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/releases/tag/v1.2
- Production (works)
- Simulation (works)
- Generative Design (works)
- Documentation / Drawing (dosn't work correctly)
________________________________________________________________________________________________

#### When you will dosn't use openGL:

Then you can install Autodesk Fusion 360 with these scripts: 

- [fusion360-dxvk-install.sh](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-dxvk-install.sh)
- [fusion360-flatpak-dxvk-install.sh](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-flatpak-dxvk-install.sh)
________________________________________________________________________________________________

#### If you have some problems or a question:

https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/issues
