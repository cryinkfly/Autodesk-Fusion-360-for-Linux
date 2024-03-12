#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  This is the Korean translation for the Setup Wizard.                              #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2024                                                                          #
# Time/Date:    16:00/05.02.2024                                                                   #
# Version:      1.6.3                                                                              #
####################################################################################################

# Path: /$HOME/.fusion360/locale/ko-KR/locale-ko.sh

###############################################################################################################################################################
# ALL DEFINITIONS FOR AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                                  #
###############################################################################################################################################################

# Window Title (Setup Wizard)
SP_TITLE="설정 마법사 - Linux용 Autodesk Fusion 360"

# Window Title:
SP_SUBTITLE="Linux용 Autodesk Fusion 360 설치 프로그램에 오신 것을 환영합니다."

# Welcome Screen:
SP_WELCOME_LABEL_1="이 설치 마법사는 컴퓨터에 Autodesk Fusion 360을 설치하므로 Linux에서도 프로젝트 작업을 할 수 있습니다."
SP_WELCOME_LABEL_2="계속하려면 확인을 클릭하고 설정 마법사를 종료하려면 취소를 클릭하십시오."
SP_WELCOME_TOOLTIP_1="여기에서 이 설정 마법사에 대한 자세한 정보를 얻을 수 있습니다."
SP_WELCOME_TOOLTIP_2="여기에서 기본 설정을 조정할 수 있습니다. 예를 들어 언어."

###############################################################################################################################################################

# General Settings:
SP_SETTINGS_TITLE="일반 설정"
SP_SETTINGS_LABEL_1="여기에서 추가 설정을 조정할 수 있는* 옵션이 있습니다."
SP_SETTINGS_LABEL_2="*변경 사항은 Autodesk Fusion 360 설치에 영향을 미칩니다."
SP_LOCALE_LABEL="언어"
SP_LOCALE_SELECT=$(echo "Czech,English,German,Spanish,French,Italian,Japanese,Korean,Chinese")
WP_DRIVER_LABEL="그래픽 드라이버"
WP_DRIVER_SELECT=$(echo "DXVK,OpenGL")

# License Checkbox:
SP_LICENSE_CHECK_LABEL="이용약관을 읽었으며 이에 동의합니다."
SP_LICENSE="$SP_PATH/locale/ko-KR/license-ko.txt"

###############################################################################################################################################################

# Wineprefix Info - Autodesk Fusion 360 exist on the computer:
SP_LOGFILE_WINEPREFIX_INFO_TITLE="$SP_SUBTITLE"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_1="시스템에서 Autodesk Fusion 360의 이전 설치가 감지되었습니다!"
SP_LOGFILE_WINEPREFIX_INFO_LABEL_2="그러므로 계속하려면 아래 옵션 중 하나를 선택하십시오!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_1="다른 위치에 새 Wineprefix를 만드십시오!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_2="시스템에서 현재 Wineprefix를 복구하십시오!"
SP_LOGFILE_WINEPREFIX_INFO_TOOLTIP_3="시스템에서 현재 Wineprefix를 제거하십시오!"

###############################################################################################################################################################

# Linux distribution - Configuration:
SP_OS_TITLE="Linux 배포 - 구성"
SP_OS_LABEL_1="이 단계에서는 이제 Linux 배포판을 선택하여 설치에 필요한 패키지를 설치할 수 있습니다."
SP_OS_LABEL_2="Linux 배포판:"
SP_OS_SELECT=$(echo "Arch Linux,Debian 11,Debian 12, Debian Testing,EndeavourOS,Fedora 38,Fedora 39,Fedora Rawhide,Linux Mint 20.x,Linux Mint 21.x,Linux Mint 5.x - LMDE Version,Manjaro Linux,openSUSE Leap 15.4,openSUSE Leap 15.5,openSUSE Tumbleweed,Red Hat Enterprise Linux 8.x,Red Hat Enterprise Linux 9.x,Solus,Ubuntu 20.04,Ubuntu 22.04,Ubuntu 23.10,Void Linux,Gentoo Linux")

###############################################################################################################################################################

# Installation Folder - Configuration:
SP_INSTALLDIR_TITLE="설치 대상 선택"
SP_INSTALLDIR_LABEL_1="설치 마법사는 Autodesk Fusion 360을 다음 디렉토리*에 설치합니다."
SP_INSTALLDIR_LABEL_2="디렉토리:"
SP_INSTALLDIR_LABEL_3="*필드를 클릭하여 설치할 다른 디렉토리를 선택할 수도 있습니다."

###############################################################################################################################################################

# Directory info:
SP_INSTALLDIR_INFO_TITLE="설치 디렉토리 선택 - 정보"
SP_INSTALLDIR_INFO_LABEL_1="위험! 이 디렉토리는 이미 존재합니다!"
SP_INSTALLDIR_INFO_LABEL_2="다른 디렉토리를 선택하십시오."

