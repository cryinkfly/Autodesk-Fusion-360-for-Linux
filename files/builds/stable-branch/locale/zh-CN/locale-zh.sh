#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This is the Chinese translation for the Setup Wizard.                              #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2024                                                                          #
# Time/Date:    16:00/05.02.2024                                                                   #
# Version:      1.6.3                                                                              #
####################################################################################################

# Path: /$HOME/.fusion360/locale/zh-CN/locale-zh.sh

###############################################################################################################################################################
# ALL DEFINITIONS FOR AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                                  #
###############################################################################################################################################################

# Window Title (Setup Wizard)
SP_TITLE="设置向导 - Autodesk Fusion 360 for Linux"

# Window Title:
SP_SUBTITLE="欢迎使用适用于 Linux 的 Autodesk Fusion 360 安装程序"

# Welcome Screen:
SP_WELCOME_LABEL_1="此安装向导会在您的计算机上安装 Autodesk Fusion 360，以便您也可以在 Linux 上处理您的项目。"
SP_WELCOME_LABEL_2="单击确定以继续或单击取消以退出设置向导。"
SP_WELCOME_TOOLTIP_1="您可以在此处获得有关此设置向导的更多信息。"
SP_WELCOME_TOOLTIP_2="您可以在此处调整默认设置。例如语言。"

###############################################################################################################################################################

# General Settings:
SP_SETTINGS_TITLE="常规设置"
SP_SETTINGS_LABEL_1="在这里您可以选择调整*进一步的设置："
SP_SETTINGS_LABEL_2="*请记住，任何更改都会影响 Autodesk Fusion 360 的安装！"
SP_LOCALE_LABEL="语言"
SP_LOCALE_SELECT=$(echo "Czech,English,German,Spanish,French,Italian,Japanese,Korean,Chinese")
WP_DRIVER_LABEL="图形驱动程序"
WP_DRIVER_SELECT=$(echo "DXVK,OpenGL")

# License Checkbox:
SP_LICENSE_CHECK_LABEL="我已阅读条款和条件并接受。"
SP_LICENSE="$SP_PATH/locale/zh-CN/license-zh.txt"

###############################################################################################################################################################

# Wineprefix Info - Autodesk Fusion 360 exist on the computer:
SP_LOGFILE_WINEPREFIX_INFO_TITLE="$SP_SUBTITLE"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_1="已在您的系统上检测到以前安装的 Autodesk Fusion 360！"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_2="因此，请选择以下选项之一继续！"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_1="在不同的位置创建一个新的 Wineprefix！"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_2="修复系统上的当前 Wineprefix！"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_3="从您的系统中删除当前的 Wineprefix！"

###############################################################################################################################################################

# Linux distribution - Configuration:
SP_OS_TITLE="Linux 发行版 - 配置"
SP_OS_LABEL_1="在此步骤中，您现在可以选择您的 Linux 发行版来安装安装所需的软件包。"
SP_OS_LABEL_2="Linux 发行版："
SP_OS_SELECT=$(echo "Arch Linux,Debian 11,Debian 12, Debian Testing,EndeavourOS,Fedora 38,Fedora 39,Fedora Rawhide,Linux Mint 20.x,Linux Mint 21.x,Linux Mint 5.x - LMDE Version,Manjaro Linux,openSUSE Leap 15.4,openSUSE Leap 15.5,openSUSE Tumbleweed,Red Hat Enterprise Linux 8.x,Red Hat Enterprise Linux 9.x,Solus,Ubuntu 20.04,Ubuntu 22.04,Ubuntu 23.10,Void Linux,Gentoo Linux")

###############################################################################################################################################################

# Installation Folder - Configuration:
SP_INSTALLDIR_TITLE="选择安装目标"
SP_INSTALLDIR_LABEL_1="安装向导会将 Autodesk Fusion 360 安装到以下目录*。"
SP_INSTALLDIR_LABEL_2="目录："
SP_INSTALLDIR_LABEL_3="*您还可以通过单击该字段来选择不同的安装目录。"

###############################################################################################################################################################

