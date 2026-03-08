ftmux() {
  TMUX_PATH=$(where -p tmux)

  if [[ -z "$@" ]]; then
    echo "$TMUX_PATH a &>/dev/null || $TMUX_PATH"
    return
  fi

  echo "$TMUX_PATH $@"
}
