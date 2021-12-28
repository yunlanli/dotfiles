source .vimrc_base
source .vimrc_plugin
source .vimrc_yl

source plugin/.vimrc-ale
source plugin/.vimrc-fzf
source plugin/.vimrc-nerdtree
source plugin/.vimrc-texconceal
source plugin/.vimrc-vimtex
if !has("nvim")
  source plugin/.vimrc-ultisnip
  source plugin/.vimrc-ycm
endif

source function/comments.vim
