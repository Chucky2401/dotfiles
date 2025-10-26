#
# Set cursor depending KEYMAP
#
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
