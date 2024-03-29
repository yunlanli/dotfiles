set nocompatible
set backspace=indent,eol,start
set nu rnu
set encoding=utf-8
set ruler
set laststatus=2
set path+=**
set wildmenu
set cpt=.
set backupdir^=~/.backup
set dir^=~/.backup//
set ai noet sw=8 ts=8 sts=0
set ignorecase
set hlsearch
set mouse="a"
set list
set listchars=tab:\ \ ,eol:↲,trail:•,nbsp:␣
set cursorline
set termguicolors
syntax enable
colorscheme nord

augroup filetype_settings
	autocmd!
	autocmd FileType help             setlocal nospell
	autocmd FileType text,markdown    setlocal sw=2 ts=2 textwidth=80 spell spelllang=en_us

	autocmd FileType tex              setlocal shiftwidth=4 tabstop=4 textwidth=100 nospell
	autocmd FileType tex              normal ;ll
	autocmd TextChanged,TextChangedI  *.tex silent :write

	autocmd FileType c,cpp            setlocal textwidth=80
	autocmd FileType python           setlocal shiftwidth=4 tabstop=4 textwidth=80
	autocmd FileType go               setlocal shiftwidth=2 tabstop=2 textwidth=80
	autocmd FileType ocaml            setlocal shiftwidth=2 tabstop=2 textwidth=80
	autocmd FileType javascript       setlocal shiftwidth=2 tabstop=2 textwidth=80 expandtab
	autocmd FileType javascriptreact  setlocal shiftwidth=4 tabstop=4 textwidth=80
	autocmd FileType vim              setlocal shiftwidth=4 tabstop=4 textwidth=80
	autocmd FileType lua              setlocal shiftwidth=2 tabstop=2 textwidth=80
augroup END


let mapleader=" "
let maplocalleader=";"

function OpenVimrc()
	:if !exists("w:prev_vimrc_buff")
	: let w:prev_vimrc_buff=bufnr("%")
	: let w:prev_vimrc_pos=getpos(".")
	:endif
	:badd $MYVIMRC
	:execute "b!" $MYVIMRC
endfunction

function CloseVimrc()
	:exe "bwipe!" $MYVIMRC
	:exe "b!" w:prev_vimrc_buff
	:unlet w:prev_vimrc_buff
endfunction

map gf :edit <cfile><cr>

nmap <leader>ve :execute OpenVimrc()<cr>
nmap <leader>vr :source $MYVIMRC<cr>
nmap <leader>vq :execute CloseVimrc()<cr>:call setpos(".", w:prev_vimrc_pos)<cr>:unlet w:prev_vimrc_pos<cr>

nnoremap Y y$
nnoremap n nzt3k3jzv
nnoremap N Nzt3k3jzv
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <A-up>    :resize +5<cr>
nnoremap <A-down>  :resize -5<cr>
nnoremap <A-left>  :vert resize -5<cr>
nnoremap <A-right> :vert resize +5<cr>
nnoremap <Leader><space> :nohl<cr>
nnoremap <Leader>n :tabn<cr>
nnoremap <Leader>N :tabp<cr>
nnoremap <Leader>c :tabc<cr>

nnoremap <Leader>bn :bnext<cr>
nnoremap <Leader>bp :bprev<cr>
nnoremap <Leader>bd :bwipe! %<cr>

inoremap jk <esc>
nnoremap <s-up> <Esc>:m .-2<CR>==gi
nnoremap <s-down> <Esc>:m .+1<CR>==gi
vnoremap <s-down> :m '>+1<CR>gv=gv
vnoremap <s-up> :m '<-2<CR>gv=gv

nnoremap [q :cprev<cr>
nnoremap ]q :cnext<cr>
nnoremap [l :lprev<cr>
nnoremap ]l :lnext<cr>

inoremap <localleader>s <c-g>u<esc>m0[s1z=`0a<c-g>u

vnoremap <c-c> "+y
