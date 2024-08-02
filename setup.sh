#!/bin/bash

sudo mkdir -p /opt/Tools/
sudo chown -R $(whoami):$(whoami) /opt/
sudo chmod -R 755 /opt/Tools/

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

sudo apt update -y && sudo apt upgrade -y && sudo apt update --fix-missing

sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev git highlight gdb wget tmux curl llvm libncurses5-dev zsh libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev libfuse2 gron jq network-manager binwalk foremost hexedit cargo unzip tar unrar httpie zip vim libxml2-dev libxmlsec1-dev libguestfs-tools libpoppler-cpp-dev ltrace net-tools openjdk-17-jdk openjdk-17-jre p7zip-full p7zip-rar poppler-utils reglookup sqlite3-tools tshark

# Install PowerShell Core 7+
sudo sudo apt-get update --fix-missing && source /etc/os-release && wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb && sudo dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb && sudo apt-get update && sudo apt-get install -y powershell && sudo ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && sudo dpkg-reconfigure --frontend noninteractive tzdata && sudo apt-get autoclean -y && sudo apt-get autoremove -y

curl https://pyenv.run | bash

# Install xq
curl -sSL https://bit.ly/install-xq | sudo bash

# NodeJS
node_version=$(curl -sn https://nodejs.org/dist/latest/ | grep -Eo 'node-v[0-9]+\.[0-9]+\.[0-9]+-linux-x64\.tar\.xz' | sort -u)
wget https://nodejs.org/dist/latest/$node_version
sudo mkdir -p /usr/local/lib/nodejs
sudo tar -xJvf $node_version -C /usr/local/lib/nodejs

# Go
go_version=$(curl -sn https://go.dev/dl/ | grep -Eo 'go[0-9]+\.[0-9]+\.[0-9]+\.linux-amd64\.tar\.gz' | sort -V | tail -n 1 )
wget https://go.dev/dl/$go_version
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf $go_version
sudo apt dist-upgrade -y && sudo apt autoclean -y && sudo apt autoremove -y

sudo rm -rf $go_version $node_version

# Switch to zsh and run Oh My Zsh installation
zsh <<'EOF'
  echo "Y" | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
  git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
  mv ./steve0ro.zsh-theme ~/.oh-my-zsh/themes/
  mv ./.zshrc.bak ~/.zshrc
  . ~/.zshrc
EOF

# Github Tools
GIT_URLS_FILE="./git_urls.txt"

if [[ ! -f "$GIT_URLS_FILE" ]]; then
  echo "File $GIT_URLS_FILE not found!"
  exit 1
fi

while read -r url
do
  if [[ -n "$url" ]]; then
    repo_name=$(basename "$url" .git)
    echo "Cloning repository: $url into /opt/Tools/$repo_name"
    sudo git clone "$url" "/opt/Tools/$repo_name"
  fi
done < "$GIT_URLS_FILE"

# Github Tools
GO_TOOLS="./go_tools.txt"

if [[ ! -f "$GO_TOOLS" ]]; then
  echo "File $GO_TOOLS not found!"
  exit 1
fi

export GO111MODULE=on

while read -r go_tool
do
  if [[ -n "$go_tool" ]]; then
    repo_name=$(basename "$go_tool")
    go install "$go_tool"
  fi
done < "$GO_TOOLS"

echo "All modules installed successfully."
echo ""
echo 'Build Done!'

exit