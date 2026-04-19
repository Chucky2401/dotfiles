function start_ssh_agent() {
  HOME_SSH_SOCK="${HOME}/.ssh/ssh_auth.sock"
  HOME_SSH_PID="${HOME}/.ssh/ssh_agent.pid"

  if [ -z "$SSH_AGENT_PID" ]; then
    SSH_AGENT_PID=$(cat "$HOME_SSH_PID")
  fi

  if ! kill -0 $SSH_AGENT_PID &>/dev/null; then
    rm "$HOME_SSH_SOCK" &>/dev/null
    message "Starting SSH agent..."
    eval $(ssh-agent -a "$HOME_SSH_SOCK") &>/dev/null
    echo "$SSH_AGENT_PID" >"$HOME_SSH_PID"
    # ssh-add -k
    while IFS= read -r -d '' keyfile; do
      if grep -qE "^-----BEGIN (OPENSSH|RSA|EC|DSA) PRIVATE KEY-----" "$keyfile"; then
        message "Add key: $keyfile"
        # echo "$keyfile"
        SSH_ASKPASS_REQUIRE=never ssh-add -q "$keyfile"
      fi
    done < <(find ~/.ssh -maxdepth 1 -type f -print0)
    success_message "SSH agent start with '$HOME_SSH_SOCK'"
  # else
  #   message "SSH agent on '$HOME_SSH_SOCK' ($(cat $HOME_SSH_PID))"
  fi

  export SSH_AUTH_SOCK="$HOME_SSH_SOCK"
  export SSH_AGENT_PID=$SSH_AGENT_PID
}
