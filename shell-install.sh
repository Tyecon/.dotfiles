#First: git pull from outside of script

#guix
if command -v guix > /dev/null; then
    sudo guix pull
    #sudo guix install curl stow neofetch zsh emacs
    #sudo guix profile load ./guix/home-config.scm
fi

#pacman
if command -v pacman > /dev/null; then
    sudo pacman -Syu
    sudo pacman -S curl stow neofetch zsh tmux nvim perl awk sed
fi

#stow
if command -v zsh > /dev/null; then stow zsh; fi
if command -v tmux > /dev/null; then stow tmux; fi
if command -v guix > /dev/null; then stow guix; fi
if command -v nvim > /dev/null; then stow nvim; fi
if command -v emacs > /dev/null; then stow emacs; fi

#zsh
if command -v zsh > /dev/null; then
    command -v zsh | sudo tee -a /etc/shells
    sudo chsh -s $(command -v zsh) $USER
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

#tmux
if command -v tmux > /dev/null; then
    command -v tmux | sudo tree -a /etc/shells
    sudo chsh -s $(command -v zsh) $USER

fi
