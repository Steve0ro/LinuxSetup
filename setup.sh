#!/bin/bash

sudo chown -R $USER:$USER /opt
sudo mkdir -p /opt/Tools/

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

# Detecting sudo, used with docker builds
command_exists() {
  command -v "$1" >/dev/null 2>&1
}
if command_exists apt; then
  echo -en "${info} sudo detected.\n"
  package_manager="sudo"
fi

# Pyenv and other packages
sudo apt update -y && sudo apt upgrade -y && sudo apt update --fix-missing

sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev git highlight gdb wget tmux curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev git libfuse2 gron jq binwalk foremost hexedit zsh cargo unzip tar unrar gron httpie libfuse2 highlight gcc iputils-ping yara jq gron wget apt-transport-https software-properties-common zip zsh binwalk llvm build-essential  libssl-dev zlib1g-dev libbz2-dev libreadline-dev vim libsqlite3-dev curl libncursesw5-dev xz-utils  tk-dev tmux git libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev cargo  grep bgrep ngrep hexedit highlight libfuse2 libguestfs-tools  libpoppler-cpp-dev ltrace make libsqlite3-dev libncurses5-dev net-tools openjdk-17-jdk openjdk-17-jre  p7zip-full p7zip-rar poppler-utils reglookup sqlite3-tools tar tshark unrar unzip 

sudo sudo apt-get update --fix-missing && source /etc/os-release && wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb && sudo dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb && sudo apt-get update && sudo apt-get install -y powershell && sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata && sudo apt-get autoclean -y && sudo apt-get autoremove -y


curl https://pyenv.run | bash

# Install xq
curl -sSL https://bit.ly/install-xq | sudo bash

# Astronvim
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod 755 ./nvim.appimage
sudo mv nvim.appimage /usr/bin/nvim

## NodeJS
node_version=$(curl -sn https://nodejs.org/en/download | grep -Eo 'v[0-9]{2}\.[0-9]{2}\.[0-9]{1}\/node-v[0-9]{2}\.[0-9]{2}\.[0-9]-linux-x64.tar.xz' | sort -u)
n2=$(echo $node_version | grep -Eo 'node-v[0-9]{2}\.[3-9]{2}\.[0-9]-linux-x64.tar.xz')
wget https://nodejs.org/dist/$node_version
sudo mkdir -p /usr/local/lib/nodejs
sudo tar -xJvf $n2 -C /usr/local/lib/nodejs

## Go
go_version=$(curl -sn https://go.dev/dl/ | grep -Eo 'go1\.21+\.[3-9]+\.linux-amd64\.tar\.gz' | sort -u)
wget https://go.dev/dl/$go_version
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $go_version
sudo apt dist-upgrade -y && sudo apt autoclean -y sudo && apt autoremove -y

# Oh My ZSH install
echo "Y" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

# Tools
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git /opt/Tools/sqlmap-dev
git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim\

#echo "export PATH=/usr/local/lib/nodejs/$n2/bin:$PATH" >> ~/.zshrc.main.bak

# 
mv ./steve0ro.zsh-theme ~/.oh-my-zsh/themes/
mv ./.zshrc ~/.zshrc

source ~/.zshrc

echo 'Build Done!'

exit

