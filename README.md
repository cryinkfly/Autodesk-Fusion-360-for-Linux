![banner-fusion360](https://user-images.githubusercontent.com/79079633/127371623-6b50b591-1b12-466d-9c96-b5b6d6314f31.png)

![GitHub last commit](https://img.shields.io/github/last-commit/cryinkfly/Fusion-360---Linux-Wine-Version-?style=for-the-badge)
![GitHub issues](https://img.shields.io/github/issues-raw/cryinkfly/Fusion-360---Linux-Wine-Version-?style=for-the-badge)
![GitHub Repo stars](https://img.shields.io/github/stars/cryinkfly/Fusion-360---Linux-Wine-Version-?style=for-the-badge)
![GitHub forks](https://img.shields.io/github/forks/cryinkfly/Fusion-360---Linux-Wine-Version-?style=for-the-badge)
![GitHub](https://img.shields.io/github/license/cryinkfly/Fusion-360---Linux-Wine-Version-?style=for-the-badge)

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

  - 📂 Downloads: 
<a href="https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/tree/main/scripts/stable-branch">Stable</a> and <a href="https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/tree/main/scripts/development-branch">development builds</a>
  - 📔 Documentation: <a href="https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/wiki/Documentation">GitHub-Documentation</a> & <a href="https://www.youtube.com/watch?v=-BktJspJKgs&list=PLzwMdS5iu_BIsO6RTy7Hy1MbzLMrQE2xe">Videos</a>
  - 💬 Would You like to get in touch with me? Or if You have any questions, suggestions or problems?
  - 📫 Then You can create an <a href="https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/issues">issue</a> here on GitHub or You can contact me via my <a href="https://cryinkfly.com/contact/">contact form</a>!
  - 📜 Code of Conduct: Contributor Covenant (Still in Progress!)
  - 📖 Information for contributors: All contribution information, Compilation instructions, Roadmap (Still in Progress!)
  - ❤️ I'd like to thank everyone who has <a href="https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/COMMUNITY.md">helped</a> me to get Fusion 360 up and running on Linux!
  - 🍷 Super Application Maintainer (WineHQ): https://appdb.winehq.org/objectManager.php?sClass=application&iId=15617

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
<div>
<img src="https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/images/drawing/drawing_bearing.png" width="300px" height="200px">
<img src="https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/images/electronics/%231.1_electronics_library.png" width="300px" height="200px">
</div>

---

## Downloads

There are some <a href="https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/tree/main/scripts">script releases</a> available, built from the release targets.

It's recommended that if you're new you start with the stable builds. Development builds are available here if you need it, but correspondingly may be less stable.

---

## Hardware and Software Requirements

- Internet connection (Cable/DSL speeds recommended)!
- Latest graphics driver, see <a href="https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/wiki/Supported-Graphics-Cards">here</a>!
- The script fails silently on some Linux distributions if the package „dialog" isn't installed!
- My script install some packages (dialog, p7zip, p7zip-full, p7zip-rar, curl, wget, winbind, cabextract, wine, wine-mono, wine_gecko, winetricks, ...)!
- Supported Linux distributions:

![supported_os](https://user-images.githubusercontent.com/79079633/128761122-8260b019-dca5-476f-9946-4d5b72e5a6f5.png)


---

## Getting Started

Install Fusion 360 for Linux client:

1.) Check my <a href="https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/wiki/Documentation">GitHub-Documentation</a> & <a href="https://www.youtube.com/watch?v=-BktJspJKgs&list=PLzwMdS5iu_BIsO6RTy7Hy1MbzLMrQE2xe">Videos</a> before you install Autodesk Fusion 360 on your system!

2.) Open a terminal and run this command:

    cd Downloads && wget -N https://raw.githubusercontent.com/cryinkfly/Fusion-360---Linux-Wine-Version-/main/scripts/stable-branch/fusion360-install.sh && chmod +x fusion360-install.sh && bash fusion360-install.sh && exit

3.) Now, You can <a href="https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/issues/44#issuecomment-890552181">use</a> Autodesk Fusion 360 on your Linux system!

---

## Which work areas and functions have I tested:

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
<td>Drawing</td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
</tr>
<tr>
<td>Electronics</td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
</tr>
<tr>
<td>Online- & Offline-Mode</td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
</tr>
<tr>
<td>Scripts and additional modules <a href="https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/videos/design/%232_create_gear_with_scripts_and_additional_modules.mov">(Create a spur gear (Python))</a></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
</tr>
<tr>
<td><a href="https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/tree/main/docs/plugins-for-fusion360/octoPrint">OctoPrint for Autodesk® Fusion 360™ (Fusion 360 Apps)</a></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
<td style="text-align: center;"><g-emoji class="g-emoji" alias="heavy_check_mark" fallback-src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png"><img class="emoji" alt="heavy_check_mark" src="https://github.githubassets.com/images/icons/emoji/unicode/2714.png" width="20" height="20"></g-emoji></td>
</tr>
</tbody>
</table>

---

## Important Notice

With the help of my script, You get a way to install Autodesk Fusion 360 on your Linux system. 

Certain packages and programs that are required will be set up for You, but it's important to know, that my script only helps You to get the program to run and nothing more! 

And so, You must to purchase the licenses directly from the manufacturer of the program Autodesk Fusion 360!

---

## License

All my scripts are released under the MIT license, see <a href="https://github.com/cryinkfly/Fusion-360---Linux-Wine-Version-/blob/main/LICENSE.md">LICENSE.md</a> for full text.





