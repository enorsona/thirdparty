export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

ZSH_THEME="fino-time"

plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Alias
alias v='sudo vim'
alias dls='sudo docker ps'
alias dstop='sudo docker stop '
alias drm='sudo docker rm '
alias drmi='sudo docker rmi '
alias drestart='sudo docker restart '
alias dstart='sudo docker start '
alias dpull='sudo docker pull '
alias conf='v ~/.zshrc'
alias sconf='cat ~/.zshrc'
alias reload='exec $SHELL'
alias senable='sudo systemctl enable '
alias senablen='sudo systemctl enable --now '
alias srestart='sudo systemctl restart '
alias sstatus='sudo systemctl status '
alias sstart='sudo systemctl start '
alias sdisable='sudo systemctl disable '
alias sstop='sudo systemctl stop '
alias sreload='sudo systemctl reload '
alias dreload='sudo systemctl daemon-reload'
alias rbn='sudo reboot now'
alias stn='sudo shutdown now'
alias update='sudo pacman -Syyu --noconfirm'
alias force-update='sudo pacman -Syyuu --noconfirm'
alias install='sudo pacman -S --noconfirm '
alias search='sudo pacman -Ss '
alias installed='sudo pacman -Q'
alias has='sudo pacman -Q | grep '
alias purge='sudo pacman -Rns $(sudo pacman -Qtdq)'
