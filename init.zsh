fpath=("${0:h}" $fpath)
fpath=("${0:h}/functions" $fpath)
# source "${0:h}/functions/functions.plugin.zsh"
for f in ${0:h}/functions/*; do
    autoload "$(basename $f )"
done
source "${0:h}/aliases/aliases.plugin.zsh"
