<a href="https://apps.autodesk.com/FUSION/en/Detail/Index?id=5679198834514673847&appLang=en&os=Win64">OctoPrint for Autodesk® Fusion 360™</a> is a plugin where you can send directly the G-code of your created model to the OctoPrint server via Autodesk Fusion 360 and then it will be printed for you a physical model with a 3D-Printer.

The publisher of this plugin is <a href="/en/Publisher/PublisherHomepage?ID=QP9QKVEMEAC3" target="_blank"><span class="seller">Autodesk, Inc.</span></a>!

You will get more information about OctoPrint, then you can visit the original website of Octoprint with this link: https://octoprint.org/

---

## Hardware and Software Requirements

- You must have installed Autodesk Fusion 360 on your system!

---

## Getting Started

Install OctoPrint for Autodesk® Fusion 360™ for Autodesk Fusion 360:

[![Watch the video](https://user-images.githubusercontent.com/79079633/133934603-9889a162-bc44-4968-aee1-6217cf05e160.png)](https://youtu.be/01lnwcE1ieg)



1.) You can only download the installation program when you have previously logged into with your account on: https://apps.autodesk.com!

2.) Then you must search for OctoPrint:

![search_octoprint_app](https://user-images.githubusercontent.com/79079633/128554855-3489c501-1b1b-4a4c-8df4-e4f278b2b0b1.png)


3.) Select this one and download the installation program:

![download_octoprint_app](https://user-images.githubusercontent.com/79079633/128555234-28c5a358-c52c-400a-b85c-ae1502b8f502.png)


4.) Open a terminal and run this command (For example if you have Autodesk Fusion 360 installed into your home directory!):

    cd Downloads && WINEPREFIX=/$HOME/.wineprefixes/fusion360 wine OctoPrint_for_Fusion360-win64.msi

4.1.) Install the OctoPrint for Autodesk® Fusion 360™ plugin:

![octoprint_fusion360_install](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/files/images/extensions/OctoPrint%20for%20Autodesk%C2%AE%20Fusion%20360%E2%84%A2/octoprint_fusion360_install.png)


5.) If you have opened Autodesk Fusion 360 then you must restart the program!

6.) Then you must configure the OctoPrint plugin in Autodesk Fusion 360 and you are connected to the OctoPrint server!

![octoprint_fusion360_configure_1](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/files/images/extensions/OctoPrint%20for%20Autodesk%C2%AE%20Fusion%20360%E2%84%A2/octoprint_fusion360_configure_1.png)

![octoprint_fusion360_configure_2](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/files/images/extensions/OctoPrint%20for%20Autodesk%C2%AE%20Fusion%20360%E2%84%A2/octoprint_fusion360_configure_2.png)


7.) Now you can send directly the G-code of your created model to the OctoPrint server via Autodesk Fusion 360 and then it will be printed for you! ⏳

![octoprint_fusion360_send_gcode_1](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/files/images/extensions/OctoPrint%20for%20Autodesk%C2%AE%20Fusion%20360%E2%84%A2/octoprint_fusion360_send_gcode_1.png)

![octoprint_fusion360_send_gcode_2](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/files/images/extensions/OctoPrint%20for%20Autodesk%C2%AE%20Fusion%20360%E2%84%A2/octoprint_fusion360_send_gcode_2.png)

---

## Would you like to installt the OctoPrint server on your old computer or Raspberry Pi? (Debian-based Linux distributions)

Then you have the option here to install it with this command:

    cd Downloads && wget -N https://raw.githubusercontent.com/cryinkfly/Autodesk-Fusion-360-for-Linux/main/files/extras/octoprint-server/octoprint-server-install.sh && chmod +x octoprint-server-install.sh && bash octoprint-server-install.sh && exit
    
*Notice: On a Raspberry Pi Device or system with Raspberry Pi OS it's good when you running this command: 

    sudo apt-get --allow-releaseinfo-change update

...before you install the OctoPrint-Server!

After the installation you can start, stop or restart the server with changing the option of this command:

    sudo service octoprint {start|stop|restart}
    
For example, you want to start the server:

    sudo service octoprint start

Then you can access the server by heading to http://YOUR-IP-ADDRESS:5000 and you should be greeted with the OctoPrint UI.

![octoprint_vm](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/files/images/extensions/OctoPrint%20for%20Autodesk%C2%AE%20Fusion%20360%E2%84%A2/octoprint_vm.png)

But you can configure a lot more and so I recommend reading this post here:

- https://community.octoprint.org/t/setting-up-octoprint-on-a-raspberry-pi-running-raspbian-or-raspberry-pi-os/2337

---

## Important Notice

With the help of my manual, You get a way to use OctoPrint for Autodesk® Fusion 360™ under Autodesk Fusion 360 and nothing more!







