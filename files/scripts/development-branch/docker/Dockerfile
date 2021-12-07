####################################################################################################
# Name:         Autodesk Fusion 360 - Dockerfile                                                   #
# Description:  With this file you get Autodesk Fusion 360 to work on diffent systems via Docker.  #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2021                                                                          #
# Time/Date:    14:00/07.12.2021                                                                   #
# Version:      0.0.1                                                                              #
####################################################################################################

###############################################################################################################################################################
# DESCRIPTION IN DETAIL                                                                                                                                       #
###############################################################################################################################################################
#                                                                                                                                                             #
# STILL IN PROGRESS!!!                                                                                                                                        #
#                                                                                                                                                             #
###############################################################################################################################################################

# STILL IN PROGRESS!!!

# Basis-Image:
FROM opensuse/leap:15.3 
# Information about the author of this Dockerfile:
MAINTAINER Steve Zabka <info@cryinkfly.de> 

# Update the system.
RUN zypper up -y && \
    zypper rr https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.3/ wine && \
    zypper ar -cfp 95 https://download.opensuse.org/repositories/Emulators:/Wine/openSUSE_Leap_15.3/ wine | echo 'a' && \
    zypper install -y p7zip p7zip-full curl wget wine winetricks samba cabextract wget zenity
