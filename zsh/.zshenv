export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}
export ZDOTDIR=${ZDOTDIR:=${XDG_CONFIG_HOME}/zsh}
if command -v vim > /dev/null; then export EDITOR=${EDITOR:="vim"}; fi
if command -v nvim > /dev/null; then export EDITOR=${EDITOR:="nvim"}; alias vim="nvim"; alias vi="nvim"; fi
if command -v emacs > /dev/null; then export EDITOR=${EDITOR:="emacsclient -tca ''"};  fi
alias e=$EDITOR
bindkey -e
source $ZDOTDIR/.zshrc
