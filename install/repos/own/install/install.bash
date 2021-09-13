# Start installscript

# This is for a tottaly fresh install of ubuntu wsl2. Git and Git credentials is not configured.

# curl -L https://raw.githubusercontent.com/craftsmandigital/dotfiles/master/install/repos/own/install/install.bash > /tmp/install.bash
# chmod +x /tmp/install.bash
# /tmp/install.bash # runs the schript

###############################################
# zsh config is stolen from https://github.com/ChristianChiarulli/Machfiles/tree/master/zsh/.config/zsh
#Installing ubuntu 20 config

function intro(){
  read -p "\n\n\nControl every step.\nPress any key to resume ...\n\n\n"
  echo -e "\n\n\n\n#########################################################################################################"
  echo -e "#########     $1"
  echo '#########################################################################################################'
}

intro "Update Ubuntu"
sudo apt update -y
intro "Upgrade Ubuntu"
sudo apt upgrade -y



intro "Setting environment variables"

EMAIL='hackjack@tutanota.com'
USR='hackjack'
GITHUBPROFILE='craftsmandigital'


intro "Config git username and email"
git config --global user.email $EMAIL
git config --global user.name $USR


intro "keygen stuff, Credentials for github"
#https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
echo "Enter password for SSH key encryption"
ssh-keygen -t ed25519 -C $EMAIL
eval "$(ssh-agent -s)"
# Copy ssh key to clipoard
cat ~/.ssh/id_ed25519.pub | clip.exe
# opening browser page for creating a new ssh key on github
wslview https://github.com/settings/keys
read -p "The ssh key is copied to the clipboard\nPaste ssh key when creating a new ssh key in the github web page\nSave ssh key\nPress any key to resume ..."


intro 'Install and Setup Zsh in Ubuntu 20.04'
# How to Install and Setup Zsh in Ubuntu 20.04
# https://www.tecmint.com/install-zsh-in-ubuntu/
sudo apt install zsh -y
# make ZSH our default shell. Use the “chsh” command with '-s' flag to switch the default shell for the user.
# https://www.tecmint.com/install-zsh-in-ubuntu/
chsh -s $(which zsh)
# NB! NB! Now to use the new zsh shell, log out of the terminal and log in again
# moving my dotfiles from ~ to .config. This was done when I instlled dotfiles
# telling the system that my startup file is moved to .config
echo 'export ZDOTDIR=$HOME/.config/zsh' > $HOME/.zshenv #all config in .config folder
# rm $HOME/.zshrc # Remove startup from installation

intro 'install program that is dependent on ChristianChiarulli zsh config witch I have copied zoxide'
# https://github.com/ChristianChiarulli/Machfiles/tree/master/zsh/.config/zsh
# https://github.com/ajeetdsouza/zoxide
# curl -sS https://webinstall.dev/zoxide | bash
curl -sS https://webinstall.dev/zoxide > /tmp/zoxide.bash
chmod +x /tmp/zoxide.bash
/tmp/zoxide.bash
## https://github.com/Schniz/fnm
# curl -fsSL https://fnm.vercel.app/install | bash

# --------------------------------------------------------
# --------------------------------------------------------
# --------------------------------------------------------

intro 'Setting Up Neovim on WSL2 on Ubuntu'
# https://evancalz.medium.com/setting-up-neovim-on-wsl2-bf634cac435f
# add the repo
# sudo add-apt-repository -y ppa:neovim-ppa/unstable
sudo add-apt-repository -y ppa:neovim-ppa/stable
# update & install
sudo apt-get update -y
sudo apt-get install -y neovim
nvim --version


# Install fzf from git
intro 'Install fzf form git'
git clone git@github.com:junegunn/fzf.git ~/repos/others/fzf
~/repos/others/fzf/install

# bunc of stuff from this gist
# https://gist.github.com/HouzuoGuo/9a48c6d28b90a16434ccfbdd9d9e4065
intro 'Setting Up a bunch of things: sudo apt install -y ripgrep fd-find ctags nodejs npm gcc g++ make universal-ctags'
sudo apt install -y unzip ripgrep fd-find ctags gcc g++ make universal-ctags
# sudo select-default-wordlist

#sudo pip3 install --upgrade pynvim msgpack flake8 yapf autoflake isort coverage jedi
#sudo gem install neovim
#sudo npm install -g neovim eslint jsonlint
#mkdir -p ~/.local/share/nvim/shada

intro 'Installing node and npm'
# Using Ubuntu
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g npm@7.20.5

intro 'Installing lazygit'
sudo add-apt-repository -y ppa:lazygit-team/release
sudo apt-get -y update
sudo apt-get -y install lazygit


intro "Stuff to paste windows clipboard to vim"
# https://github.com/microsoft/WSL/issues/4440
curl -sLo /tmp/win32yank.zip
https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe ~/.local/bin


intro "Installing Spacevim\nAfter install do this:\nlaunch neo-vim to download and install plugins\nLaunch neo-vim and type :VimProcInstall followed by enter, then :UpdateRemotePlugins followed by enter."
curl -sLf https://spacevim.org/install.sh | bash
# launch neo-vim to download and install plugins
read -p "Launching neo-vim,type :VimProcInstall followed by enter, then :UpdateRemotePlugins followed by enter. Exit neovim. Pres any key to continue ..."
nvim
rm ~/.SpaceVim.d/init.toml # Copy from my dotfiles later on.
mkdir ~/.SpaceVim.d/autoload # make folder to denie stow to symlink autoload folder.
# because of a bug vith spellcheck in other languages than english
# https://github.com/SpaceVim/SpaceVim/issues/3051
mkdir ~/.SpaceVim.d/spell
intro "Fixing ugly error message in Vim"
cd ~/.SpaceVim/bundle/vimproc.vim
make
cd ~


# Creating enviroment structure
# mkdir $HOME/.config
mkdir $HOME/.config/zsh
# Repo stuff
# mkdir $HOME/repos
mkdir $HOME/repos/own
# mkdir $HOME/repos/others

intro "install stow"
# https://zoomadmin.com/HowToInstall/UbuntuPackage/stow
sudo apt-get update -y
sudo apt-get install -y stow


intro 'Downoload my dotfiles from git'
echo 'First time on git. Please copy and fill in the fingerprint prashe'
git clone git@github.com:$GITHUBPROFILE/dotfiles.git ~/stow
intro 'Spread dotfiles to the right places with stow'
# Here you can read more about stow
# https://paramdeo.com//blog/managing-dotfiles-with-git-and-gnu-stow
cd ~/stow
stow */ # Everything (the '/' ignores the README)
cd ~

intro 'Installing PHP'
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install -y php8.0

intro 'Installing remark and prettier formating for markdown files'
sudo npm -g install remark
sudo npm -g install remark-cli
sudo npm -g install remark-stringify
sudo npm -g install remark-frontmatter
sudo npm -g install wcwidth
sudo npm install --global prettier
