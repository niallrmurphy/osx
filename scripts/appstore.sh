#!/bin/bash

# DESCRIPTION
# Installs OSX Mac Store applications.

# mas signin niallm@mac.com

desired_set=(
  411643860 456877552 497799835 419330170 688211836 405399194 525912054 \
  654667344 514951692 470158793 407963104 676490829 672206759 425264550 \
  926036361 1436522307 801463932 803453959 1115348888 1012291524
)

for program in ${desired_set[@]};
  do mas install $program && echo "INSTALL SUCCESS" || echo "INSTALL FAILURE"
done
#
# mas install 411643860 # DaisyDisk
# mas install 456877552 # GeekTool
# mas install 497799835 # Xcode
# mas install 419330170 # Moom
# mas install 688211836 # Easyres
# mas install 405399194 # Kindle
# mas install 525912054 # WiFi Signal
# mas install 654667344 # The Duplicate Finder
# mas install 514951692 # NetSpot
# mas install 470158793 # Keka
# # mas install 425424353 # The Unarchiver
# mas install 407963104 # Pixelmator
# mas install 676490829 # iNetGrapher
# mas install 672206759 # Disk Diag
# mas install 425264550 # Blackmagic Disk Speed Test
# # mas install 499233976 # Cathode
# mas install 926036361 # LastPass
# # mas install 477991355 # DupeZap Plus
# mas install 1436522307 # Transmit 5
# mas install 801463932 # Stockfish
# mas install 803453959 # Slack
# mas install 1115348888 # Smugmug
# mas install 1012291524 # Moneywiz
