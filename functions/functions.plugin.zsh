# Simple calculator
function calc() {
    local result=""
    result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"
    #                       └─ default (when `--mathlib` is used) is 20
    #
    if [[ "$result" == *.* ]]; then
    # improve the output for decimal numbers
    printf "$result" |
    sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
    -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
    -e 's/0*$//;s/\.$//'   # remove trailing zeros
    else
    printf "$result"
    fi
    printf "\n"
}
# Create a new directory and enter it
function mkd() {
    mkdir -p "$@" && cd "$@"
}
function ackmail() {
    builtin cd /Users/jonathan/.mutt/cache/bodies/imaps:jonathandavis@gilsons.org@vps2943.inmotionhosting.com:993/INBOX
    ack "$@"
}
# Determine size of a file or total size of a directory
function fs() {
    if du -b /dev/null > /dev/null 2>&1; then
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
    sleep 1 && open -a "Google Chrome Canary" "http://localhost:${port}/" &
    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}
# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
    local port="${1:-4000}"
    local ip=$(ipconfig getifaddr en1)
    sleep 1 && open "http://${ip}:${port}/" &
    php -S "${ip}:${port}"
}
# Compare original and gzipped file size
function gz() {
    local origsize=$(wc -c < "$1")
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
    python -mjson.tool <<< "$*" | pygmentize -l javascript
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
    | openssl s_client -connect "${domain}:443" 2>&1);
    if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
    local certText=$(echo "${tmp}" \
    | openssl x509 -text -certopt "no_header, no_serial, no_version, \
    no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux");
    echo "Common Name:"
    echo # newline
    echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//";
    echo # newline
    echo "Subject Alternative Name(s):"
    echo # newline
    echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
    | sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
    return 0
    else
    echo "ERROR: Certificate not found.";
    return 1
    fi
}
_myos="$(uname)"
if [[ $_myos == Darwin ]]; then
# Add note to Notes.app (OS X 10.8)
# Usage: `note 'foo'` or `echo 'foo' | note`
function note() {
    local text
    if [ -t 0 ]; then # argument
    text="$1"
    else # pipe
    text=$(cat)
    fi
    body=$(echo "$text" | sed -E 's|$|<br>|g')
    osascript >/dev/null <<EOF
tell application "Notes"
    tell account "iCloud"
    tell folder "Notes"
    make new note with properties {name:"$text", body:"$body"}
    end tell
    end tell
end tell
EOF
}
# Add reminder to Reminders.app (OS X 10.8)
# Usage: `remind 'foo'` or `echo 'foo' | remind`
function remind() {
    local text
    if [ -t 0 ]; then
    text="$1" # argument
    else
    text=$(cat) # pipe
    fi
    osascript >/dev/null <<EOF
tell application "Reminders"
    tell the default list
    make new reminder with properties {name:"$text"}
    end tell
end tell
EOF
}
# Manually remove a downloaded app or file from the quarantine
function unquarantine() {
    for attribute in com.apple.metadata:kMDItemDownloadedDate com.apple.metadata:kMDItemWhereFroms com.apple.quarantine; do
    xattr -r -d "$attribute" "$@"
    done
}
function shop(){
    find ./ -name $1 -exec open -a /Applications/Adobe\ Photoshop\ CS6/Adobe\ Photoshop\ CS6.app {} \;
}
function tw(){
    open $@ -a TextWrangler.app
}
fi
function swap() {
    mv $1 ~/.store.txt
    mv $2 $1
    mv ~/.store.txt $2
}
function watch() {
    while
    do
    clear
    tree $@
    sleep 1s
    done
}
function cd() {
    builtin cd $@ && ls
}
function ccompile() {
    while
    do
    clear
    clang++ -std=c++11 -stdlib=libc++ -Weverything -w $@
    sleep 3s
    ./a.out
    sleep 30s
    done
}
function blank(){
    while
        do
            clear
            sleep 20s
            clear
            sleep 60s
        done
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
  if [[ ! -n $(pacman -Qdt) ]]; then
    echo "No orphans to remove."
  else
    sudo pacman -Rns $(pacman -Qdtq)
  fi
}

function mm(){
    echo "Personal or work?"
    read tmp
    if [[ $tmp == 'p' ]]; then
        builtin cd ~/.mutt/
        git checkout master
        mutt
    fi
    if [[ $tmp == 'w' ]]; then
        builtin cd ~/.mutt/
        git checkout tqi
        mutt
    fi
    builtin cd
}
function flatten(){
    find $@ -mindepth 2 -type f -exec mv -i '{}' $@ ';'
}
