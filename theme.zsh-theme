PROMPT=$'%{$fg_bold[green]%}%n at %m %{$fg[blue]%}%D{[%I:%M:%S]} %{$fg[white]%}%~\
%{$reset_color%}$(git_prompt_info) %{$fg[white]%} -> %{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
