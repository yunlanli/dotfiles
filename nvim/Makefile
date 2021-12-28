NVIMRC=/Users/yunlan/.config/nvim/init.vim

.PHONY: all
all: vim nvim

.PHONY: vim
vim:
	cd ../vim && make && cd ../nvim

.PHONY: nvim
nvim:
	test -f $(NVIMRC) && rm -f $(NVIMRC)
	sed -E "s#source ([^~])#source `pwd`/\1#" init.vim > $(NVIMRC)
