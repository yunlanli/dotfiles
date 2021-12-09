SHELL = bash


.PHONY: tmux
tmux: .tmux.conf
	([ -f ~/.tmux.conf ] || [ -L ~/.tmux.conf ]) && rm -f ~/.tmux.conf
	ln -s $(shell pwd)/.tmux.conf ~/
