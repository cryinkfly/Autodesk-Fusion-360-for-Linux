#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This is the Japanese translation for the Setup Wizard.                             #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    21:15/08.06.2022                                                                   #
# Version:      1.5 -> 1.6                                                                         #
####################################################################################################

# Path: /$HOME/.fusion360/locale/ja-JP/locale-ja.sh

###############################################################################################################################################################
# ALL DEFINITIONS FOR AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                                  #
###############################################################################################################################################################

# Window Title (Setup Wizard)
SP_TITLE="セットアップウィザード-AutodeskFusion360 for Linux"

# Window Title:
SP_SUBTITLE="Linux用のAutodeskFusion360インストーラへようこそ"

# Welcome Screen:
SP_WELCOME_LABEL_1="このセットアップウィザードは、Autodesk Fusion 360をコンピュータにインストールして、Linuxでプロジェクトを操作できるようにします。"
SP_WELCOME_LABEL_2="[OK]をクリックして続行するか、[キャンセル]をクリックしてセットアップウィザードを終了します。 "
SP_WELCOME_TOOLTIP_1="このセットアップウィザードの詳細については、こちらをご覧ください。"
SP_WELCOME_TOOLTIP_2="ここで、デフォルト設定を調整できます。たとえば、言語。"

###############################################################################################################################################################

# General Settings:
SP_SETTINGS_TITLE="一般設定"
SP_SETTINGS_LABEL_1="ここでは、さらに設定を調整*するオプションがあります："
SP_SETTINGS_LABEL_2="*変更を加えると、Autodesk Fusion 360のインストールに影響することに注意してください！"
SP_LOCALE_LABEL="言語"
SP_LOCALE_SELECT=$(echo "Czech,English,German,Spanish,French,Italian,Japanese,Korean,Chinese")
WP_DRIVER_LABEL="グラフィックスドライバー"
WP_DRIVER_SELECT=$(echo "DXVK,OpenGL")

# License Checkbox:
SP_LICENSE_CHECK_LABEL="利用規約を読み、同意します。"
SP_LICENSE="$SP_PATH/locale/ja-JP/license-ja.txt"

###############################################################################################################################################################

# Wineprefix Info - Autodesk Fusion 360 exist on the computer:
SP_LOGFILE_WINEPREFIX_INFO_TITLE="$SP_SUBTITLE"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_1="Autodesk Fusion 360の以前のインストールがシステムで検出されました！"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_2="したがって、続行するには、以下のオプションのいずれかを選択してください！"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_1="別の場所に新しいWineprefixを作成してください！"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_2="システム上の現在のWineprefixを修復してください！"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_3="システムから現在のWineprefixを削除してください！"

###############################################################################################################################################################

# Linux distribution - Configuration:
SP_OS_TITLE="Linuxディストリビューション-構成"
SP_OS_LABEL_1="このステップでは、Linuxディストリビューションを選択して、インストールに必要なパッケージをインストールできます。"
SP_OS_LABEL_2="Linuxディストリビューション："
SP_OS_SELECT=$(echo "Arch Linux,Debian 10,Debian 11,EndeavourOS,Fedora 35,Fedora 36,Linux Mint 19.x,Linux Mint 20.x,Manjaro Linux,openSUSE Leap 15.3,openSUSE Leap 15.4,openSUSE Tumbleweed,Red Hat Enterprise Linux 8.x,Red Hat Enterprise Linux 9.x,Solus,Ubuntu 18.04,Ubuntu 20.04,Ubuntu 22.04,Void Linux,Gentoo Linux")

###############################################################################################################################################################

# Installation Folder - Configuration:
SP_INSTALLDIR_TITLE="インストール先を選択してください"
SP_INSTALLDIR_LABEL_1="セットアップウィザードは、AutodeskFusion360を次のディレクトリにインストールします*。"
SP_INSTALLDIR_LABEL_2="ディレクトリ："
SP_INSTALLDIR_LABEL_3="*フィールドをクリックして、インストール用に別のディレクトリを選択することもできます。"

###############################################################################################################################################################

# Directory info:
SP_INSTALLDIR_INFO_TITLE="インストールディレクトリの選択-情報"
SP_INSTALLDIR_INFO_LABEL_1="危険！このディレクトリはすでに存在します！"
SP_INSTALLDIR_INFO_LABEL_2="別のディレクトリを選択してください。"

