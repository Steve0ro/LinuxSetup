#!/bin/bash

chown -R $USER:$USER /opt
mkdir -p /opt/Tools/

# Colors
cyan='\e[96m'
red='\e[91m'
green='\e[92m'
default='\e[0m'
yellow='\e[93m'

# Legends
info="${cyan}[${yellow}*${cyan}]${default}"
success="${cyan}[${green}+${cyan}]${default}"
error="${cyan}[${red}!${cyan}]${default}"

# Detecting package manager
command_exists() {
  command -v "$1" >/dev/null 2>&1
}
if command_exists apt; then
  echo -en "${info} APT package manager detected.\n"
  package_manager="apt install"
fi

# Pyenv and other packages
apt update -y && apt upgrade -y && apt update --fix-missing

apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git libfuse2 gron jq binwalk foremost hexedit zsh cargo unzip tar unrar gron httpie libfuse2 highlight

curl https://pyenv.run | bash

# Install xq
curl -sSL https://bit.ly/install-xq | bash

# Astronvim
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage

chmod 755 ./nvim.appimage
mv nvim.appimage /usr/bin/nvim


## NodeJS
node_version=$(curl -sn https://nodejs.org/en/download | grep -Eo 'v[0-9]{2}\.[0-9]{2}\.[0-9]{1}\/node-v[0-9]{2}\.[0-9]{2}\.[0-9]-linux-x64.tar.xz' | sort -u)

n2=$(echo $node_version | grep -Eo 'node-v[0-9]{2}\.[0-9]{2}\.[0-9]-linux-x64.tar.xz')

wget https://nodejs.org/dist/$node_version
mkdir -p /usr/local/lib/nodejs
tar -xJvf $n2 -C /usr/local/lib/nodejs

## Go
go_version=$(curl -sn https://go.dev/dl/ | grep -Eo 'go1\.20+\.[7-9]+\.linux-amd64\.tar\.gz' | sort -u)

wget https://go.dev/dl/$go_version
rm -rf /usr/local/go && tar -C /usr/local -xzf $go_version

apt dist-upgrade -y && apt autoclean -y && apt autoremove -y


# Oh My ZSH install

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# Tools
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git /opt/Tools/sqlmap-dev

git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim\

#git clone https://github.com/Steve0ro/Empty/For/Now ~/.zshrc.main.bak
echo "export PATH=/usr/local/lib/nodejs/$n2/bin:$PATH" >> ~/.zshrc.main.bak

