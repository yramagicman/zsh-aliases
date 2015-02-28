#{{{ conditionally decide a few things
_myos="$(uname)"
if [[ $_myos == Linux ]]; then
    projDir="/home/jonathan/htdocs"
    gvim="gvim"
    kill="pkill"
else
    projDir="/Users/jonathan/Sites"
    gvim="mvim"
    kill="killall"
fi
#}}}
#{{{> Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
#}}}
#{{{  Shortcuts
alias m='mm'
alias wm='builtin cd ~/.mutt/; git checkout tqi; mutt; cd'
alias pm='builtin cd ~/.mutt/; git checkout master; mutt; cd'
alias d="cd ~/Dropbox"
alias doc="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias s="cd ~/Sites"
alias apps="cd /Applications"
alias themes="cd "$projDir"/wordpress/wp-content/themes"
alias gits="cd ~/Gits"
alias trash='ls ~/.Trash'
#}}}
#{{{ apps, vim, git and yo mamma
alias h="history"
alias py="python"
alias .vim="cd ~/.vim && ls"
alias push="git push"
alias pull="git pull"
alias j="jobs"
alias vi="vim"
alias v="vim"
alias v.="vim ."
alias gvim=$gvim
alias o="open"
alias oo="open ."
alias cw="compass watch"
alias cl="clear"
alias cc="compass compile"
#}}}
#{{{ Enable aliases to be sudo’ed
alias sudo='sudo '
alias npm="npm"
alias gem="gem"
alias _="cd "$projDir"/wordpress/wp-content/themes/_skeletheme/ && ls"
#}}}
#{{{ quick jump to files and directories
alias _="cd "$projDir"/wordpress/wp-content/themes/_skeletheme/"
alias a="v ~/.oh-my-zsh/custom/plugins/zsh-aliases/aliases/aliases.plugin.zsh"
alias vimrc="builtin cd ~/.vim/config/; vim ."
alias gvimrc="m ~/.gvimrc"
#}}}
#{{{ if git error
alias gitfix="git config remote.origin.push HEAD"
alias killgit="rm -rf .git && rm -rf .git*"
#}}}
#{{{ always recursive and verbose
alias cp="cp -rv"
alias rm="rm -rv"
alias mv='mv -v'
#}}}
#{{{ web dev stuff, somewhat mac specific, find alternatives
alias localwpreview="open file:///Users/jdg/Sites/ThemeReview/themeReview.html"
alias ack="ack --color -r"
alias speedtest="wget -O /dev/null \
 http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
alias wget="wget -c --no-check-certificate"
alias grunt-server="touch ~/grunt.log; grunt server >> ~/grunt.log &"
alias killserver='sudo killall httpd; sudo killall mysqld'
alias kill-grunt=$kill" grunt; rm ~/grunt.log"
#}}}
#{{{ colorize stuff, utility commands
#{{{ Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi
#}}}
#{{{ pretty ls
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
#}}}
#{{{ network

# Gzip-enabled `curl`
alias gurl="curl --compressed"
# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"
if [[ $_myos == Darwin ]]; then
    alias iftop="iftop -i en1"
    alias eiftop="iftop -i en0"
    # View HTTP traffic
    alias sniff="sudo tcpdump -s 0 -A -i en1 port 80"
    alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
    alias localip="ipconfig getifaddr en1"
    alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"
fi
if [[ $_myos == Linux ]]; then
    alias iftop="sudo iftop -i wlp4s0"
    # View HTTP traffic
    alias sniff="sudo tcpdump -s 0 -A -i wlp4s0 port 80"
    alias httpdump="sudo tcpdump -i wlp4s0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
fi
alias rip="dig +short myip.opendns.com @resolver1.opendns.com"
#}}}
# {{{find . -type f -name '*.DS_Store' -ls -delete{ random commands
# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"
#{{{ checksum on osx
if [[ $_myos == Darwin ]]; then
    # OS X has no `md5sum`, so use `md5` as a fallback
    command -v md5sum > /dev/null || alias md5sum="md5"
    # OS X has no `sha1sum`, so use `shasum` as a fallback
    command -v sha1sum > /dev/null || alias sha1sum="shasum"
    # Trim new lines and copy to clipboard
    alias c="tr -d '\n' | pbcopy"
fi
#}}}
#{{{ cleanup Stuff
if [[ $_myos == Darwin ]]; then
    # Clean up LaunchServices to remove duplicates in the “Open With” menu
    alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
