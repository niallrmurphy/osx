#!/bin/bash

# DESCRIPTION
# Applies basic system settings.
printf "System Name: "
read SYSNAME
SYSTEM_LABEL=$SYSNAME
SYSTEM_NAME=$SYSNAME

printf "Setting system label and name...\n"
sudo scutil --set ComputerName $SYSTEM_LABEL
sudo scutil --set HostName $SYSTEM_NAME
sudo scutil --set LocalHostName $SYSTEM_NAME
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $SYSTEM_NAME

#printf "Setting default desktop image (3200x2000@300).\n"
#Sudo cp settings/default_desktop.jpg $HOME/Documents/default.jpg
