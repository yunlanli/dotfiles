VUNDLE_URL=https://github.com/VundleVim/Vundle.vim.git
VUNDLE=~/.vim/bundle/Vundle.vim
VIM_HOME=~/.vim
VIMRC=$(VIM_HOME)/vimrc
NVIM_HOME=~/.config/nvim
NVIMRC=$(NVIM_HOME)/init.vim
NVIMRC_LUA=$(NVIM_HOME)/lua

.PHONY: all
all: backup vundle vimrc nvimrc install ultisnip

.PHONY: vim
vim: backup vundle vimrc install ultisnip

.PHONY: nvim
nvim: backup vundle nvimrc install ultisnip

.PHONY: vundle
vundle:
	if [ ! -d $(VUNDLE) ]; then git clone $(VUNDLE_URL) $(VUNDLE); fi

.PHONY: install
install:
	vim +PluginInstall +qall
	nvim +PluginInstall +qall

# creates ~/.backup to avoid .vim*~ files littering the cwd
.PHONY: backup
backup:
	if [ ! -d ~/.backup ]; then mkdir ~/.backup; fi

.PHONY: ultisnip
ultisnip:
	if [ -L ~/.vim/UltiSnips ]; then rm ~/.vim/UltiSnips; fi
	ln -s `pwd`/common/plugin/UltiSnips ~/.vim/UltiSnips

.PHONY: vimrc
vimrc:
	if [ ! -d $(VIM_HOME) ]; then mkdir -p $(VIM_HOME); fi
	sed "s#source #source `pwd`/common/#" common/init.vim  > $(VIMRC)
	echo >> $(VIMRC)
	sed "s#source #source `pwd`/vim/#" vim/init.vim >> $(VIMRC)

.PHONY: nvimrc
nvimrc:
	if [ ! -d $(NVIM_HOME) ]; then mkdir -p $(NVIM_HOME); fi
	# create init.vim
	if [ -f $(NVIMRC) ]; then rm -f $(NVIMRC); fi
	sed "s#source #source `pwd`/common/#" common/init.vim  > $(NVIMRC)
	echo >> $(NVIMRC)
	sed "s#source #source `pwd`/nvim/#" nvim/init.vim >> $(NVIMRC)
	# link lua directory
	if [ -d $(NVIMRC_LUA) ]; then rm -rf $(NVIMRC_LUA); fi
	ln -s `pwd`/nvim/lua $(NVIMRC_LUA)
