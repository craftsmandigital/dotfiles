
#Installing ubuntu 20 config

# How to Install and Setup Zsh in Ubuntu 20.04
# https://www.tecmint.com/install-zsh-in-ubuntu/
sudo apt install zsh -y


# make ZSH our default shell. Use the “chsh” command with '-s' flag to switch the default shell for the user.
# https://www.tecmint.com/install-zsh-in-ubuntu/
chsh -s $(which zsh)
# NB! NB! Now to use the new zsh shell, log out of the terminal and log in again

# moving config from home dir to zsh dir
mkdir $HOME/.config
mkdir $HOME/.config/zsh
# mv $HOME/.zshrc $HOME/.config/zsh
echo 'export ZDOTDIR=$HOME/.config/zsh' > $HOME/.zshenv #all config in .config folder
rm $HOME/.zshrc # Fetc file from my repo later on to $ZDOTDIR

# Creating rest of enviroment structure
mkdir $HOME/repos
mkdir $HOME/repos/own
mkdir $HOME/repos/others
# Creating a stow dir to store configs
# Here you can read more about stow
# https://paramdeo.com//blog/managing-dotfiles-with-git-and-gnu-stow
mkdir $HOME/stow
mkdir $HOME/stow/zsh
# clone my dotfile repo to $HOME/stow
git config --global user.email "hackjack@tutanota.com"
git config --global user.name "hackjack"

# keygen stuff
#https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
# ssh-keygen -t ed25519 -C "hackjack@tutanota.com"
# eval "$(ssh-agent -s)"
# cat ~/.ssh/id_ed25519.pub | clip.exe

# install stow
# https://zoomadmin.com/HowToInstall/UbuntuPackage/stow
sudo apt-get update -y
sudo apt-get install -y stow


# install program that is dependent on ChristianChiarulli zsh config
# https://github.com/ChristianChiarulli/Machfiles/tree/master/zsh/.config/zsh
# https://github.com/ajeetdsouza/zoxide
curl -sS https://webinstall.dev/zoxide | bash
## https://github.com/Schniz/fnm
# curl -fsSL https://fnm.vercel.app/install | bash

# --------------------------------------------------------
# --------------------------------------------------------
# --------------------------------------------------------




# Setting Up Neovim on WSL2 on Ubuntu
# https://evancalz.medium.com/setting-up-neovim-on-wsl2-bf634cac435f
# add the repo
$ sudo add-apt-repository ppa:neovim-ppa/unstable
# update & install
$ sudo apt-get update
$ sudo apt-get install neovim