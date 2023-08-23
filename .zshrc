# Exports
export ZSH="$HOME/.oh-my-zsh"
#Path for NodeJS Path
export PATH=$PATH:/usr/local/go/bin
export GOBIN=$HOME/.go/bin
export GOPATH=$HOME/.go
export PATH=$PATH:$GOBIN
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.local/bin
export PYENV_ROOT="$HOME/.pyenv"

command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

# ZSH Theme
ZSH_THEME="heapbytes"

# ZSH Plugins
plugins=(
    tmux
    git
    zsh-history-substring-search
    zsh-autosuggestions
    zsh-syntax-highlighting
)

ZSH_TMUX_AUTOSTART=False
ZSH_TMUX_DEFAULT_SESSION_NAME='New Build!'
ZSH_TMUX_CONFIG=~/.tmux.conf

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

autoload -U bashcompinit
bashcompinit

eval "$(pyenv init -)"

# Aliases
unalias gf
alias ip="ip -c"
alias sqlmap="python /opt/Tools/sqlmap-dev/./sqlmap.py"
alias vi='nvim'
alias vim='nvim'
alias py='python'
FORMAT="\nID\t{{.ID}}\nIMAGE\t{{.Image}}\nCOMMAND\t{{.Command}}\nCREATED\t{{.RunningFor}}\nSTATUS\t{{.Status}}\nPORTS\t{{.Ports}}\nNAMES\t{{.Names}}\n"
alias docker_ls='docker container ls --format=$FORMAT'
alias grep='grep --color=always'
alias colorMe='highlight -O xterm256'
alias docker_cls=' docker rm $(docker ps --filter status=exited -q)'
