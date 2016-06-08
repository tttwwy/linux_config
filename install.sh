rm -rf ~/.vim
rm -rf ~/.oh-my-zsh
cp -r . ~/
chmod -R 755 ~/.oh-my-zsh
chmod -R 755 ~/autojump
cd ~/autojump
python install.py