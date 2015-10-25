#!/bin/bash 
rm -f /bin/sh
ln -s /bin/bash /bin/sh
mkdir ~/.vim
cp -R vim/* ~/.vim/
cp bashrc ~/.bashrc
cp vimrc ~/.vimrc
cp dircolors ~/.dircolors
source ~/.bashrc
