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

#
# Edit current line in editor
#
: ${ZVM_TMPDIR:=${TMPDIR:-/tmp}}
: ${ZVM_VI_EDITOR:=${EDITOR:-vim}}

function zvm_vi_edit_command_line() {
  # Create a temporary file and save the BUFFER to it
  local tmp_file=$(mktemp ${ZVM_TMPDIR}/zshXXXXXX)

  # Some users may config the noclobber option to prevent from
  # overwriting existing files with the > operator, we should
  # use >! operator to ignore the noclobber.
  echo "$BUFFER" >! "$tmp_file"

  # Edit the file with the specific editor, in case of
  # the warning about input not from a terminal (e.g.
  # vim), we should tell the editor input is from the
  # terminal and not from standard input.
  "${(@Q)${(z)${ZVM_VI_EDITOR}}}" $tmp_file </dev/tty

  # Reload the content to the BUFFER from the temporary
  # file after editing, and delete the temporary file.
  BUFFER=$(cat "$tmp_file")
  rm "$tmp_file"

  # Exit the visual mode
  case $KEYMAP in
    "visual")
      zle visual-mode
      ;;
  esac
}

zle -N zvm_vi_edit_command_line
bindkey -M visual 'v' zvm_vi_edit_command_line

