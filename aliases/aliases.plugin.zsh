#{{{ conditionally decide a few things
_myos="$(uname)"
projDir="/home/jonathan/htdocs"
gvim="gvim"
kill="pkill"
#}}}
#{{{ > Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"
#}}}
#{{{  Shortcuts
alias m='mutt; ~/bin/mailmon > /dev/null'
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
alias push="git push -u origin HEAD"
alias pull="git pull --rebase"
alias j="jobs"
alias vim="vim"
alias vi="vim"
alias v="vim"
alias :e="vim"
alias v.="vim ."
alias gvim=$gvim
alias o="xdg-open"
alias oo="xdg-open ."
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
alias a="v $HOME/.zprezto/modules/zsh-aliases/"
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
alias ack="ack --color -r"
alias speedtest="wget -O /dev/null \
 http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
alias wget="wget -c --no-check-certificate"
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
#}}}
#}}}
#{{{ network
# Gzip-enabled `curl`
alias gurl="curl --compressed"
# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"
alias iftop="sudo iftop -i wlp4s0"
# View HTTP traffic
alias sniff="sudo tcpdump -s 0 -A -i wlp4s0 port 80"
alias httpdump="sudo tcpdump -i wlp4s0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias rip="dig +short myip.opendns.com @resolver1.opendns.com"
#}}}
# {{{ utilities
# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"
#{{{ cleanup Stuff
alias sasscleanup="find . -type d -name '*.sass-cache' -ls -exec rm -rv {} \;"
# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias localizedcleanup="find . -type f -name '*.localized' -ls -delete"
#}}}
# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
# Ring the terminal bell, and put a badge on Terminal.app’s Dock icon
# (useful when executing time-consuming commands)
    alias bell="mplayer ~/.sounds/beep.mp3 -really-quiet"
alias cat="cat"
alias less="less -N"
# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
    alias "$method"="lwp-request -m '$method'"
done
alias starwars="telnet towel.blinkenlights.nl"
#}}}
#{{{ updates
alias sync="sudo pacman -Sy"
alias update="sudo -v; gp; updatelog &; yaourt -Sua --noconfirm; bell"
alias install="yaourt -S"
alias localinstall="sudo pacman -U"
#}}}
#{{{ tmux
alias tkill="tmux kill-session -t"
alias tkills="tmux kill-server"
alias tns="tmux new-session"
#}}}
#{{{ uncategorized os specific aliases
#{{{ linux
alias cal="cal -3"
alias cmdtocb='history | tail -n 1 | awk '"'"'{for(i=2;i<NF;i++)printf "%s",$i OFS; if (NF) printf "%s",$NF; printf ORS}'"'"' | clipboard'
alias poweroff="systemctl poweroff"
alias reboot="systemctl reboot"
alias ql="xdg-open"
alias blsrm="find ~/.config/ -type f -name '*.localstorage*' -ls -delete"
alias wdc="pwd | clipboard"
alias csleep="systemctl suspend"
#}}}
#}}}
#{{{ utility commands
alias ipy="ipython"
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
alias gp='$HOME/bin/gup'
#}}}
alias music-code='echo "g(i,x,t,o){return((3&x&(i*((3&i>>16?\"BY}6YB6%\":\"Qj}6jQ6%\")[t%8]+51)>>o))<<4);};main(i,n,s){for(i=0;;i++)putchar(g(i,1,n=i>>14,12)+g(i,s=i>>17,n^i>>13,10)+g(i,s/3,n+((i>>11)%3),10)+g(i,s/5,8+n-((i>>10)%3),9));}"|gcc -xc -&&./a.out|aplay;rm a.out'
