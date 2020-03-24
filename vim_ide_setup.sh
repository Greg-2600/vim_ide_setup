#!/bin/bash
# gregbakerstl development environment setup

install_packages() {
	# linux package list
	apt_packages='git
		      vim
		      vim-gtk
		      cmake
		      python3
		      python3-dev
		      build-essential
		      zsh
		      curl
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

	# idempotently pull down vundle
	location="$HOME/.vim/bundle/Vundle.vim"
	if [ -d "{$location}" ]; then 
		rm -rf "${location}"; 
	fi
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim


	# compile and install plugins for vim
	vim +PluginInstall +qall

	# compile YouCompleteMe
	cd ~/.vim/bundle/YouCompleteMe/ || exit
	./install.py --clang-completer
	cd || exit

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
