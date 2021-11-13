.PHONY: all
all: backup vundle vimrc install

.PHONY: vimrc
vimrc: 
	cat .v* plugin/.v* function/* > ~/.vimrc

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