###############################################################################################################################################################

# Wine Version
SP_WINE_SETTINGS_TITLE="와인 버전 선택"
SP_WINE_SETTINGS_LABEL_1="여기서 두 가지 옵션* 중에서 결정해야 합니다."
SP_WINE_SETTINGS_LABEL_2="선택:"
SP_WINE_VERSION_SELECT=$(echo "와인 버전(스테이징),Wine 버전(8.14 이상)이 이미 시스템에 설치되어 있습니다!")
SP_WINE_SETTINGS_LABEL_3="*선택한 옵션에 따라 시스템에 추가 패키지가 설치됩니다!"

###############################################################################################################################################################

SP_INSTALL_PROGRESS_LABEL="Autodesk Fusion 360이 시스템에 설치됩니다 ..."
SP_INSTALL_PROGRESS_REFRESH_LABEL="Autodesk Fusion 360이 이 시스템에서 업데이트 중입니다 ..."

###############################################################################################################################################################

# Extension - Configuration:
SP_EXTENSION_SELECT="선택"
SP_EXTENSION_NAME="확장"
SP_EXTENSION_DESCRIPTION="설명"

SP_EXTENSION_LIST="$SP_PATH/locale/ko-KR/extensions-ko.txt"

SP_SEARCH_EXTENSION_CZECH_LOCALE_TITLE="체코-로케일-확장 프로그램 설치"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_1="확장자가 있는 파일*을 선택하세요!"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_2="파일:"
SP_SEARCH_EXTENSION_CZECH_LOCALE_LABEL_3="*기본적으로 다운로드한 확장 프로그램은 다운로드 디렉토리에서 찾을 수 있습니다."

###############################################################################################################################################################
# ALL DEFINITIONS FOR UNINSTALL AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                        #
###############################################################################################################################################################

DL_TITLE="제거 프로그램 - Linux용 Autodesk Fusion 360"
DL_SUBTITLE="Linux용 Autodesk Fusion 360 설치 제거 프로그램에 오신 것을 환영합니다."
DL_WELCOME_LABEL_1="Autodesk Fusion 360이 컴퓨터에서 제거됩니다!"
DL_WELCOME_LABEL_2="계속하려면 확인을 클릭하고 이 제거 프로그램을 종료하려면 취소를 클릭하십시오."
DL_WELCOME_TOOLTIP_1="여기에서 이 제거 프로그램에 대한 추가 정보를 얻을 수 있습니다."

DL_WINEPREFIXES_DEL_INFO_TEXT="선택한 Wineprefix를 컴퓨터에서 삭제하시겠습니까?"
DL_WINEPREFIXES_DEL_INFO_LABEL="예, 내 모든 개인 데이터가 Wineprefix에서 손실된다는 것을 알고 있습니다."

###############################################################################################################################################################

SP_COMPLETED_TEXT="Autodesk Fusion 360이 컴퓨터에 성공적으로 설치 및 설정되었습니다."
SP_COMPLETED_CHECK_LABEL="Autodesk Fusion 360 실행"

###############################################################################################################################################################
# ALL DEFINITIONS FOR THE LAUNCHER OF AUTODESK FUSION 360 ARE ARRANGED HERE:                                                                                  #
###############################################################################################################################################################

UP_TITLE="Linux용 Autodesk Fusion 360 - 실행기"
UP_NO_UPDATE_INFO_LABEL="최신 버전을 찾을 수 없으므로 Autodesk fusion 360이 최신 상태입니다!"
UP_SKIP_INFO_LABEL="업데이트를 건너뛰었습니다! 다음 번에는 업데이트를 확인해 보세요."
UP_SKIP_UPDATE_QUESTION_LABEL="Autodesk Fusion 360 업데이트 검색을 건너뛰시겠습니까?"

UP_QUESTION_LABEL="새 버전이 출시되었습니다! 지금 업데이트하시겠습니까?"

UP_NO_CONNECTION_WARNING_LABEL="서버에 연결할 수 없습니다! 새 업데이트 확인을 건너뛰었습니다! 인터넷 연결을 확인하십시오!"

UP_WANT_TO_CHECK_FOR_UPDATES="Fusion 360을 출시하기 전에 업데이트를 확인하시겠습니까?"

UP_INSTALL_UPDATE_PROGRESS_LABEL="Autodesk Fusion 360이 최신 버전으로 업데이트됩니다 ..."

###############################################################################################################################################################
###############################################################################################################################################################

SELECT="선택"
WINEPREFIXES_TYPE="와인프리픽스 유형"
WINEPREFIXES_DRIVER="와인프리픽스 드라이버"
WINEPREFIXES_DIRECTORY="와인프리픽스 디렉토리"