# Directory info:
SP_INSTALLDIR_INFO_TITLE="选择安装目录 - 信息"
SP_INSTALLDIR_INFO_LABEL_1="危险！该目录已经存在！"
SP_INSTALLDIR_INFO_LABEL_2="请选择其他目录。"

###############################################################################################################################################################

# Wine Version
SP_WINE_SETTINGS_TITLE="选择葡萄酒版本"
SP_WINE_SETTINGS_LABEL_1="你必须在两个选项之间做出决定*。"
SP_WINE_SETTINGS_LABEL_2="选择："
SP_WINE_VERSION_SELECT=$(echo "葡萄酒版（分期）,Wine 版本（8.14 或更高版本）已安装在系统上！")
SP_WINE_SETTINGS_LABEL_3="*根据选择的选项，您的系统上将安装更多软件包！"

###############################################################################################################################################################

SP_INSTALL_PROGRESS_LABEL="Autodesk Fusion 360 将安装在您的系统上 ..."
SP_INSTALL_PROGRESS_REFRESH_LABEL="Autodesk Fusion 360 正在此系统上更新 ..."

###############################################################################################################################################################

# Extension - Configuration:
SP_EXTENSION_SELECT="选择"
SP_EXTENSION_NAME="分机"
SP_EXTENSION_DESCRIPTION="描述"

SP_EXTENSION_LIST="$SP_PATH/locale/zh-CN/extensions-zh.txt"

SP_SEARCH_EXTENSION_CZECH_LOCALE_TITLE="安装捷克语区域设置扩展"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_1="选择扩展名所在的文件*！"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_2="文件："
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_3="*默认情况下，您会在下载目录中找到下载的扩展程序。"

###############################################################################################################################################################
# ALL DEFINITIONS FOR UNINSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

DL_TITLE="卸载程序 - 适用于 Linux 的 Autodesk Fusion 360"
DL_SUBTITLE="欢迎使用适用于 Linux 的 Autodesk Fusion 360 卸载程序"
DL_WELCOME_LABEL_1="Autodesk Fusion 360 将从您的计算机上卸载！"
DL_WELCOME_LABEL_2="单击确定继续或取消退出此卸载程序。"
DL_WELCOME_TOOLTIP_1="您可以在此处获得有关此卸载程序的更多信息。"

DL_WINEPREFIXES_DEL_INFO_TEXT="您确定要从您的计算机中删除选定的 Wineprefix 吗？"
DL_WINEPREFIXES_DEL_INFO_LABEL="是的，我知道我的所有个人数据都将在 Wineprefix 中丢失。"

###############################################################################################################################################################

SP_COMPLETED_TEXT="Autodesk Fusion 360 已在您的计算机上成功安装和设置。"
SP_COMPLETED_CHECK_LABEL="运行 Autodesk Fusion 360"

###############################################################################################################################################################
# ALL DEFINITIONS FOR THE LAUNCHER OF AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                  #
###############################################################################################################################################################

UP_TITLE="Autodesk Fusion 360 for Linux - 启动器"
UP_NO_UPDATE_INFO_LABEL="未找到更新版本，因此您的 Autodesk fusion 360 是最新的！"
UP_SKIP_INFO_LABEL="更新被跳过！ 请考虑下次检查更新。"
UP_SKIP_UPDATE_QUESTION_LABEL="您确定要跳过搜索 Autodesk Fusion 360 更新吗？"

UP_QUESTION_LABEL="新版本已发布！您要立即更新吗？"

UP_NO_CONNECTION_WARNING_LABEL="无法建立与服务器的连接！已跳过检查新更新！请检查您的互联网连接！"

UP_WANT_TO_CHECK_FOR_UPDATES="您想在启动之前检查 Fusion 360 的更新吗？"

UP_INSTALL_UPDATE_PROGRESS_LABEL="Autodesk Fusion 360 将更新到更新版本 ..."

###############################################################################################################################################################
###############################################################################################################################################################

SELECT="选择"
WINEPREFIXES_TYPE="葡萄酒前缀类型"
WINEPREFIXES_DRIVER="Wineprefixes 驱动程序"
WINEPREFIXES_DIRECTORY="Wineprefixes 目录"
