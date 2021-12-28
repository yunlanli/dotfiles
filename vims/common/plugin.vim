set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'                      " :GBrowse opens up GitHub

Plugin 'arcticicestudio/nord-vim'		" Nord Color Theme
Plugin 'yuezk/vim-js'                           " syntax highlighting enhancement for jsx
Plugin 'maxmellon/vim-jsx-pretty'               " syntax highlighting enchancement for javascript
Plugin 'pangloss/vim-javascript'

Plugin 'lervag/vimtex'                          " writing, compiling latex in vim
Plugin 'KeitaNakamura/tex-conceal.vim'          " for better latex conceal

Plugin 'preservim/nerdtree'                     " NERDTree file explorer
Plugin 'junegunn/fzf'				" Fuzzy File Finder
Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-surround'			" make manipulating surroundings easy

Plugin 'dense-analysis/ale'			" Linter

if !has("nvim")
  Plugin 'ycm-core/YouCompleteMe'		" Auto Completion
  Plugin 'Sirver/ultisnips'                     " for writing snippets for latex
endif

call vundle#end()           " required
filetype plugin indent on   " required
