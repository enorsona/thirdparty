export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PYM="/media/SYNC/SERVICE/A2PY/"
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

ZSH_THEME="fino-time"

plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source ~/.zshrc_r

# Alias

#
# docker related
#
alias v='sudo nvim'
alias dls='sudo docker ps'
alias dstop='sudo docker stop'
alias drm='sudo docker rm'
alias drmi='sudo docker rmi'
alias drestart='sudo docker restart'
alias dstart='sudo docker start'
alias dpull='sudo docker pull'

#
# zsh related
#
alias lan='sudo iwctl'
alias conf='v ~/.zshrc'
alias sconf='cat ~/.zshrc'
alias reload='exec $SHELL'
alias packagezsh='7z a omz.7z ~/.oh-my-zsh'
alias gui='Hyprland'
alias hyconf='v ~/.config/hypr/hyprland.conf'

#
# systemctl related
#
alias senable='sudo systemctl enable '
alias senablen='sudo systemctl enable --now '
alias srestart='sudo systemctl restart '
alias sstatus='sudo systemctl status '
alias sstart='sudo systemctl start '
alias sdisable='sudo systemctl disable '
alias sstop='sudo systemctl stop '
alias sreload='sudo systemctl reload '
alias dreload='sudo systemctl daemon-reload'

#
# arch related
#
alias mt='sudo mount'
alias umt='sudo umount'
alias del='sudo rm -r'
alias rbn='sudo reboot now'
alias stn='sudo shutdown now'
alias update='sudo pacman -Syyu'
alias force-update='sudo pacman -Syyuu'
alias install='sudo pacman -S'
alias get='sudo pacman -S'
alias search='sudo pacman -Ss'
alias installed='sudo pacman -Q'
alias drop='sudo pacman -R'
alias has='sudo pacman -Q | grep'
alias purge='sudo pacman -Rns $(sudo pacman -Qtdq)'

#
# python related
# 
alias mkvenv='python -m venv .venv'
alias rmvenv='sudo rm -r .venv'
alias py='python'

runvd() {
    local target_dir="${1:-./.venv}" # 有参数时使用参数
    local venv_dir="$target_dir"
    if [[ -d "$venv_dir" ]]; then
        echo "尝试激活虚拟环境: $venv_dir"
        source "$venv_dir/bin/activate"
    else
        echo "未找到虚拟环境目录，请确认$target_dir是否是正确的虚拟环境目录"
    fi
}

