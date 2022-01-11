#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
#zle -N hyper-statusline-get-curr-keymap "_get_zle_keymap"

export ZSH="/Users/yunlan/.oh-my-zsh"

# zsh-vim-mode configurations
VIM_MODE_VICMD_KEY='jk'

ZSH_THEME="yunlan"
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-vim-mode
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

eval $(opam config env)

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
