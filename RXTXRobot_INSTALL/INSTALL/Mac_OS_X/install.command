#!/bin/bash

# RXTXRobot Mac OS X Installation Script
# Written by Christopher King
# Overhauled by Candie Solis 15 Feb 2015


clear
clear

# CHECKS FOR MAC OSX VERSION, RETURNING ONLY THE MAJOR RELEASE NUMBER
# EXAMPLE:  IF RUNNING MAC OSX VERSION 10.9.2, VERSION = 9
VERSION=`sw_vers -productVersion | awk -F. '{print $2}'`

# PATH STRING FOR WHERE THE RXTX SERIAL LIBRARY WILL BE STORED
SAVESPOT='/Library/Java/Extensions/librxtxSerial.jnilib'

# NAVIGATES TO PARENT DIRECTORY HOLDING THE INSTALL.COMMAND
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


echo "============================================================================"
echo "|                  RXTXRobot Installer for Mac OS X                        |"
echo "============================================================================"
echo ""
echo "                       PEACE, LOVE, AND ROBOTS!"
echo ""
echo ""
echo "This installer will prepare your system for communication with, and control"
echo "of your Robot.  Changes will be made to your system using the sudo command,"
echo "requiring you to enter your password and have administrative access."
echo ""
read -n1 -p "Do you want to continue? [Y/n] " answer
# EXTRACT ANSWER FROM CONSOLE

echo ""
# FIX PERMISSIONS ON THE FILE

