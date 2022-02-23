#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This is the Chinese translation for the Setup Wizard.                              #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    16:30/23.02.2022                                                                   #
# Version:      1.5                                                                                #
####################################################################################################

# Path: /$HOME/.config/fusion-360/locale/zh-CN/locale-zh.sh

###############################################################################################################################################################
# ALL DEFINITIONS FOR INSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                          #
###############################################################################################################################################################

# License-checkbox
text_license_checkbox="我已阅读条款和条件并接受。"

###############################################################################################################################################################

# Select
text_select="选择"

###############################################################################################################################################################

# Linux distribution
text_linux_distribution="Linux 发行版"

###############################################################################################################################################################

# Installation location
text_installation_location="安装位置"

# Select a location with a file browser
text_select_location_custom="为您的 Autodesk Fusion 360 安装选择一个位置："

# Installation location - Standard
text_installation_location_standard="标准 - 将 Autodesk Fusion 360 安装到您的主文件夹中。例如：/home/username/.wineprefixes/fusion360"

# Installation location - Custom
text_installation_location_custom="自定义 - 将 Autodesk Fusion 360 安装到其他位置。例如：/run/media/username/usb-drive/.wineprefixes/fusion360"

###############################################################################################################################################################

# Driver
text_driver="显卡驱动"

# Driver DXVK
text_driver_dxvk="DXVK 支持 DirectX 9, 10, ... (默认)"

# Driver OpenGL
text_driver_opengl="OpenGL（后备）"

###############################################################################################################################################################

# Wine Version
text_wine_version="葡萄酒版"
text_wine_version_staging="葡萄酒版（暂存）"
text_wine_version_exists="Wine 版本（6.23 或更高版本）已安装在系统上！"

###############################################################################################################################################################

# Select a option - new_modify_deinstall
text_select_option="选项"

# Option 1
text_select_option_1="部分或全部组件的新安装"

# Option 2
text_select_option_2="更新或修复现有安装"

# Option 3
text_select_option_3="安装、修复或卸载某些扩展"

# Option 4
text_select_option_4="卸载所有 Autodesk Fusion 360 组件"

###############################################################################################################################################################

# New installation-checkbox - new_modify_deinstall
text_new_installation_checkbox="我现在已经看到有哪些安装路径可用，下一步将指定不同的路径！"

# Edit installation-checkbox - new_modify_deinstall
text_edit_installation_checkbox="我从现有的 Autodesk Fusion 360 安装中记下或复制了正确的路径！"

# Deinstall-checkbox - new_modify_deinstall
text_deinstall_checkbox="我从现有的 Autodesk Fusion 360 安装中记下或复制了正确的路径，然后在此处删除了该路径！"

# Question - Deinstall a exist Autodesk Fusion 360 installation
text_deinstall_question="是否要保存更改并删除正确的现有 Autodesk Fusion 360 安装？"

# Select a location with a file browser - new_modify_deinstall
text_select_location_deinstall="选择您现有的 Autodesk Fusion 360 安装："

# Program-Exit - new_modify_deinstall
text_completed_deinstallation="Autodesk Fusion 360 的卸载完成。"

###############################################################################################################################################################

# Extension
text_extension="扩展"

# Extension Description
text_extension_description="描述"

text_extension_description_1="此扩展帮助您优化暴露于移动气体或液体的任何事物或部件。例如：机翼、鳍、螺旋桨和涡轮机。"
text_extension_description_2="此扩展帮助您分析设计的多个方面，并就如何提高零件的可制造性提供清晰的反馈。"
text_extension_description_3="此扩展使您可以选择在 Autodesk Fusion 360 中使用捷克语用户界面 (UI)。"
text_extension_description_4="此扩展是 Autodesk® Fusion 360™ 和 HP SmartStream 软件之间的连接器，用于将作业直接发送到 HP 软件。"
text_extension_description_5="斜齿轮类似于正齿轮，齿呈一定角度。"
text_extension_description_6="使用此扩展，您可以通过 Autodesk Fusion 360 将您创建的 3D 模型的 G 代码直接发送到 OctoPrint 服务器。"
text_extension_description_7="允许用户从 CSV（逗号分隔值）文件导入/更新参数或将其导出到 CSV（逗号分隔值）文件。"
text_extension_description_8="此扩展允许您直接从 Autodesk Fusion 360 对 50 多个不同的机器人制造商和 500 个机器人进行编程。"
text_extension_description_9="此插件是 Autodesk® Fusion 360™ 与 Ultimaker Digital Factory 站点及其服务之间的连接器。"

# Select CZECH-Plugin files
text_select_czech_plugin="选择安装文件："

# No Plugin was not found
text_info_czech_plugin="未选择文件。"

# Program-Exit (Extensions)
text_completed_installation_extensions="Autodesk Fusion 360 部分扩展的安装已完成。"

###############################################################################################################################################################

# Program-Exit
text_completed_installation="Autodesk Fusion 360 安装完成。"

# Abort the program
text_abort="您真的要取消安装吗？"

# Error
text_error="发生意外错误！"

###############################################################################################################################################################
# ALL DEFINITIONS FOR UNINSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

text_uninstall_question="您确定要从系统中卸载 Autodesk Fusion 360？"
text_uninstall_cancel="卸载已中止！"

text_uninstall_checkbox="我从现有的 Autodesk Fusion 360 安装中记下/复制了正确的路径，然后在此处删除了此视图中的路径！"
text_uninstall_edit_question="您要保存更改并卸载软件吗？"
text_uninstall_path="选择您要卸载的 Autodesk Fusion 360 安装的 Wineprefix 目录！例如：/home/user/.wineprefixes/fusion360"
text_uninstall_path_select="选择 Wineprefix 目录..."

text_uninstall_completed="Autodesk Fusion 360 卸载完成。"

###############################################################################################################################################################
# ALL DEFINITIONS FOR UNINSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

text_no_update_info="未找到更新版本，因此您的 Autodesk fusion 360 是最新的！"

text_skip_update_info="已跳过更新！请尽快更新您的 Autodesk Fusion 360 版本！"
text_skip_update_question="您确定要跳过搜索 Autodesk Fusion 360 更新吗？"

text_update_question="发布了新版本！您要立即更新吗？"

text_no_connection_warning="无法建立与服务器的连接！已跳过检查新更新！请检查您的互联网连接！" 