fi
alias sasscleanup="rm -rfv ./**/.sass-cache && rm -rfv ./.sass-cache"
# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias localizedcleanup="find . -type f -name '*.localized' -ls -delete"
#}}}
#{{{ mac specific shortcuts for emptying trash and other various things
if [[ $_myos == Darwin ]]; then
    # Empty the Trash on all mounted volumes and the main HDD
    # Also, clear Apple’s System Logs to improve shell startup speed
    alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
    # show and hide things
    # Show/hide hidden files in Finder
    alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
    alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
    # Hide/show all desktop icons (useful when presenting)
    alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
     # Merge PDF files
    # Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
    alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'
    # Disable Spotlight
    alias spotoff="sudo mdutil -a -i off"
    # Enable Spotlight
    alias spoton="sudo mdutil -a -i on"
    # PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
    alias plistbuddy="/usr/libexec/PlistBuddy"
   alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
fi
#}}}
# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
if [[ $_myos == Darwin ]]; then
    alias bell="tput bel"
else
    alias bell="cvlc --play-and-exit ~/.sounds/beep.mp3 --quiet > /dev/null"
fi
alias cat="cat"
alias less="less -N"
# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="lwp-request -m '$method'"
done
#}}}
#{{{ Stuff I never really use but cannot delete either because of http://xkcd.com/530/
if [[ $_myos == Darwin ]]; then
    alias stfu="osascript -e 'set volume output muted true'"
    alias shutup="osascript -e 'set volume output muted true'"
    alias louder="osascript -e 'set volume 7'"
    alias headphones="osascript -e 'set volume 2'"
fi
alias starwars="telnet towel.blinkenlights.nl"
#}}}
#{{{ updates
if [[ $_myos == Darwin ]]; then
    # Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm,
    # and their installed packages
    alias update='npm install -g npm@latest;  npm update -g; \
    gem update; brew update; brew upgrade; brew linkapps; git checkout master;  bell'
else
    alias sync="yaourt -Sy; un; gup"
    alias update="sudo -v; gup; updatelog; yaourt -Syua --noconfirm; bell"
    alias install="yaourt -S"
    alias localinstall="sudo pacman -U"
fi
#}}}
#{{{ tmux
alias tkill="tmux kill-session -t"
alias tkills="tmux kill-server"
alias tns="tmux new-session"
#}}}
#{{{ uncategorized os specific aliases
#{{{ linux
if [[ $_myos == Linux ]]; then
    alias python="python2"
    alias cal="cal -3"
    alias cmdtocb='history | tail -n 1 | awk '"'"'{for(i=2;i<NF;i++)printf "%s",$i OFS; if (NF) printf "%s",$NF; printf ORS}'"'"' | clipboard'
    alias poweroff="sudo umount /mnt/share; sudo shutdown -h now"
    alias reboot="sudo umount /mnt/share; sudo shutdown -r now"
    alias ql="xdg-open"
    alias blsrm="find ~/.config/ -type f -name '*.localstorage*' -ls -delete"
    alias wdc="pwd | clipboard"
fi
#}}}
#{{{ mac
if [[ $_myos == Darwin ]]; then
    # Flush Directory Service cache
    alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"
    alias purge="sudo purge"
    alias toimg="hdiutil convert -format UDRW -o "
    alias musync="rsync -rav ~/Music/iTunes/iTunes\ Media/Music jonathan@10.0.1.8:/home/jonathan/Music"
    alias fastflix="sudo /sbin/ipfw add 2000 deny tcp from 173.194.55.0/24 to me; sudo /sbin/ipfw add 2001 deny tcp from 206.111.0.0/16 to me"
    alias dnd="launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null"
    alias udnd="launchctl load -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null"
    alias poweroff="emptytrash; sudo shutdown -h now"
    alias cmdtocb='history | tail -n 1 | awk '"'"'{for(i=2;i<NF;i++)printf "%s",$i OFS; if (NF) printf "%s",$NF; printf ORS}'"'"' | pbcopy'
    alias ql="qlmanage -p"
    alias lsblk='diskutil list'
    alias eject="diskutil eject"
    alias rmspot="sudo rm -rfv ~/Library/Caches/com.spotify.client/Storage/"
    alias blsrm="find ~/Library/ -type f -name '*.localstorage*' -ls -delete"
    alias cwd="pwd | c"
fi
#}}}
#}}}
#{{{ utility commands
alias ht='history | tail'
alias perms="cat ~/.octal"
alias q="exit"
alias mypw="pwgen -c -n -s -y 16 -1"
alias count="ls -l1 | wc -l"
alias ndate="date \"+%m-%d-%y\""
alias compile="clang++ -std=c++11 -stdlib=libc++ -Weverything -w"
# easy reload of zsh stuff
alias rl="source ~/.zshrc"
alias zconfig="vim ~/.zshrc"
#}}}
