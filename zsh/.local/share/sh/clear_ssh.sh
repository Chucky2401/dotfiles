#!/usr/bin/env zsh

clear_ssh() {
  typeset -l startSshAgent
  startSshAgent="n"

  message "Kill ssh agent..."
  pkill ssh-agent
  killStatus=$?

  if [[ $rmStatus -ne 0 ]]; then
    error_message "Cannot kill the SSH agent. Aborting!"
    exit 1
  fi

  message "Cleaning ssh agent..."
  message "Remove files in ~/.ssh..."

  rm -f ~/.ssh/ssh_a*
  rmStatus=$?

  if [[ $rmStatus -eq 0 ]]; then
    success_message "Files ~/.ssh/ssh_a* have been remove successfully!"
  else
    error_message "Files ~/.ssh/ssh_a* don't have been remove successfully!"
    exit 1
  fi

  message "Unset SSH agent environment variables..."

  sshEnvVar=('SSH_AGENT_PID' 'SSH_AUTH_SOCK')
  for i in "${sshEnvVar[@]}"; do
    unset $i
    unsetStatus=$?

    if [[ $unsetStatus -ne 0 ]]; then
      error_message "Environment variable ${i} doesn't have been unset successfully!"
      exit 1
    fi
  done

  message "SSH agent environment variables have been removed successfully!"

  echo -n "Would you like to start the SSH agent? "
  read -r startSshAgent

  if [[ "${startSshAgent}" -eq "o" ]]; then
    start_ssh_agent
  fi
}
