#!/bin/bash

####################################################################################################
# Name:         Autodesk Fusion 360 - Cronjob for Update (Linux)                                   #
# Description:  This file checks whether there is a newer version of Autodesk Fusion 360.          #
# Author:       Steve Zabka                                                                        #
# Author URI:   https://cryinkfly.com                                                              #
# License:      MIT                                                                                #
# Copyright (c) 2020-2022                                                                          #
# Time/Date:    15:00/16.02.2022                                                                   #
# Version:      0.0.2                                                                              #
####################################################################################################

###############################################################################################################################################################
# ALL LOG-FUNCTIONS ARE ARRANGED HERE:                                                                                                                        #
###############################################################################################################################################################

# I will change this value as soon as a new version of Autodesk Fusion 360 is available. 
# A value of 0 means that there is no update and a value of 1 will notify the user that there is an update.
get_update=0

# Checks the current day of the week so that the update can be performed.
# %u day of week (1..7); 1 is Monday.

# The update runs on Monday, Wednesday and Friday.
function setupact-check  {
pc_date=$(date +%u)
if [ $pc_date -eq 1 ]; then
    # echo "Monday"
elif [ $pc_date -eq 3 ]; then
    # echo "Wednesday"
elif [ $pc_date -eq 5 ]; then
    # echo "Friday"
else    
    # echo "Do nothing!"
fi
}

# Still  in  Progress!
