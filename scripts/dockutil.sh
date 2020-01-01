#!/bin/bash  
DOCKUTIL=/usr/local/bin/dockutil
$DOCKUTIL --remove all --no-restart
$DOCKUTIL --add '/Applications/Google Chrome.app' --no-restart
$DOCKUTIL --add '/Applications/Safari.app' --no-restart
$DOCKUTIL --add '/Applications/Firefox.app' --no-restart
$DOCKUTIL --add '/Applications' --no-restart
$DOCKUTIL --add '~/Downloads'
$DOCKUTIL --add '/Applications/Adobe Lightroom Classic/Adobe Lightroom Classic.app'
$DOCKUTIL --add '/System/Applications/System Preferences.app/'
$DOCKUTIL --move 'System Preferences' --position 2
