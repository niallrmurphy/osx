# .osx

function finish {
  tput sgr0
  unset IFS
}

function wait_for_keypress {
  read -n 1 -s
}

function explain_execute {
  tput setaf 3
  echo "${arg_array[0]}"
  tput sgr0
  unset IFS
  #set -x
  echo "+ ${arg_array[2]}"
  eval "${arg_array[2]}"
  rc=$?; if [[ $rc != 0 ]]; then
    tput setaf 1; echo "fail"
  else
    tput setaf 2; echo "ok"
  fi
  tput sgr0
}

function close_preferences {
  arg_array=("Close System Preferences to prevent overriding settings changes" \;
    "osascript -e 'tell application \"System Preferences\" to quit'")
  explain_execute ${arg_array[@]}
}

function go_wrong {
  arg_array=("this goes wrong" \; "false")
  explain_execute ${arg_array[@]}
}

function menu_appearances {
  arg_array=("Menu bar: show percentage" \;
    "defaults write com.apple.menuextra.battery ShowPercent -string 'YES'")
  explain_execute ${arg_array[@]}
  arg_array=("Menu bar: enable transparency" \;
    "defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool true")
  explain_execute ${arg_array[@]}
}

function misc_appearances {
  arg_array=("General: set highlight color to green" \;
  "defaults write NSGlobalDomain AppleHighlightColor -string '0.764700 0.976500 0.568600'")
  explain_execute ${arg_array[@]}
  arg_array=("General: Always show scrollbars" \;
  "defaults write NSGlobalDomain AppleShowScrollBars -string 'Always'")
  explain_execute ${arg_array[@]}
  arg_array=("General: Increase window resize speed for Cocoa applications" \;
  "defaults write NSGlobalDomain NSWindowResizeTime -float 0.001")
  explain_execute ${arg_array[@]}
  arg_array=("General: expand save panels by default" \;
  "defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true;
  defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true")
  explain_execute ${arg_array[@]}
}

function finder_appearances {
  arg_array=("Finder: Set sidebar icon size to medium" \;
  "defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2")
  explain_execute ${arg_array[@]}
}

function trackpad_preferences {
  arg_array=("Disable 'natural' scrolling" \;
  "defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false")
  explain_execute ${arg_array[@]}
  arg_array=("Tap to click for this user and for the login screen" \;
  "defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true; defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 \;
  defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true")
  explain_execute ${arg_array[@]}
  arg_array=("Trackpad: Swipe between pages with three fingers" \;
  "defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true")
  explain_execute ${arg_array[@]}
  arg_array=("Trackpad: Force Click and haptic feedback" \;
  "defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true")
  explain_execute ${arg_array[@]}
  #defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool false
  #defaults write com.apple.AppleMultitouchTrackpad ActuateDetents -bool true
  arg_array=("Trackpad: Silent clicking" \;
  "defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0")
  explain_execute ${arg_array[@]}
# defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
# defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0
# Tracking Speed
# 0: Slow
# 3: Fast
# defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5
  arg_array=("Trackpad: Enable swipe between pages" \;
  "defaults write AppleEnableSwipeNavigateWithScrolls -bool true")
  explain_execute ${arg_array[@]}
# Enable three finger drag
#defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1
#defaults write com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad -int 1")
}

function system_setup {
  arg_array=("System: TZ to Dublin" \; "sudo /usr/sbin/systemsetup -settimezone 'Europe/Dublin'")
  explain_execute ${arg_array[@]}
  arg_array=("System: Enable remote login" \; "sudo /usr/sbin/systemsetup -f -setremotelogin on")
  explain_execute ${arg_array[@]}
#  arg_array=("System: Enable VNC equivalent" \; "sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate \
#  -configure -access -on -users admin -privs -all \
#  -restart -agent")
# Warning: macos 10.14 and later only allows control if Screen Sharing is enabled through System Preferences.
  explain_execute ${arg_array[@]}
  arg_array=("System: Don't hassle user re: further Apple stuff" \; "sudo touch /var/db/.AppleSetupDone")
  explain_execute ${arg_array[@]}
}

function power_mgmt {
  # Set standby delay to 1 hour
  sudo pmset -a standbydelay 3600
}

close_preferences
wait_for_keypress
menu_appearances
wait_for_keypress
misc_appearances
wait_for_keypress
finder_appearances
wait_for_keypress
trackpad_preferences
wait_for_keypress
system_setup
wait_for_keypress
go_wrong

function os_preferences {



# Desktop: enable snap-to-grid for desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# Desktop: enable Dashboard dev mode (allows keeping widgets on the desktop)
# defaults write com.apple.dashboard devmode -bool true

# Dock: enable 2D
defaults write com.apple.dock no-glass -bool true
# Dock: position on the left
defaults write com.apple.dock orientation bottom
# Dock: use the scale effect for window minimizing
defaults write com.apple.dock mineffect scale
# Dock: make icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true
# Dock: show indicator lights for open applications
defaults write com.apple.dock show-process-indicators -bool true
# Dock: don’t animate opening applications
defaults write com.apple.dock launchanim -bool false

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder: disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Finder: empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true
# Finder: disable window and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true
# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
# defaults write com.apple.finder QuitMenuItem -bool true
# Finder: show the ~/Library folder (in OS X Lion)
chflags nohidden ~/Library

# Panels: expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# Panels: expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
# Panels: disable the “Are you sure you want to open this application?” dialog
# defaults write com.apple.LaunchServices LSQuarantine -bool false
# Panels: enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disks: avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Disks: disable TimeMachine prompts
# defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
# Disks: disable local Time Machine backups
# hash tmutil &> /dev/null && sudo tmutil disablelocal
# Disks: disable disk image verification
# defaults write com.apple.frameworks.diskimages skip-verify -bool true
# defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
# defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# ...if you really insist on using iTunes
# iTunes: make ⌘ + F focus the search input
defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add "Target Search Field" "@F"
# iTunes: disable the Ping sidebar in iTunes
defaults write com.apple.iTunes disablePingSidebar -bool true
# iTunes: disable all the other Ping stuff
defaults write com.apple.iTunes disablePing -bool true

# Security: require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Misc: enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2
# Misc: disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true
# Misc: disable Resume system-wide
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false
# Misc: only use UTF-8 in Terminal.app
# defaults write com.apple.terminal StringEncodings -array 4
# Misc: disable Dictionary results
defaults write com.apple.spotlight DictionaryLookupEnabled -bool false
# Misc: disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# Misc: disable press-and-hold for keys in favor of key repeat
# defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Misc: Set a blazingly fast keyboard repeat rate
# defaults write NSGlobalDomain KeyRepeat -int 0

# Map bottom right Trackpad corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1

# To change the frequency, open com.apple.SoftwareUpdate.plist, found
# in /Library/Preferences, and change the ScheduleFrequency key from 7
# to the number of days you prefer.
}

trap finish EXIT
