set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
filetype off

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'arcticicestudio/nord-vim'                          " Nord Color Theme
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'                                 ":GBrowse opens up GitHub
Plugin 'tpope/vim-surround'
Plugin 'vuciv/vim-bujo'                                    " Per-repo todo list
Plugin 'mhinz/vim-startify'

Plugin 'lervag/vimtex'                                     " writing, compiling latex in vim
Plugin 'KeitaNakamura/tex-conceal.vim'                     " for better latex conceal
Plugin 'Sirver/ultisnips'                                  " snippets

Plugin 'dense-analysis/ale'                                " Linter

if !has("nvim")
	Plugin 'preservim/nerdtree'
	Plugin 'junegunn/fzf'                                  " Fuzzy File Finder
	Plugin 'junegunn/fzf.vim'
	Plugin 'ycm-core/YouCompleteMe'                        " Auto Completion
endif

if has("nvim")
	Plugin 'nvim-lua/plenary.nvim'                         " Telescope reqs (Finder)
	Plugin 'nvim-telescope/telescope.nvim'
	Plugin 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
	Plugin 'nvim-telescope/telescope-project.nvim'
	Plugin 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plugin 'nvim-treesitter/playground'
	Plugin 'kyazdani42/nvim-tree.lua'
	Plugin 'norcalli/nvim-colorizer.lua'
	Plugin 'neovim/nvim-lspconfig'
	Plugin 'glepnir/lspsaga.nvim'
	Plugin 'hrsh7th/cmp-nvim-lsp'                          " Auto-completion
	Plugin 'hrsh7th/cmp-nvim-lua'
	Plugin 'onsails/lspkind-nvim'
	Plugin 'hrsh7th/cmp-buffer'
	Plugin 'hrsh7th/cmp-path'
	Plugin 'hrsh7th/cmp-cmdline'
	Plugin 'hrsh7th/nvim-cmp'
	Plugin 'quangnguyen30192/cmp-nvim-ultisnips'
	Plugin 'nvim-lualine/lualine.nvim'                     " Status Line
	Plugin 'kyazdani42/nvim-web-devicons'
	Plugin 'numToStr/Comment.nvim'                         " Code Comment
	Plugin 'ThePrimeagen/harpoon'                          " Navigation
	Plugin 'mfussenegger/nvim-dap'                         " Debugging
	Plugin 'rcarriga/nvim-dap-ui'
	Plugin 'mfussenegger/nvim-dap-python'
	Plugin 'TimUntersberger/neogit'                        " Nvim clone of emacs magit
	Plugin 'lewis6991/gitsigns.nvim'
	Plugin 'folke/trouble.nvim'                            " Prettier {qf|loc}list
	Plugin 'github/copilot.vim'
endif

call vundle#end()

filetype plugin indent on
