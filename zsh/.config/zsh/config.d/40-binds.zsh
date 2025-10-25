# Keybindings
bindkey -v
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# Useless if PuTTy set with 'xterm' for Home and End keys
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]]; then
    echo -ne '\e[2 q'  # Curseur bloc
  else
    echo -ne '\e[6 q'  # Curseur barre
  fi
}

function zle-line-init {
  echo -ne '\e[6 q'  # Barre au démarrage (insertion)
}

zle -N zle-keymap-select
zle -N zle-line-init

autoload -Uz add-zsh-hook
add-zsh-hook precmd zle-keymap-select
