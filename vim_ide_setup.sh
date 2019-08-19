#!/bin/bash
# gregbakerstl development environment setup

# linux package list
apt_packages='vim vim-gtk cmake python-dev python build-essential zsh'

# install linux dev packages
for package in $apt_packages; do
	sudo apt install -y $package
done

# configure vim plugins and syntax highlighting
vim_config=vimrc
cat ${vim_config} >> ~/.vimrc

# pull down vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# compile vundle
python ~/.vim/bundle/YouCompleteMe/install.py --clang-completer 

# compile and install plugins for vim
vim +PluginInstall +qall

# install oh my zsh
echo "y"|sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
