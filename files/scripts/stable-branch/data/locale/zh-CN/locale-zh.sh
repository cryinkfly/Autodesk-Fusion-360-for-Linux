#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This is the Chinese translation for the Setup Wizard.                              #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2021                                                                          #
# Time/Date:    12:00/09.11.2021                                                                   #
# Version:      1.2                                                                                #
####################################################################################################

###############################################################################################################################################################
# ALL DEFINITIONS ARE ARRANGED HERE:                                                                                                                          #
###############################################################################################################################################################

# License-checkbox
text_license_checkbox="Wǒ yǐ yuèdú tiáokuǎn hé tiáojiàn bìng jiēshòu tāmen."

# Select
text_select="Xuǎnzé"

# Version (Standard, Flatpak or Snap)
text_version="Bǎnběn"
text_standard="Biāozhǔn"
text_flatpak="Flatpak (Shíyàn xìng de)"
text_snap="Snap (Shíyàn xìng de)"

# Driver
text_driver="Xiǎnkǎ qūdòng"

# Driver OpenGL
text_driver_opengl="OpenGL (biāozhǔn) - Rúguǒ nín bù quèdìng, qǐng xuǎnzé cǐ xuǎnxiàng!"

# Driver DXVK
text_driver_dxvk="DXVK - Rúguǒ nín shǐyòng de shì Intel GPU, qǐng xuǎnzé cǐ xuǎnxiàng!"

# Linux distribution
text_linux_distribution="Linux fāxíng bǎn"

# Installation location
text_installation_location="Ānzhuāng wèizhì"

# Installation location - Standard
text_installation_location_standard="Biāozhǔn - Jiāng Autodesk Fusion 360 ānzhuāng dào nín de zhǔ wénjiàn jiā zhōng. Lìrú: /home/username/.wineprefixes/fusion360"

# Installation location - Custom
text_installation_location_custom="Zì dìngyì - Jiāng Autodesk Fusion 360 ānzhuāng dào qítā wèizhì. Lìrú: /run/media/username/usb-drive/.wineprefixes/fusion360"

# Select a location with a file browser
text_select_location_custom="Xuǎnzé Autodesk Fusion 360 ānzhuāng wèizhì:"

# Checkbox - desktop-launcher-custom
text_desktop_launcher_custom_checkbox="Wǒ yǐjīng gēnggǎile Autodesk Fusion 360 de lùjìng!"

# Question - desktop-launcher-custom
text_desktop_launcher_custom_question="Shìfǒu yào bǎocún gēnggǎi?"

# Abort the program
text_abort="Nín zhēn de yāo zhōngzhǐ ānzhuāng ma?"

# Program-Exit
text_completed_installation="Autodesk Fusion 360 ānzhuāng wánchéng."

# Program-Exit (Extensions)
text_completed_installation_extensions="Autodesk Fusion 360 bùfèn kuòzhǎn ānzhuāng wánchéng."

# Select a option - new_modify_deinstall
text_select_option="Xuǎnxiàng"

# Option 1
text_select_option_1="Bùfèn huò suǒyǒu zǔjiàn de quánxīn ānzhuāng"

# Option 2
text_select_option_2="Gēngxīn huò xiūfù xiàn yǒu ānzhuāng"

# Option 3
text_select_option_3="Ānzhuāng, xiūfù huò xiè zǎi yīxiē kuòzhǎn"

# Option 4
text_select_option_4="Xièzài suǒyǒu Autodesk Fusion 360 zǔjiàn"

# New installation-checkbox - new_modify_deinstall
text_new_installation_checkbox="Wǒ xiànzài yǐjīng kàn dàole nǎxiē ānzhuāng lùjìng kěyòng, bìng jiàng zàixià yībù zhōng zhǐdìng bùtóng de lùjìng!"

# Edit installation-checkbox - new_modify_deinstall
text_edit_installation_checkbox="Wǒ cóng xiàn yǒu de Autodesk Fusion 360 ānzhuāng zhōng jì xià huò fùzhìle zhèngquè de lùjìng!"

# Deinstall-checkbox - new_modify_deinstall
text_deinstall_checkbox="Wǒ cóng xiàn yǒu de Autodesk Fusion 360 ānzhuāng zhōng jì xià huò fùzhìle zhèngquè de lùjìng, ránhòu zài cǐ chù shān chú liǎo cǐ lùjìng!"

# Question - Deinstall a exist Autodesk Fusion 360 installation
text_deinstall_question="Shìfǒu yào bǎocún gēnggǎi bìng shānchú zhèngquè de xiàn yǒu Autodesk Fusion 360 ānzhuāng?"

# Select a location with a file browser - new_modify_deinstall
text_select_location_deinstall="Xuǎnzé nín xiàn yǒu de Autodesk Fusion 360 ānzhuāng:"

# Program-Exit - new_modify_deinstall
text_completed_deinstallation="Autodesk Fusion 360 xièzài wánchéng."

# Select CZECH-Plugin files
text_select_czech_plugin="Xuǎnzé ānzhuāng wénjiàn:"

# No Plugin was not found
text_info_czech_plugin="Wèi xuǎnzé wénjiàn."

# Extension
text_extension="Yánqí"

# Extension Description
text_extension_description="Miáoshù"

text_extension_description_1="Cǐ kuòzhǎn chéngxù kě bāngzhù nín yōuhuà bàolù yú yídòng qìtǐ huò yètǐ de rènhé shìwù huò bùjiàn. Lìrú: Jī yì, qí, luóxuánjiǎng hé wōlúnjī."
text_extension_description_2="Cǐ kuòzhǎn tōngguò fèn xī shèjì de duō gè fāngmiàn wèi nín tígōng bāngzhù, bìng tígōng yǒuguān rúhé tígāo língjiàn kě zhìzào xìng de míngquè fǎnkuì."
text_extension_description_3="Cǐ kuòzhǎn shǐ nín kěyǐ xuǎnzé zài Autodesk Fusion 360 zhōng shǐyòng jiékè yǔ yònghù jièmiàn (UI)."
text_extension_description_4="Cǐ kuòzhǎn shì Autodesk Fusion 360 hé HP SmartStream ruǎnjiàn zhī jiān de liánjiē qì, yòng yú jiāng zuòyè zhíjiē fāsòng dào HP ruǎnjiàn."
text_extension_description_5="Shǐyòng cǐ kuòzhǎn chéngxù, nín kěyǐ tōngguò Autodesk Fusion 360 jiāng chuàngjiàn de 3D móxíng de G dàimǎ zhíjiē fāsòng dào OctoPrint fúwùqì."
text_extension_description_6="Cǐ kuòzhǎn yǔnxǔ nín zhíjiē cóng Autodesk Fusion 360 duì 50 duō gè bùtóng de jīqìrén zhìzào shāng hé 500 gè jīqìrén jìnxíng biānchéng."

# Error
text_error="Yīgè yìliào zhī wài de wèntí fāshēngle!"

