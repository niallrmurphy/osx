#!/bin/bash

# DESCRIPTION
# Installs Homebrew software.

SHELL_KIND=zsh

# Is Homebrew present?
if ! command -v brew > /dev/null; then
  ruby -e "$(curl --location --fail --silent --show-error https://raw.githubusercontent.com/Homebrew/install/master/install)"
  export PATH="/usr/local/bin:$PATH"
  append_to_shell_dotfile "$SHELL_KIND" "export PATH=\"/usr/local/bin:$PATH\"\n"
fi

minimal_set=(
  readline openssl bash-completion liquidprompt vim mas dockutil rsync rclone sqlite telnet youtube-dl mutt nmap handbrake arp-scan bash coreutils dhcping
)

for program in ${minimal_set[@]};
  do brew install $program && echo "INSTALL SUCCESS" || echo "INSTALL FAILURE"
done

# Follow-up
cat <<'EOF' >> ~/.zshrc
if [ -f /usr/local/share/liquidprompt ]; then
  . /usr/local/share/liquidprompt
fi
EOF


#
# # Readline
# brew install readline
#
# # OpenSSL
# brew install openssl
# brew link --force openssl
#
# # OpenSSL OSX CA
# brew tap raggi/ale
# brew install openssl-osx-ca
#
# # GDBM
# brew install gdbm
#
# # libffi
# brew install libffi
#
# # libyaml
# brew install libyaml
#
# # # GPG
# # brew install gpg
#
# # # GPG Agent
# # brew install gpg-agent
#
# # Bash
# brew install bash
#
# # Bash Completion
# brew install bash-completion
#
# # direnv
# brew install direnv
#
# # Vim
# brew install vim
#
# # asciinema
# brew install asciinema
#
# # ShellCheck
# brew install shellcheck
#
# # Colorized Cat
# brew install ccat
#
# # tmux
# brew install tmux
# brew install reattach-to-user-namespace
#
# # Mosh
# brew install mobile-shell
#
# # Z
# brew install z
#
# # Tree
# brew install tree
#
# # hr
# brew install hr
#
# # Git
# brew install git
#
# # Mercurial
# brew install hg
#
# # CTags
# brew install ctags
#
# # Tag
# brew install tag
#
# # # Parallel
# # brew install parallel
#
# # # Pigz
# # brew install pigz
#
# # JSON CLI Parser
# brew install jq
#
# # # The Silver Searcher
# # brew install the_silver_searcher
#
# # Htop
# brew install htop
#
# # Pipe Viewer
# brew install pv
#
# # # HTTPie
# # brew install httpie
#
# # Ioping
# brew install ioping
#
# # Network Grep
# brew install ngrep
#
# # # Namebench
# # brew install namebench
#
# # ImageMagick
# brew install imagemagick
#
# # Graphviz
# brew install graphviz
#
# # FLAC
# brew install flac
#
# # FFmpeg
# brew install ffmpeg
#
# # # Gifsicle
# # brew install gifsicle
#
# # Node
# brew install node
#
# # # Elm
# # brew install elm
#
# # Phantom.js
# brew install phantomjs
#
# # # chruby
# # brew install chruby
#
# # # Ruby Install
# # brew install ruby-install
#
# # # Rust
# # brew install rust
#
# # # Go
# # brew install go
#
# # # FZF
# # brew install fzf
#
# # # Peco
# # brew install peco
#
# # # Nginx
# # brew install nginx
#
# # # Memcached
# # brew install memcached
#
# # # Redis
# # brew install redis
#
# # # PostgreSQL
# # brew install postgresql
#
# # # Elasticsearch
# # brew install elasticsearch
#
# # # pgcli
# # brew install pgcli
#
# # # Wry
# # brew install wry
#
# # # lnav
# # brew install lnav
#
# # # cloc
# # brew install cloc
#
# # Terminal Notifier
# brew install terminal-notifier
#
# # # Watchman
# # brew install watchman
#
# # mas
# brew install mas

#  sudo xcodebuild -license accept

cask_set=(
	aquamacs adobe-creative-cloud adobe-digital-editions adobe-acrobat-reader android-file-transfer android-platform-tools arq arq-cloud-backup atom calibre carbon-copy-cloner dropbox firefox google-chrome opera handbrake hermit-crab inform kindle kobo lastpass makemkv moneywiz paragon-ntfs oscar path-finder scrivener slack spotify steam thunderbird vlc whatsapp xrg zoom macdown
)

for program in ${cask_set[@]};
  do brew cask install $program && echo "INSTALL SUCCESS" || echo "INSTALL FAILURE"
done

# Note for the future:
# To complete the installation of Cask paragon-ntfs, you must also
# run the installer at:
#  '/usr/local/Caskroom/paragon-ntfs/15/FSInstaller.app'
