#{{{ conditionally decide a few things
_myos="$(uname)"
kill="pkill"
#}}}
#{{{ > Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
#}}}
#{{{ apps, vim, git and yo mamma
alias m="mutt; rm $HOME/.config/mail > /dev/null; ~/bin/mailmon > $HOME/.config/mail"
alias h="history"
alias py="python"
alias .vim="cd ~/.vim && ls"
alias push="git push -u origin HEAD"
alias pull="git pull --rebase"
alias j="jobs"
alias vi="vim"
alias v="vim"
alias :e="vim ."
alias e="vim"
alias v.="vim ."
alias gvim="vim"
alias oo="nohup xdg-open . > /dev/null &"
alias cw="compass watch"
alias cc="compass compile"
alias cw="compass.ruby2.4 watch"
alias compass="compass.ruby2.4"
alias cc="compass.ruby2.4 compile"
alias cl="clear"
alias t='tmux'
alias :q='exit'
#}}}
#{{{ Enable aliases to be sudo’ed
alias sudo='sudo '
#}}}
#{{{ quick jump to files and directories
alias vimrc="builtin cd ~/.vim/config/; vim ."
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
#{{{ web dev stuff
alias speedtest="wget -O /dev/null \
 http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
alias wget="wget -c --no-check-certificate"
#}}}
#{{{ colorize stuff, utility commands
#{{{ Detect which `ls` flavor is in use
if ls --color >/dev/null 2>&1; then # GNU `ls`
    colorflag="--color=auto"
else # OS X `ls`
    colorflag="-G"
fi
#}}}
#{{{ pretty ls
# List all files colorized in long format
alias l="ls -Fl ${colorflag}"
alias ls-a="ls -Fa ${colorflag}"
# List all files colorized in long format, including dot files
alias la="ls -Fla ${colorflag}"
# List only directories
alias lsd='ls -Fl ${colorflag} | grep "^d"'
# Always use color output for `ls`
alias ls="command ls -F ${colorflag}"
#}}}
#}}}
#{{{ network
# Gzip-enabled `curl`
alias curl="curl -L --compressed"
# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"
alias iftop="sudo iftop -i wlp4s0"
# View HTTP traffic
alias sniff="sudo tcpdump -s 0 -A -i wlp4s0 port 80"
alias httpdump="sudo tcpdump -i wlp4s0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias rip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip="ip -c"
#}}}
# {{{ utilities
# Canonical hex dump; some systems have this symlinked
command -v hd >/dev/null || alias hd="hexdump -C"
#{{{ cleanup Stuff
alias sasscleanup="find . -type d -name '*.sass-cache' -ls -exec rm -rv {} \;"
# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias localizedcleanup="find . -type f -name '*.localized' -ls -delete"
alias cleansym="find ./ -xtype l -ls -exec rm {} \;"
#}}}
# URL-encode strings
alias urlencode='python2 -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
alias bell="mplayer ~/.sounds/beep.mp3 -really-quiet; tput bel"
alias cat="cat"
alias less="less -N"
# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="lwp-request -m '$method'"
done
alias starwars="telnet towel.blinkenlights.nl"
alias hangups="$HOME/Sites/hangups/bin/hangups"
#}}}
#{{{ updates
alias update="sudo -v; gup; sudo zypper dup -l -y; bell"
#}}}
#{{{ tmux
alias tkill="s tmux; tmux kill-session -t"
alias tkills="tmux kill-server"
alias tns="tmux new-session"
alias tls="tmux ls"
#}}}
#{{{ uncategorized aliases
alias cal="cal -3"
alias poweroff="sudo systemctl poweroff"
alias reboot="sudo systemctl reboot"
alias blsrm="find ~/.config/ -type f -name '*.localstorage*' -ls -delete"
alias mute="amixer -c 0 -- set Master playback -1000dB > /dev/null"
alias unmute="amixer -c 0 -- set Master playback -20dB > /dev/null"
#}}}
#{{{ utility commands
alias perms="cat ~/.octal"
alias q="exit"
alias mypw="pwgen -c -n -s -y 16 -1"
alias ndate="date \"+%d-%m-%y\""
# easy reload of zsh stuff
alias rl="source ~/.zshrc; rehash"
alias zconfig="vim ~/.zshrc"
#}}}
#{{{ git configs
alias g="git"
alias gca="git commit --all --verbose"
alias gco="git checkout"
alias gs="git status --short"
#}}}
