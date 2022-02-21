#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Setup Wizard (Linux)                                         #
# Description:  With this file the language will be loaded automatically!                          #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    10:30/21.02.2022                                                                   #
# Version:      0.1                                                                                #
####################################################################################################

# Path: /$HOME/.config/fusion-360/locale/profile-locale.sh

###############################################################################################################################################################
# ALL FUNCTIONS ARE ARRANGED HERE:                                                                                                                            #
###############################################################################################################################################################

# Read a specific line from a File ($HOME/.config/fusion-360/logs/profile-locale.log)
FILE="$1"
LINE_NO=$2
i=0
while read line; do
  i=$(( i + 1 ))
  test $i = $LINE_NO && echo "$line";
done <"$FILE"
