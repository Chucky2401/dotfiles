ftmux() {
  TMUX_PATH=$(where -p tmux | head -n 1)

  if [[ -z "$@" ]]; then
    echo "$TMUX_PATH a &>/dev/null || $TMUX_PATH"
    return
  fi

  echo "$TMUX_PATH $@"
}
