fpath=("${0:h}" $fpath)
fpath=("${0:h}/functions" $fpath)
# source "${0:h}/functions/functions.plugin.zsh"
autoload ${0:h}/functions/*
source "${0:h}/aliases/aliases.plugin.zsh"
