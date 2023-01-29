# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
PROMPT="%~> "
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
)
ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.config/zsh/.p10k.zsh.
[[ ! -f ~/.dotfiles/zsh/.config/zsh/.p10k.zsh ]] || source ~/.dotfiles/zsh/.config/zsh/.p10k.zsh
