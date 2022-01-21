# set terminal title to current working directory
# https://github.com/ohmyzsh/ohmyzsh/wiki/Settings#automatic-title
DISABLE_AUTOT_TITLE=true
ZSH_THEME_TERM_TITLE_IDLE=%~
ZSH_THEME_TERM_TAB_TITLE_IDLE=%~

################################################################################
#  History
################################################################################
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS

setopt inc_append_history
setopt share_history


################################################################################
#  Env Vars
################################################################################
export EDITOR="nvim"
export VISUAL="nvim"
export PATH="~/.emacs.d/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm@11/bin:$PATH"

export FZF_DEFAULT_COMMAND="fd ."
export FZF_DEFAULT_OPTS="\
	--reverse --height=20 --border=sharp \
	--color='bw,hl:#A3BE8C:regular,hl:bold' \
	--color='query:#8FBCBB,pointer:#B48EAD' \
	--color='gutter:#2E3440,hl+:#A3BE8C' \
	--color='marker:#EBCB8B:regular,marker:bold,marker:italic'"

# To use the bundled libc++ please add the following LDFLAGS:
export LDFLAGS="$LDFALGS -L/opt/homebrew/opt/llvm/lib -Wl,-rpath,/opt/homebrew/opt/llvm/lib"
# For compilers to find llvm
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/llvm/include"


################################################################################
#  aliases
################################################################################
alias cat="bat"
alias ll="ls -alf"
alias nv="nvim"
alias env="env | cut -d "=" -f 1 | fzf | xargs printenv"

alias g="git"
alias gw="git worktree"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gd="git diff"
alias gf="git fetch"
alias grt="git restore"
alias gs="git stash"
alias gst="git status"
alias gr="git rebase"
alias gp="git push"
alias gP="git pull"

alias tmn="tmux_sessionizer"

alias ez="$EDITOR $ZSH_CUSTOM/ylconfig.zsh"
alias sz="source ~/.zshrc"

alias db="dune build"
alias dbs="dune build --display=short"
alias dbv="dune build --display=verbose"

alias opami="opam install . --deps-only"
alias eop="eval $(opam env --switch=/Users/yunlan/Code/cs@columbia/plt/pocaml --set-switch)"
alias wc_pocaml="cd /Users/yunlan/Code/cs@columbia/plt/pocaml_docker"
alias pocamll="dune exec -- bin/main.exe -l"
alias pocamla="dune exec -- bin/main.exe -a"


################################################################################
#  Key Bindings
################################################################################
bindkey -s "^x" "rm -f ~/.backup/*\n"


################################################################################
#  Functions
################################################################################
make_app_aliases()
{
	find /Applications -maxdepth 1 -type l | \
	while read f;
		do osascript -e \
		"tell app \"Finder\" to make new alias file at POSIX file \
		\"/Applications\" to POSIX file \"$(stat -f%Y "$f")\"";
		rm "$f";
	done
}

# Fuzzy cd using fzf
# fcd [root_dir]
fcd()
{
	if [ $# -eq 1 ]; then
		root_dir=$1;
	else
		root_dir=. 
	fi

	dir=`fd $root_dir 2>/dev/null | fzf`
	cd $dir
}

# attach to an existing tmux session
tma()
{
	target=`tmux list-sessions | fzf | cut -f 1 -d :`

	if [ -z $target ]; then
		return
	fi

	src=`tmux display-message -p '#S'`

	if [ -z $TMUX ]; then
		tmux attach-session -t $target
	elif [ target != src ]; then
		tmux switch-client -t $target
	fi
}
