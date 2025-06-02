function start_ssh_agent() {
  HOME_SSH_SOCK="${HOME}/.ssh/ssh_auth.sock"
  HOME_SSH_PID="${HOME}/.ssh/ssh_agent.pid"

  if [ -z "$SSH_AGENT_PID" ]; then
    SSH_AGENT_PID=$(cat "$HOME_SSH_PID" &>/dev/null)
  fi

  if ! kill -0 $SSH_AGENT_PID &>/dev/null; then
    rm "$HOME_SSH_SOCK" &>/dev/null
    message "Starting SSH agent..."
    eval $(ssh-agent -a "$HOME_SSH_SOCK") &>/dev/null
    echo "$SSH_AGENT_PID" >"$HOME_SSH_PID"
    ssh-add -k
    success_message "SSH agent start with '$HOME_SSH_SOCK'"
  else
    message "SSH agent on '$HOME_SSH_SOCK' ($(cat $HOME_SSH_PID))"
  fi

  export SSH_AUTH_SOCK="$HOME_SSH_SOCK"
  export SSH_AGENT_PID
}
