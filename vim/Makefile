.PHONY: all
all: vundle vimrc install backup

.PHONY: vimrc
vimrc: 
	cat .v* plugin/.v* function/* > ~/.vimrc

.PHONY: vundle
vundle:
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

.PHONY: install
install:
	vim +PluginInstall +qall

# creates ~/.backup to avoid .vim*~ files littering the cwd
.PHONY: backup
.bakcup:
	mkdir ~/.backup

