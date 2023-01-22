export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}
export ZDOTDIR=${ZDOTDIR:=${XDG_CONFIG_HOME}/zsh}
export EDITOR=${EDITOR:="vim"}
export VISUAL=${VISUAL:="emacsclient -t -a emacs -nw"}
bindkey -e