case $answer in
    [Yy] ) 
        echo "Great Decision!"   
        echo ""
        echo "To continue, you must enter your password."
        echo "NOTE: It will look like you are not typing anything."
        echo "      Just type your password and hit enter."
        echo ""

        # THE FOLLOWING TWO LINES SERVE TO ENSURE THE USER ENTERS ROOT PRIVILEGE ACCESS
        # CREDENTIALS AND THAT THE SYSTEM CAN GENERATE AND REMOVE A FILE 
        sudo touch aRandomFile
        sudo rm aRandomFile
        echo ""

        # IF USER FAILS TO AUTHENTICATE ROOT ACCESS
        if [ "$?" -ne 0 ]
        then
            echo "Password Authentication failed.  Please rerun this installer."
            exit
        fi

        # IF USER AUTHENTICATES ROOT ACCESS
        echo -e "Access was granted successfully!  Continuing..."

        echo  "Installing Java libraries........."

        # SELECT APPROPRIATE JAVA NATIVE INSTALLATION OF THE RXTX LIBRARIES 
        # CORRESPONDING TO THE JAVA VERSION USED BY THE EXISTING MAC OS VERSION
        
        if [ $VERSION -lt 5 ]
        then
            JFILE="$SCRIPTDIR/libs/less_leopard.jnilib"
        elif [ $VERSION -eq 5 ] || [ $VERSION -eq 6 ]
        then
            JFILE="$SCRIPTDIR/libs/leop_snow.jnilib"
        elif [ $VERSION -eq 7 ]
        then
            JFILE="$SCRIPTDIR/libs/mnt_lion.jnilib"
        elif [ $VERSION -gt 7 ]
        then
            JFILE="$SCRIPTDIR/libs/yosemite.jnilib"
        else
            echo "ERROR!"
            echo "FATAL ERROR: Your Mac OS is not supported."
            echo "You have Mac OSX $(sw_vers -productVersion) and this installer only"
            echo "supports Mac OSX 10.0.x - 10.10.x"
            echo ""
            exit
        fi

        # IF THE JFILE (.jnilib) IS NOT FOUND IN THE SCRIPT DIRECTORY
        if [ ! -f "$JFILE" ]
        then
            echo "ERROR!"
            echo "FATAL ERROR: The library file \"$JFILE\" could not be found."
            echo "Please make sure you kept the \"libs\" folder in this directory."
            echo ""
            exit
        fi
        # IF THERE ALREADY EXISTS A LIBRXTXSERIAL.JNILIB FILE IN THE JAVA EXTENSIONS 
        # DIRECTORY, REMOVE IT
        if [ -f "$SAVESPOT" ] 
        then
            sudo rm "$SAVESPOT"
        fi

        # COPY THE SELECTED JNILIB FILE FROM ABOVE INTO THE JAVA EXTENSIONS DIRECTORY
        # WITH THE APPROPRIATE NAME librxtxSerial.jnilib
        sudo cp "$JFILE" "$SAVESPOT"

        echo "Java Native RXTX Serial library has been installed."
        echo -n "Setting permissions................"

		# RECTIFYING LOCK FILE PERMISSIONS WITH MAC OSX
        curruser=`sudo id -p | grep 'login' | sed 's/login.//'`
        if [ ! -d /var/lock ]
        then
            sudo mkdir /var/lock
        fi

        sudo chgrp uucp /var/lock  &> /dev/null
        sudo chmod 775  /var/lock  &> /dev/null

        if [ $VERSION -lt 5 ]
        then
            if [ ! `sudo niutil -readprop / /groups/uucp users 2> /dev/null | grep "$curruser" &> /dev/null` ] 
            then
                sudo niutil -mergeprop / /groups/uucp users "$curruser" &> /dev/null
            fi
        else
            if [ ! `sudo dscl . -read / /groups/_uucp users 2> /dev/null | grep "$curruser" &> /dev/null` ]
            then
                sudo dscl . -append /groups/_uucp GroupMembership "$curruser" &> /dev/null
            fi
        fi

		# SETTING ACCESS PERMISSIONS FOR RXTX LIBRARY 
        sudo chown root:wheel "$SAVESPOT"
        sudo chmod 755 "$SAVESPOT"

        echo "done."  #setting perms
        echo ""
        echo "Now installing necessary drivers................"
        echo "Determining 32-bit or 64-bit....................."
        echo ""
        if [ $(uname -m) == 'x86_64' ] 
        then
            echo "Determination:  You are running a 64-bit machine!  Awesome!"
            # SERIAL DRIVERS FOR NANO (CLONE)
            XFILE="$SCRIPTDIR/libs/ch34xInstall.pkg"
        else
            echo "Determination:  You are running a 32-bit machine."
            # SERIAL DRIVERS FOR NANO (CLONE)
            XFILE="$SCRIPTDIR/libs/ch34xInstall.pkg"
        fi

        # IF DRIVER INSTALLATION FILES ARE NOT FOUND IN THE SCRIPT DIRECTORY
        if [ ! -f "$XFILE" ]
        then
            echo "FATAL ERROR: Could not find \"$XFILE\"."
            echo "Make sure the folder \"libs\" is in this directory."
            exit
        fi

        echo ""
        echo "Beginning driver installations.  Installer may appear to pause a couple of"
        echo "times.  In fact, it is working hard for your success!  Give it a minute."
        echo ""
        
        # INSTALLS THE XFILE, WHICH IS THE CH34 DRIVER FOR THE CLONE NANOS
        sudo installer -pkg "$XFILE" -target /
        
        # DISABLES THIRD PARTY DRIVER BLOCK IMPOSED BY MAC -- YES, WE KNOW, AS IS SAID
        # IN MANY PLACES -- IT'S LIKE KILLING A GNAT WITH A SLEDGE HAMMER, BUT WE HAVE
        # NO CHOICE
        sudo nvram boot-args="kext-dev-mode=1"
        
        echo ""
        echo "The driver installation has finished!"
		echo "YOU MUST RESTART NOW FOR THE INSTALLATION TO FULLY COMPLETE."
        ;;
        
	[Nn] )
        echo "Suit yourself, but your success is dependent on your ability to communicate"
    	echo "with your robot!  You may want to rethink your decision. Just saying..."
        ;;
    
    * ) echo "Bad entry detected.  Restart installer.  Watch your fingers next time!" 
        ;;
esac
exit


# THESE HAVE BEEN LEFT IN THIS FILE FOR FUTURE REFERENCE/USE BUT HAVE BEEN MOVED TO THE
# BOTTOM TO IMPROVE READABILITY
# IF 32 BIT MACHINE
# FTDI DRIVERS FOR XBEE
# XFILE="$SCRIPTDIR/libs/ftdi_x64.dmg"
# IF 64 BIT MACHINE
# FTDI DRIVERS FOR XBEE
# XFILE="$SCRIPTDIR/libs/ftdi_x86.dmg"
# XBee...
# echo "Follow the instructions to install the FTDI drivers for the XBee."
# hdiutil attach -quiet -noautoopen -nobrowse "$XFILE" 
# sleep 2
# open -W "/Volumes/FTDIUSBSerialDriver_v2_2_18/FTDIUSBSerialDriver_10_4_10_5_10_6_10_7.mpkg"
# hdiutil detach -quiet "/Volumes/FTDIUSBSerialDriver_v2_2_18"

# echo "Follow the instructions to install the drivers for the Phidget motors."
# hdiutil attach -quiet -noautoopen -nobrowse "$SCRIPTDIR/libs/Phidget.dmg" &> /dev/null
# sleep 2
# open -W "/Volumes/Phidgets21/Phidgets.mpkg"
# hdiutil detach -quiet "/Volumes/Phidgets21" &> /dev/null
# echo ""