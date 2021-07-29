![banner-fusion360](https://user-images.githubusercontent.com/79079633/127371623-6b50b591-1b12-466d-9c96-b5b6d6314f31.png)

![GitHub last commit](https://img.shields.io/github/last-commit/cryinkfly/Fusion-360---Linux-Wine-Version-?style=for-the-badge)
![GitHub issues](https://img.shields.io/github/issues-raw/cryinkfly/Fusion-360---Linux-Wine-Version-?style=for-the-badge)
![GitHub Repo stars](https://img.shields.io/github/stars/cryinkfly/Fusion-360---Linux-Wine-Version-?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/cryinkfly/Fusion-360---Linux-Wine-Version-?style=for-the-badge)

Fusion 360 is a cloud-based 3D modeling, CAD, CAM, and PCB software platform for product design and manufacturing, what you can use on Windows and macOS.

But the problem is that there are also people like me who don't want to use either of these two operating systems on there systems. Then these users have installed a Linux distribution such as openSUSE Leap, Ubuntu or Fedora.

And so I got the idea to start this project here to find a way to solve this problem. 

I started looking at different tools and my choice was Wine! 

With this nice tool we don't need longer two operating systems for Fusion 360, when we will create a fantastic project in the future or if you want to work on a project with other people.

Is that a great idea for the future?

Personally, I think this idea is good and for this reason I will do my best to give you the opportunity to use it on Linux as well!

---

You will get more information about this program, then you can visit the original website of Autodesk Fusion 360 with this link: https://www.autodesk.com/products/fusion-360/features

---

  - 📂 Downloads: Stable and nightly builds: Still in Progress!
  - 📔 Documentation: ![GitHub-Documentation](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/wiki/Documentation) & ![Videos](https://www.youtube.com/watch?v=-BktJspJKgs&list=PLzwMdS5iu_BIsO6RTy7Hy1MbzLMrQE2xe)
  - 💬 Would You like to get in touch with me? Or if You have any questions, suggestions or problems?
  - 📫 Then You can create an ![issue](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/issues) here on GitHub or You can contact me via my ![contact form](https://cryinkfly.com/contact/)!
  - 📜 Code of Conduct: Contributor Covenant
  - 📖 Information for contributors: All contribution information, Compilation instructions, Roadmap
  - ❤️ I'd like to thank everyone who has ![helped]((https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/SPONSORS.md)) me to get Fusion 360 up and running on Linux!

---

## Screenshots
<div>
<img src="https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/images/production/%231.1_adapter-plate.png" width="300px" height="200px">
<img src="https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/images/generative-design/%231.4_generative_design.png" width="300px" height="200px">
</div>
<div>
<img src="https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/images/rendering/%231_water_pump.png" width="300px" height="200px">
<img src="https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/images/simulation/%231_study_displacement.png" width="300px" height="200px">
</div>

---

## Downloads

There are some ![script releases](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/tree/main/scripts) available, built from the release targets. (Still in Progress!)

It's recommended that if you're new you start with the stable builds. Nightly builds are available every day from the v1.x branch here if you need it, but correspondingly may be less stable. (Still in Progress!)

---

# README-FILE: STILL IN PROGRESS!!!

---

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

##### You must install Autodesk Fusion 360 itself, because my script doesn't work correctly at the moment!

1.) Look into my file [fusion360-install.sh](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-install.sh) and install the the minimum requirements!

2.) Install Flatpak on your system: https://flatpak.org/setup/ (More information about FLatpak: https://youtu.be/SavmR9ZtHg0)

3.) Download my scripts: [Installation-Script](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-flatpak-install.sh) & [Start-Script](https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/scripts/fusion360-flatpak-start.sh)

2.) Follow my instructions in my files "fusion360-flatpak-install.sh" & "fusion360-flatpak-start.sh" !

*Notice: Check if you have installed the newest graphics driver on your system!

________________________________________________________________________________________________


## Which work areas and functions can You use:

<table>
<thead>
<tr>
<th></th>
<th>Windows</th>
<th>macOS</th>
<th>Linux</th>
</tr>
</thead>
<tbody>
<tr>
<td>Construction</td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<tr>
<td>Animation</td>
<td><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
</tr>
<tr>
<td>Rendering</td>
<td><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
</tr>
<tr>
<td>Production</td>
<td><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
</tr>
<tr>
<td>Simulation</td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
</tr>
<tr>
<td>Generative Design</td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
</tr>
<tr>
<td>Documentation</td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td><g-emoji class="g-emoji" alias="heavy_multiplication_x" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2716.png"><img class="emoji" alt="heavy_multiplication_x" src="https://github.githubassets.com/images/icons/emoji/unicode/2716.png" width="20" height="20"></g-emoji></td>
</tr>
<tr>
<td>Online- & Offline-Mode</td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
</tr>
</tbody>
</table>

---

#### If you use Wine under XWayland, you can activate the option for "Emulating a virtual desktop" in the Graphics Tab in winecfg, to avoid problems with:

- flickering
- wrong window location
- wrong mouse cursor location and clicks
- keyboard detection

---

##### Super Application Maintainer (WineHQ): https://appdb.winehq.org/objectManager.php?sClass=application&iId=15617
- @cryinkfly (Administrator & Project Manager)

