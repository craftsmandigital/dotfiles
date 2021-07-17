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
intro 'Setting Up a bunch of things: sudo apt install -y ripgrep fd-find ctags miscfiles python3-dev python3-pip rsync shellcheck software-properties-common wbritish wbritish-huge nodejs npm gcc g++ make universal-ctags python3-pygments'
sudo apt install -y fzf ripgrep fd-find ctags miscfiles python3-dev python3-pip rsync shellcheck software-properties-common wbritish wbritish-huge nodejs npm gcc g++ make universal-ctags python3-pygments
sudo select-default-wordlist

sudo pip3 install --upgrade pynvim msgpack flake8 yapf autoflake isort coverage jedi
sudo gem install neovim
sudo npm install -g neovim eslint jsonlint
mkdir -p ~/.local/share/nvim/shada

intro "Installing Spacevim\nAfter install do this:\nlaunch neo-vim to download and install plugins\nLaunch neo-vim and type :VimProcInstall followed by enter, then :UpdateRemotePlugins followed by enter."
curl -sLf https://spacevim.org/install.sh | bash
# launch neo-vim to download and install plugins
# Launch neo-vim and type :VimProcInstall followed by enter, then :UpdateRemotePlugins followed by enter.
rm ~/.SpaceVim.d/init.toml # Copy from my dotfiles later on.


# Creating enviroment structure
mkdir $HOME/.config
# Repo stuff
mkdir $HOME/repos
mkdir $HOME/repos/own
mkdir $HOME/repos/others

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
