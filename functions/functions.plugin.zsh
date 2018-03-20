# Simple calculator
function calc() {
    local result=""
    result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"
    #                       └─ default (when `--mathlib` is used) is 20
    #
    if [[ "$result" == *.* ]]; then
        # improve the output for decimal numbers
        printf "$result" \
            | sed -e 's/^\./0./' $( # add "0" for cases like ".5"` \
                -e 's/^-\./-0./'
            ) # add "0" for cases like "-.5"`\
        -e 's/0*$//;s/\.$//' # remove trailing zeros
    else
        printf "$result"
    fi
    printf "\n"
}
# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$@"
}
# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null >/dev/null 2>&1; then
        local arg=-sbh
    else
        local arg=-sh
    fi
    if [[ -n "$@" ]]; then
        du $arg -- "$@"
    else
        du $arg .[^.]* *
    fi
}
# Use Git’s colored diff when available
hash git &>/dev/null
if [ $? -eq 0 ]; then
    function diff() {
        git diff --no-index --color-words "$@"
    }
fi
# Create a data URL from a file
function dataurl() {
    local mimeType=$(file -b --mime-type "$1")
    if [[ $mimeType == text/* ]]; then
        mimeType="${mimeType};charset=utf-8"
    fi
    echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}
# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}"
    sleep 1 && xdg-open "http://localhost:${port}/" &
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python2 -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}
# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
    local port="8000"
    local ip=127.0.0.1
    sleep 1 && open "http://${ip}:${port}/" &
    php -S "${ip}:${port}"
}
# Compare original and gzipped file size
function gz() {
    local origsize=$(wc -c <"$1")
    local gzipsize=$(gzip -c "$1" | wc -c)
    local ratio=$(echo "$gzipsize * 100/ $origsize" | bc -l)
    printf "orig: %d bytes\n" "$origsize"
    printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}
# Test if HTTP compression (RFC 2616 + SDCH) is enabled for a given URL.
# Send a fake UA string for sites that sniff it instead of using the Accept-Encoding header. (Looking at you, ajax.googleapis.com!)
function httpcompression() {
    local encoding="$(curl -LIs -H 'User-Agent: Mozilla/5 Gecko' -H 'Accept-Encoding: gzip,deflate,compress,sdch' "$1" | grep '^Content-Encoding:')" && echo "$1 is encoded using ${encoding#* }" || echo "$1 is not using any encoding"
}
# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
    if [ -t 0 ]; then # argument
        python -mjson.tool <<<"$*" | pygmentize -l javascript
    else # pipe
        python -mjson.tool | pygmentize -l javascript
    fi
}
# All the dig info
function digga() {
    dig +nocmd "$1" any +multiline +noall +answer
}
# Escape UTF-8 characters into their 3-byte format
function escape() {
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    echo # newline
}
# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
    perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
    echo # newline
}
# Get a character’s Unicode code point
function codepoint() {
    perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
    echo # newline
}
# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
    if [ -z "${1}" ]; then
        echo "ERROR: No domain specified."
        return 1
    fi
    local domain="${1}"
    echo "Testing ${domain}…"
    echo # newline
    local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
        | openssl s_client -connect "${domain}:443" 2>&1)
    if [[ "${tmp}" == *"-----BEGIN CERTIFICATE-----"* ]]; then
        local certText=$(echo "${tmp}" \
            | openssl x509 -text -certopt "no_header, no_serial, no_version, \
    no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux")
        echo "Common Name:"
        echo # newline
        echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//"
        echo # newline
        echo "Subject Alternative Name(s):"
        echo # newline
        echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
            | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
        return 0
    else
        echo "ERROR: Certificate not found."
        return 1
    fi
}

function cd() {
    #{{{ Detect which `ls` flavor is in use
    if ls --color >/dev/null 2>&1; then # GNU `ls`
        colorflag="--color=auto"
    else # OS X `ls`
        colorflag="-G"
    fi
    #}}}
    if [[ -n "$(cat $VIRTUAL_ENV/.project 2>/dev/null)" && -z "$@" ]]; then
        builtin cd $(cat $VIRTUAL_ENV/.project) && ls -F ${colorflag}
    elif [[ -n "$(git rev-parse --show-toplevel 2>/dev/null)" && "$(pwd)" == "$(git rev-parse --show-toplevel 2>/dev/null)" && -z "$@" ]]; then
        builtin cd ~/ && ls -F ${colorflag}
    elif [[ -n "$(git rev-parse --show-toplevel 2>/dev/null)" && -z "$@" ]]; then
        builtin cd $(git rev-parse --show-toplevel) && ls -F ${colorflag}
    else
        builtin cd $@ && ls -F ${colorflag}
    fi
}

function pg() {
    ps aux | grep -i $@ | grep -v grep
}

function lg() {
    ls -alh | grep -i $@
}

function hg() {
    history | grep -i $@
}

function orphans() {
    if [[ ! -n $(pacman -Qqdt) ]]; then
        echo "No orphans to remove."
    else
        sudo pacman -Rns $( pacman -Qqdt )
    fi
}

function flatten() {
    find $@ -mindepth 2 -type f -exec mv -i '{}' $@ ";"
    find $@ -mindepth 1 -type d -ls -exec rmdir '{}' ';'
}

function git-remote-fork() {
    git remote add upstream $@
}

function find-replace() {
    find=$1
    replace=$2
    echo "replacing $find with $replace in $(pwd)"
    find ./ -type f -exec grep -q $find '{}' \; -exec sed -i -e "s/$find/$replace/g" '{}' \;
}

function fuzzy-remove() {
    sudo pacman -Rns  $(pacman -Qq | grep "$1" )
}

function emacs() {
    if [[ -e /tmp/emacs1000/server ]]; then
        if [[ -z $(pg emacsclient) ]]; then
            emacsclient -a emacs -s /tmp/emacs1000/server -c $@ &
        else
            emacsclient -a emacs -s /tmp/emacs1000/server -c $@ &
        fi
    else
        if [[ -z $(pg emacsclient) ]]; then
            emacsclient -a emacs -c $@ &
        else
            command emacs --daemon
            command emacsclient $@
        fi
    fi
}
alias emacsclient="emacs"

function vmod() {
    vim $(g s | egrep -v '\?\?|D' | awk -F ' ' '{print $2}')
}

function vreb() {
    if [[ -n $( grep -l '<<< HEAD' $(git ls-files) | sort -u ) ]]; then
        vim $( grep -l '<<< HEAD' $(git ls-files) | sort -u )
    else
        echo "\n\nno unresolved conflicts"
    fi
}

function gam() {
    git add $(g s | egrep -v '\?\?|D' | awk -F ' ' '{print $2}')
}

function emod() {
    emacs $(g s | egrep -v '\?\?|D' | awk -F ' ' '{print $2}')
}

function ereb() {
    if [[ -n $( grep -l '<<< HEAD' $(git ls-files) | sort | uniq ) ]]; then
        emacs $( grep -l '<<< HEAD' $(git ls-files) | sort | uniq )
    else
        echo "\n\nno unresolved conflicts"
    fi
}

function switch_or_attach() {
    if [[ -n "$(tmux switch-client -t $3 2 >/dev/null)" ]]; then
        tmux switch-client -t $1
    else
        tmux attach -t $1
    fi

}

function s() {
    # Check for .tmux file (poor man's Tmuxinator).
    if [[ -n $1 && -x "$HOME/.tmux.d/$1" ]]; then
        # Prompt the first time we see a given .tmux file before running it.
        local DIGEST="$(openssl sha512 $HOME/.tmux.d/$1)"
        if ! grep -q "$DIGEST" ~/.tmux.d/digests 2>/dev/null; then
            cat $HOME/.tmux.d/$1
            read -k 1 -r \
                'REPLY?Trust (and run) this .tmux file? (t = trust, otherwise = skip) '
            echo
            if [[ $REPLY =~ ^[Tt]$ ]]; then
                echo "$DIGEST" >>~/.tmux.d/digests
                $HOME/.tmux.d/$1 $2
                return
            fi
        else
            echo "$@"
            $HOME/.tmux.d/$1 $2
            return
        fi
    fi
}

if alias o > /dev/null; then
    unalias o
fi

function o() {
    nohup xdg-open "$@" >/dev/null &
}

function ranger() {
    if [[ $(command ranger --version) == '' ]]; then
        echo "installing"
        sudo zypper in ranger
    fi
    echo "launching \r"
    command ranger $@
}
function cmus() {
    if [[ -z $(pgrep mpd) ]]; then
        mpd >/dev/null 2>&1
    fi
    /usr/bin/ncmpcpp

}
alias ncmpcpp="cmus"

function screencap() {
    echo "which monitor"
    read mon

    if [[ $mon -eq 1 ]]; then
        ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0+0,0 $1.mp4
    fi

    if [[ $mon -eq 2 ]]; then
        ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :0.0+1920,0 $1.mp4
    fi
}

function getmail() {
    fetchmail --quit
    fetchmail --check
    fetchmail
}


function service-restart() {
    for p in $(sudo zypper ps -sss)
    do
        sudo systemctl restart $p
    done
}
function zypper() {
if [[ $1 == 'in' || $1 == 'install' ]]; then
    sudo zypper $*
    echo "sudo zypper $*" >> ~/bin/setup/installs

elif [[ $1 == 'rm' || $1 == 'remove' ]]; then
    sudo zypper $*
    echo "sudo zypper $*" >> ~/bin/setup/installs
else
    command zypper "$@"
fi
}