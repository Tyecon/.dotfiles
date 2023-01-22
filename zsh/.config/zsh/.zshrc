export ZSH="$HOME/.oh-my-zsh"
plugins=(
    git
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
    colored-man-pages
    command-not-found
    docker
    npm
    sudo
    systemd
    archlinux
    emacs
    tmux
)
ZSH_TMUX_AUTOSTART=true
source $ZSH/oh-my-zsh.sh
