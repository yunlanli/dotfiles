VIMRC=~/.vimrc
NVIMRC=~/.config/nvim/init.vim

.PHONY: all
all: backup vundle vimrc nvimrc install

.PHONY: vim
vim: backup vundle vimrc install

.PHONY: nvim
nvim: backup vundle nvimrc install

.PHONY: vundle
vundle:
	test -d ~/.vim/bundle/Vundle.vim || \
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

.PHONY: install
install:
	vim +PluginInstall +qall

# creates ~/.backup to avoid .vim*~ files littering the cwd
.PHONY: backup
backup:
	test -d ~/.backup || mkdir ~/.backup

.PHONY: vimrc
vimrc:
	test -f ~/.vimrc && rm -f ~/.vimrc
	sed "s#source #source `pwd`/common/#" common/init.vim  > $(VIMRC)
	echo >> $(VIMRC)
	sed "s#source #source `pwd`/vim/#" vim/init.vim >> $(VIMRC)

.PHONY: nvimrc
nvimrc:
	test -f $(NVIMRC) && rm -f $(NVIMRC)
	sed "s#source #source `pwd`/common/#" common/init.vim  > $(NVIMRC)
	echo >> $(NVIMRC)
	sed "s#source #source `pwd`/nvim/#" nvim/init.vim >> $(NVIMRC)
