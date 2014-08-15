PROMPT=$'%{$fg_bold[green]%}%n at %m %{$fg[blue]%}%D{[%I:%M:%S]} %{$reset_color%}$(git_prompt_info)\
%{$reset_color%}%{$fg[white]%}%~ %{$fg[white]%} => %{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
