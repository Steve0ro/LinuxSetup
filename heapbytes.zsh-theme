#Author : Heapbytes <Gourav> (https://github.com/heapbytes)
# Modified by Steve0ro to use ip command instead of ifconfig

PROMPT='
┌─[%F{blue} %~%f] [%F{green} $(get_ip_address)%f] $(git_prompt_info)
└─➜ '

RPROMPT='[%F{red}%?%f]'

get_ip_address() {
  if [[ -n "$(ip -4 addr show dev tun0 2>/dev/null)" ]]; then
    echo "%{$fg[green]%}$(ip -4 addr show dev tun0 | awk '/inet / {print $2}')%{$reset_color%}"
  elif [[ -n "$(ip -4 addr show dev wlan0 2>/dev/null)" ]]; then
    echo "%{$fg[green]%}$(ip -4 addr show dev wlan0 | awk '/inet / {print $2}')%{$reset_color%}"
  else
    echo "%{$fg[red]%}No IP%{$reset_color%}"
  fi
}

