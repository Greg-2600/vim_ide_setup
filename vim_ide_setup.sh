#!/bin/bash
# gregbakerstl development environment setup

install_packages() {
	# linux package list
	apt_packages='vim
		      vim-gtk
		      cmake
		      python 
		      python-dev
		      build-essential
		      zsh
		      shellcheck'

	# install linux dev packages
	for package in $apt_packages; do
		sudo apt install -y "$package"
	done
}


configure_vim() {
	# configure vim plugins and syntax highlighting
	vim_config=vimrc
	cat ${vim_config} >> ~/.vimrc

	# pull down vundle
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

	# compile YouCompleteMe
	cd ~/.vim/bundle/YouCompleteMe || exit
	./install.py
	cd || exit

	# compile and install plugins for vim
	vim +PluginInstall +qall

}


install_zsh() {
	# install oh my zsh
	echo "y"|sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}


main () {
	install_packages
	configure_vim
	install_zsh
}

main
