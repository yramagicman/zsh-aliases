#{{{> Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
alias h="cd ~/"
#}}}
# Shortcuts
#{{{
alias d="cd ~/Dropbox"
alias doc="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias s="cd ~/Sites"
alias apps="cd /Applications"
alias themes="cd ~/Sites/wordpress/wp-content/themes"
alias gits="cd ~/Gits"
#}}}
# less typing
#{{{
alias g="git"
alias bextend="cd /Users/jonathan/Library/Application\ Support/Brackets/extensions/user"
alias py="cd ~/Sites/python/"
alias .vim="cd ~/.vim"
alias gca="git commit -a"
alias push="git push"
alias pull="git pull"
alias hist="history"
alias j="jobs"
alias v="vim"
alias v.="vim ."
alias lt="/Applications/LightTable/light"
alias m="mvim"
alias o="open"
alias oo="open ."
alias cw="compass watch"
alias cl="clear"
alias cc="compass compile"
#}}}
# sudo things and updates
#{{{
# Enable aliases to be sudo’ed
alias sudo='sudo '
alias npm="sudo npm"
alias gem="sudo gem"

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='npm update npm -g; npm update; gem update; brew update; viupdate; bell'
#}}}
# quick jump to files and directories
#{{{
alias _="cd ~/Sites/wordpress/wp-content/themes/_skeletheme/"
alias a="v ~/.oh-my-zsh/custom/plugins/aliases/aliases.plugin.zsh"
alias vimrc="v ~/.vimrc"
alias gvimrc="gv ~/.gvimrc"
#}}}
# if git error
#{{{
alias gitfix="git config remote.origin.push HEAD"
alias killgit="rm -rf .git && rm -rf .git*"
#}}}
# always recursive and verbose
#{{{
alias cp="cp -rv"
alias rm="rm -rv"
#}}}

# web dev stuff
#{{{
alias mamp="open /Applications/MAMP/MAMP.app/Contents/MacOS/MAMP"
alias wp="open -a \"Google Chrome Canary\" http://localhost:8888/wordpress/ && \
open -a \"Google Chrome Canary\" http://localhost:8888/wordpress/wp-admin/"
alias startup="themes && mamp && sleep 3 && wp"
alias wpreview="open http://codex.wordpress.org/Theme_Review"
alias localwpreview="open file:///Users/jdg/Sites/ThemeReview/themeReview.html"
alias ack="ack --color"
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
#}}}
# colorize stuff, utility commands
#{{{
# Detect which `ls` flavor is in use
# and other ls related commands
#{{{
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi
# List all files colorized in long format
alias l="ls -l ${colorflag}"
alias ls-a="ls -a ${colorflag}"
# List all files colorized in long format, including dot files
alias la="ls -la ${colorflag}"

# List only directories
alias lsd='ls -l ${colorflag} | grep "^d"'

# Always use color output for `ls`
alias ls="command ls ${colorflag}"
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

#}}}

#web related
# {{{
# Gzip-enabled `curl`
alias gurl="curl --compressed"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# View HTTP traffic
alias sniff="sudo tcpdump -s 0 -A -i en1 port 80"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
#}}}

# IP addresses
#{{{
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"
#}}}

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"


# random commands
# {{{
# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"
# cleanup Stuff
#{{{
# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete; bell"
alias sasscleanup="rm -rfv ./**/.sass-cache && rm -rfv ./.sass-cache"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
#}}}
# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
# show and hide things
#{{{
# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
#}}}
# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias bell="tput bel"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="lwp-request -m '$method'"
done
#}}}
#}}}
# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
#{{{
alias stfu="osascript -e 'set volume output muted true'"
alias shutup="osascript -e 'set volume output muted true'"
alias louder="osascript -e 'set volume 7'"
alias headphones="osascript -e 'set volume 2'"
#}}}
alias starwars="telnet towel.blinkenlights.nl"

alias dock="open /System/Library/CoreServices/Dock.app"

alias mv="/bin/mv"
alias filesize="du -skh"
alias rmspot="sudo rm -rfv ~/Library/Caches/com.spotify.client/Storage/"
alias purge="sudo purge"
alias compile="clang++ -std=c++11 -stdlib=libc++ -Weverything -w"
# easy reload of zsh stuff
alias rl="source ~/.zshrc"
alias iftop="sudo iftop -i en1"
alias eiftop="sudo iftop -i en0"
alias grunt-server="touch ~/grunt.log; grunt server >> ~/grunt.log &"
alias kill-grunt="killall grunt; rm ~/grunt.log"
alias eject="diskutil eject"