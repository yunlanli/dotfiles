current_time() { echo "%*" }
return_status() { echo " %(0?..%{$fg_bold[red]%}(%?%)%{$reset_color%})" }

# command execution time
_RPROMPT="$(current_time)$(return_status)"
preexec() { timer=$(($(print -P %D{%s%6.})/1000)) }
precmd()
{
	if [ $timer ]; then
		now=$(($(print -P %D{%s%6.})/1000))
		elapsed_time=$(($now-$timer))
		RPROMPT="[ %{$FG[002]%}$elapsed_time ms%{$reset_color%} ]  $_RPROMPT"
		unset timer
	fi
}

# TODO: make RPROMPT on the same row as the first row of PROMPT
RPROMPT="$(current_time)$(return_status)"
PROMPT=' %{$FG[002]%}%4~%{$reset_color%} $(git_prompt_info)
%(?:%{$FG[005]%}❯ : %{$FG[001]%}❯ )%{$reset_color%}'


ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
