.PHONY: vimrc
vimrc: 
	cat .v* plugin/.v* > ~/.vimrc

.PHONY: vundle
vundle:
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

.PHONY: install
install:
	vim +PluginInstall +qall
