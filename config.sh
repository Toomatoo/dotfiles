#!/bin/sh

set -e

sudo apt-get install zsh
chsh -s /bin/zsh


echo "====================="
echo "1. Backup your config files. e.g. ~/.zshrc -> ~/.zshrc.backup"
# Require Vim with Lua
if [ -f "$HOME/.zshrc" ]
then
 echo "$file found."
 mv ~/.zshrc ~/.zshrc.backup
else
 echo "$file not found."
fi

echo "====================="
echo "2. Install"

sudo pip install flake8
sudo mkdir -p ~/.vim_runtime
sudo mkdir -p ~/.oh-my-zsh
sudo mkdir -p ~/.config
cp -R vim/* ~/.vim_runtime/
# rsync -av --progress vim ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
cp -R oh-my-zsh/* ~/.oh-my-zsh/
chsh -s /bin/zsh
cp oh-my-zsh/.zshrc ~/
cp flake8 ~/.config/flake8

echo "====================="
echo "3. Config Vim"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim || true
pip install autopep8 --user
vim +PluginInstall +qall
git config --global diff.tool vimdiff
git config --global difftool.prompt false
git config --global alias.d difftool
(cd ~/.vim/bundle/YouCompleteMe && ./install.py)

echo "====================="
echo "4. Success!"