###############################################################################################################################################################

# Wine Version
SP_WINE_SETTINGS_TITLE="ワインバージョンの選択"
SP_WINE_SETTINGS_LABEL_1="ここで2つのオプションのどちらかを決定する必要があります*。"
SP_WINE_SETTINGS_LABEL_2="選択："
SP_WINE_VERSION_SELECT=$（echo "ワインバージョン（ステージング）、Wineバージョン（6.23以降）はすでにシステムにインストールされています！"）
SP_WINE_SETTINGS_LABEL_3="*選択したオプションに応じて、さらにパッケージがシステムにインストールされます！"

###############################################################################################################################################################

SP_INSTALL_PROGRESS_LABEL="AutodeskFusion360がシステムにインストールされます ..."
SP_INSTALL_PROGRESS_REFRESH_LABEL="AutodeskFusion360はこのシステムで更新されています ..."

###############################################################################################################################################################

# Extension - Configuration:
SP_EXTENSION_SELECT="選択"
SP_EXTENSION_NAME="拡張機能"
SP_EXTENSION_DESCRIPTION="説明"

SP_EXTENSION_LIST="$SP_PATH/locale/ja-JP/extensions-ja.txt"

SP_SEARCH_EXTENSION_CZECH_LOCALE_TITLE="チェコ語-ロケール-拡張機能をインストールする"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_1="拡張子が配置されているファイル*を選択してください！"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_2="ファイル："
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_3="*デフォルトでは、ダウンロードした拡張機能はダウンロードディレクトリにあります。"

###############################################################################################################################################################
# ALL DEFINITIONS FOR UNINSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

DL_TITLE="アンインストーラ-Linux用AutodeskFusion360"
DL_SUBTITLE="Linux用のAutodeskFusion360アンインストーラへようこそ"
DL_WELCOME_LABEL_1="Autodesk Fusion 360がコンピュータからアンインストールされます！"
DL_WELCOME_LABEL_2="[OK]をクリックして続行するか、[キャンセル]をクリックしてこのアンインストーラーを終了します。 "
DL_WELCOME_TOOLTIP_1="このアンインストーラーの詳細については、こちらをご覧ください。"

DL_WINEPREFIXES_DEL_INFO_TEXT="選択したWineprefixをコンピューターから削除してもよろしいですか？"
DL_WINEPREFIXES_DEL_INFO_LABEL="はい、Wineprefixですべての個人データが失われることを認識しています。"

###############################################################################################################################################################

SP_COMPLETED_TEXT="Autodesk Fusion 360がコンピュータに正常にインストールされ、セットアップされました。"
SP_COMPLETED_CHECK_LABEL="AutodeskFusion360を実行する"

###############################################################################################################################################################
# ALL DEFINITIONS FOR THE LAUNCHER OF AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                  #
###############################################################################################################################################################

UP_TITLE="Autodesk Fusion 360 for Linux-Launcher"
UP_NO_UPDATE_INFO_LABEL="新しいバージョンが見つからなかったため、Autodesk Fusion 360は最新です！"
UP_SKIP_INFO_LABEL="更新はスキップされました！Autodesk Fusion 360のバージョンをすぐに更新してください！"
UP_SKIP_UPDATE_QUESTION_LABEL="Autodesk Fusion 360アップデートの検索をスキップしてもよろしいですか？"

UP_QUESTION_LABEL="新しいバージョンがリリースされました！今すぐ更新しますか？"

UP_NO_CONNECTION_WARNING_LABEL="サーバーへの接続を確立できませんでした！新しい更新の確認はスキップされました！インターネット接続を確認してください！"

UP_PROGRESS_LABEL_1="サーバーに接続しています..."
UP_PROGRESS_LABEL_2="＃すべてのファイルを確認してください.."
UP_PROGRESS_LABEL_3="＃すべてのファイルがチェックされます！"
UP_INSTALL_UPDATE_PROGRESS_LABEL="AutodeskFusion360は新しいバージョンに更新されます ..."

###############################################################################################################################################################
###############################################################################################################################################################

SELECT="選択"
WINEPREFIXES_TYPE="ワインプレフィックスタイプ"
WINEPREFIXES_DRIVER="ワインプレフィックスドライバー"
WINEPREFIXES_DIRECTORY="ワインプレフィックスディレクトリ"
